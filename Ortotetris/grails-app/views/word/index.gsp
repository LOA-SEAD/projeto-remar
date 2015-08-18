<%@ page import="br.ufscar.sead.loa.remar.Word" %>
%{--<%@ page contentType="text/html;charset=UTF-8" %>--}%
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>

	<link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}"	type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}"	type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'external-styles.css')}"	type="text/css">
	<script type="text/javascript" src="${resource(dir: 'js', file: 'principal.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'order.js')}"></script>
	<title>Ortotetris</title>
	<nav></nav>
	<h1 align="center">Ortotetris</h1>
</head>

<body>



<section id="ShowWord" style="height: 250px;">

</section>

<div id="MessageDiv" align="center" style="height: 10px;" class="message">
	<g:render template="message"/>
</div>


<aside style=" display:block; background-color: rgb(255, 255, 255); width: 100%; height: 50px;">
	<h3 style="display: inline-block">Lista de Palavras</h3>
	<button id="CreateWordButton" onclick="createNewWord()"  ><i class="material-icons">add_circle_outline</i></button>
	<button id="SearchButton"><i class="material-icons">search</i></button>
	<button id="SaveButton" onclick="allToJson()"><i class="material-icons">save</i></button>
</aside>
<input  class="search-box" type="text" id="SearchLabel"  placeholder="Buscar nesta lista"/>


<section id="TableWordList" style="height: 300px; overflow: auto">
	<g:render template="list"/>
</section>


<script type="text/javascript" defer="defer">

	function right(id){
		var parameters = {"id": id}
		<g:remoteFunction action="move_to_right" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
	}

	function left(id){
		var parameters = {"id": id}
		<g:remoteFunction action="move_to_left" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>

	}

	function mark_letter(id,pos){
		var parameters = {"id": id, "pos":pos}
		<g:remoteFunction action="mark_letter" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
	}

	function clear_letter(id,pos){
		var parameters = {"id": id, "pos":pos}
		<g:remoteFunction action="clear_position" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
	}

	function allToJson(){
		<g:remoteFunction action="toJsonAnswer" update="MessageDiv"/>
		<g:remoteFunction action="toJsonWord" update="MessageDiv" />
	}

	function SaveNewWord(){
		var ans = document.getElementById("NewWordLabel").value
		var node = document.getElementById("ShowWord")
		var parameters = {"answer": ans, "word": "none", "initial_position":0}
		<g:remoteFunction action="save" params="parameters" update="TableWordList"/>
	}

	function UpdateWord(id){
		var ans = document.getElementById("EditWordLabel").value
		var parameters = {"id":id, "new_answer": ans}
		<g:remoteFunction action="editWord" params="parameters" update="TableWordList"/>
	}

	function WordDelete(id){
		if(confirm("Você tem certeza?")){
			var parameters = {"id":id}
			<g:remoteFunction action="WordDelete" params="parameters" update="TableWordList"/>
		}
	}

</script>

</body>
</html>