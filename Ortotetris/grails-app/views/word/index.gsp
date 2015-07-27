
<%@ page import="br.ufscar.sead.loa.remar.Word" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'word.label', default: 'Word')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}"	type="text/css">
	</head>
	<body>
		<a href="#list-word" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		 
		<div id="ShowWord" style="width: 960px; height: 300px;" > %{--div que exibe a palavra--}%
		</div>


		<div id="tableteste">
			<g:render template="list"/>
		</div>

		<button onclick="createNewWord()">Criar nova palavra</button>
		<button onclick="allToJson()" > SALVAR TUDO </button>

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
			<g:remoteFunction action="move_to_right" params="parameters" update="tableteste" onComplete="AutoClickButton(id)"/>
		}

		function left(id){
			var parameters = {"id": id}
			<g:remoteFunction action="move_to_left" params="parameters" update="tableteste" onComplete="AutoClickButton(id)"/>

		}

		function mark_letter(id,pos){
			var parameters = {"id": id, "pos":pos}
			<g:remoteFunction action="mark_letter" params="parameters" update="tableteste" onComplete="AutoClickButton(id)"/>
		}

		function clear_letter(id,pos){
			var parameters = {"id": id, "pos":pos}
			<g:remoteFunction action="clear_position" params="parameters" update="tableteste" onComplete="AutoClickButton(id)"/>
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
			<g:remoteFunction action="save" params="parameters" update="tableteste"/>
		}

		function editWord(id, answer){
			var node = document.getElementById("ShowWord")
			node.innerHTML = "<input class='resizedTextbox' type='text' id='EditWordLabel' value='"+answer+"' onfocus=\"(this.value == '"+answer+"') && (this.value = '')\"onblur=\"(this.value == '') && (this.value = '"+answer+"')\"> </input>"
			node.innerHTML+= " <button class='but-edit' onclick=\"UpdateWord("+id+")\" >Salvar</button> "
		}

		function UpdateWord(id){
			var ans = document.getElementById("EditWordLabel").value
			var parameters = {"id":id, "new_answer": ans}
			<g:remoteFunction action="editWord" params="parameters" update="tableteste"/>
		}
	</script>

	</body>
</html>
