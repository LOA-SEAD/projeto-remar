
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
		 
		<div id="ShowWord" style="width: 960px; height: 350px;" > %{--div que exibe a palavra--}%

			<script type="text/javascript">
				function ShowWord(word, answer,initial_position, id) {
					var node = document.getElementById("ShowWord");
					var button_move_right = "<button class='but' onclick='right(" + id +")' > Move to right</button>"
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

				function teeeeste(id){
					var node = document.getElementById("ShowWord");
					node.innerHTML="" + id
					var parameters = { "a":id}
					<g:remoteFunction action="teste" params="parameters"   />
				}

				function right(id){
					var parameters = {"id": id}
					<g:remoteFunction action="move_to_right" params="parameters"/>
				}
				function left(id){
					var parameters = {"id": id}
					<g:remoteFunction action="move_to_left" params="parameters"/>
				}

				function mark_letter(id,pos){
					var parameters = {"id": id, "pos":pos}
					<g:remoteFunction action="mark_letter" params="parameters"/>

				}

				function clear_letter(id,pos){
					var parameters = {"id": id, "pos":pos}
					<g:remoteFunction action="clear_position" params="parameters"/>

				}

			</script>



		</div>
	
		<div id="table" style="width:550px; height:350px; overflow: auto;" id="list-word" class="content scaffold-list" role="main" >
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
						<g:sortableColumn property="Editar" title="${message(code: 'word.initial_position.label', default: 'Editar')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${wordInstanceList}" status="i" var="wordInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${wordInstance.id}">${wordInstance.answer.toUpperCase()} </g:link></td>
						<td>${fieldValue(bean: wordInstance, field: "word")}</td>
						<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>
						<td><button onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}','${wordInstance.initial_position}', '${wordInstance.id}')">${wordInstance.answer.toUpperCase()}</button></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${wordInstanceCount ?: 0}" />
			</div>
		</div>
		<g:form controller="word" action="toJsonAnswer">
			<input type="submit" value="ToJsonAnswer" />
		</g:form>
		<g:form controller="word" action="toJsonWord">
			<input type="submit" value="ToJsonWord" />
		</g:form>


	</body>
</html>
