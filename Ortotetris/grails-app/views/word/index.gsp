<%@ page import="br.ufscar.sead.loa.remar.Word" %>
%{--<%@ page contentType="text/html;charset=UTF-8" %>--}%
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>

	<link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}"	type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}"	type="text/css">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'external-styles.css')}"	type="text/css">


	<title>Ortotetris</title>
	<nav></nav>
	<h1 align="center">Ortotetris</h1>
</head>

<body>



<section id="ShowWord" style="height: 250px">

</section>

<aside style="float: left; background-color: rgba(0, 0, 0, 0.14); width: 100px; height: 300px;">
    <button onclick="createNewWord()" class="but" style="top: auto;">+</button>
    <button class="but" style="top: auto;">Buscar</button>
	<button class="but" style="top: auto;">B</button>
	<button class="but" style="top: auto;">S</button>
</aside>

<section id="TableWordList" style="height: 300px; overflow: auto">
	<g:render template="list"/>
</section>


<script type="text/javascript" defer="defer">

	function AutoClickButton(id){
		var button = "#button"+id
		$(button).click();
	}


	function ShowWord(word, answer,initial_position, id) {

		var node = document.getElementById("ShowWord");
		var button_move_right = "<button class='but' onclick=\"right('"+id+"')\" > -----> </button>"
		var button_move_left = "<button class='but' onclick=\"left('"+id+"')\" > \<----- </button>"

		node.innerHTML=""
		node.innerHTML+= button_move_left

		for(var i=0; i<10;i++){
			if(word[i]=="ì")
				node.innerHTML += "<button class='but but-color1' '>" + "-" + "</button>"
			else{
				if(word[i]=="0")
				{
					var button_clear_letter = "<button class='but but-color2' onclick='clear_letter(" + id + "," + (i+1) + ")' > " + answer[i-initial_position] + "</button>"
					node.innerHTML += button_clear_letter
				}
				else
				{
					var button_mark_letter = "<button class='but' onclick='mark_letter(" + id + "," + (i+1) + ")' > " + word[i] + "</button>"
					node.innerHTML += button_mark_letter
				}
			}
		}
		node.innerHTML+= button_move_right
	}

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
		<g:remoteFunction action="toJsonAnswer"/>
		<g:remoteFunction action="toJsonWord" />
	}

	function createNewWord(){
		var node = document.getElementById("ShowWord")
		node.innerHTML = "<input class='resizedTextbox' type='text' id='NewWordLabel' value='Digite a nova palavra aqui' onfocus=\"(this.value == 'Digite a nova palavra aqui') && (this.value = '')\"onblur=\"(this.value == '') && (this.value = 'Digite a nova palavra aqui')\"> </input>"
		node.innerHTML += " <input type=\"hidden\" name=\"word\" value=\"word\"/> "
		node.innerHTML += " <input type=\"hidden\" name=\"initial_position\" value=\"0\"/> "
		node.innerHTML+= " <button class='but-edit' onclick=\"SaveNewWord()\" >Salvar</button> "
	}

	function SaveNewWord(){
		var ans = document.getElementById("NewWordLabel").value
		var node = document.getElementById("ShowWord")
		var parameters = {"answer": ans, "word": "none", "initial_position":0}
		<g:remoteFunction action="save" params="parameters" update="TableWordList"/>
	}

	function editWord(id, answer){
		var node = document.getElementById("ShowWord")
		node.innerHTML = "<input class='resizedTextbox' type='text' id='EditWordLabel' value='"+answer+"' onfocus=\"(this.value == '"+answer+"') && (this.value = '')\"onblur=\"(this.value == '') && (this.value = '"+answer+"')\"> </input>"
		node.innerHTML+= " <button class='but-edit' onclick=\"UpdateWord("+id+")\" >Salvar</button> "
	}

	function UpdateWord(id){
		var ans = document.getElementById("EditWordLabel").value
		var parameters = {"id":id, "new_answer": ans}
		<g:remoteFunction action="editWord" params="parameters" update="TableWordList"/>
	}

    function WordDelete(id){
		if(confirm("Você tem certeza?"))
		{
			var parameters = {"id":id}
			<g:remoteFunction action="WordDelete" params="parameters" update="TableWordList"/>
		}


    }


</script>

</body>
</html>