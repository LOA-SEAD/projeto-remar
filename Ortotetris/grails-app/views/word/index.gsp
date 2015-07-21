
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
    <div id="bodypage">
		<a href="#list-word" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		 
		<div id="ShowWord" style="width: 960px; height: 350px;" > %{--div que exibe a palavra--}%

			<script type="text/javascript" defer="defer">

				function ShowWord(word, answer,initial_position, id) {

					var node = document.getElementById("ShowWord");
					var button_move_right = "<button class='but' onclick=\"right('"+ word + "','"+ answer +"','" + initial_position+ "','"+ id+"')\" > Move to right</button>"
					var button_move_left = "<button class='but' onclick='left(" + id +")' > Move to left</button>"

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

				function right(word,answer,initial_position,id){
					var elementName="button"+id
					var parameters = {"id": id}
					<g:remoteFunction action="move_to_right" params="parameters"/>
                    location.reload();
                    location.reload();
//                    window.onload=function(){
//                        ShowWord(word,answer,initial_position,id)
//                    }
//					ShowWord("hahahahaha","hahahahaha",0,1)
//					ShowWord("hahahahha",answer,initial_position,id)
//					document.getElementsByName(elementName).click();

				}

                function bla(){
					println("oi")
					ShowWord("hahahahha","hahahaha",0,1)
				}

                function left(id){
					var parameters = {"id": id}
					<g:remoteFunction action="move_to_left" params="parameters"/>
					location.reload();
					location.reload();
				}

				function mark_letter(id,pos){
					var parameters = {"id": id, "pos":pos}
					<g:remoteFunction action="mark_letter" params="parameters"/>
					location.reload();
					location.reload();
				}

				function clear_letter(id,pos){
					var parameters = {"id": id, "pos":pos}
					<g:remoteFunction action="clear_position" params="parameters"/>
					location.reload();
					location.reload();
				}

				function allToJson(){
					<g:remoteFunction action="toJsonAnswer"/>
					<g:remoteFunction action="toJsonWord" />
				}

				function createNewWord(){
					var node = document.getElementById("ShowWord")
					node.innerHTML = "<input type='text' id='NewWordLabel' value='Digite a nova palavra aqui' onfocus=\"(this.value == 'Digite a nova palavra aqui') && (this.value = '')\"onblur=\"(this.value == '') && (this.value = 'Digite a nova palavra aqui')\"> </input>"
					node.innerHTML += " <input type=\"hidden\" name=\"word\" value=\"word\"/> "
					node.innerHTML += " <input type=\"hidden\" name=\"initial_position\" value=\"0\"/> "
					node.innerHTML+= " <button onclick=\"SaveNewWord()\" >Salvar nova palavra</button> "
				}

				function SaveNewWord(){
					var ans = document.getElementById("NewWordLabel").value
					var node = document.getElementById("ShowWord")
					var parameters = {"answer": ans, "word": "bla", "initial_position":0}
					<g:remoteFunction action="save" params="parameters"/>
					location.reload()
					location.reload()
				}



			</script>

		</div>
	
		<div id="table" style="width:960px; height:350px; overflow: auto;" id="list-word" class="content scaffold-list" role="main" >
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
						<g:sortableColumn property="answer" title="${message(code: 'word.answer.label', default: 'Answer')}" />
						<g:sortableColumn property="word" title="${message(code: 'word.word.label', default: 'Word')}" />
						<g:sortableColumn property="initial_position" title="${message(code: 'word.initial_position.label', default: 'Initialposition')}" />
						<g:sortableColumn property="Personalizar" title="${message(code: 'word.initial_position.label', default: 'Personalizar')}" />
						<g:sortableColumn property="Editar" title="${message(code: 'word.initial_position.label', default: 'Editar')}" />
						<g:sortableColumn property="Remover" title="${message(code: 'word.initial_position.label', default: 'Remover')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${wordInstanceList}" status="i" var="wordInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${wordInstance.id}">${wordInstance.answer.toUpperCase()} </g:link></td>
						<td>${fieldValue(bean: wordInstance, field: "word")}</td>
						<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>
						<td><button name="button${wordInstance.id}" onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}',${wordInstance.initial_position}, ${wordInstance.id})">PERSONALIZAR</button></td>
						<td>
							<fieldset class="buttons">
								<g:link class="edit" action="edit" resource="${wordInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
							</fieldset>
						</td>
						<td>
							<g:form url="[resource:wordInstance, action:'delete']" method="DELETE">
								<fieldset class="buttons">
									<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
								</fieldset>
							</g:form>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${wordInstanceCount ?: 0}" />
			</div>
		</div>

        <button onclick="allToJson()" > SALVAR TUDO </button>
        <button onclick="createNewWord()">Criar nova palavra</button>

	</div>
	</body>
</html>
