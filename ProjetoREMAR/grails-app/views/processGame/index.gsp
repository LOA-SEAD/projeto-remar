
<%@ page import="br.ufscar.sead.loa.remar.ProcessGame" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'processGame.label', default: 'ProcessGame')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-processGame" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="jogos">Novo jogo</g:link></li>
			</ul>
		</div>
		<div id="list-processGame" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="id_process_definition" title="${message(code: 'processGame.id_process_definition.label', default: 'Idprocessdefinition')}" />
					
						<g:sortableColumn property="id_process_instance" title="${message(code: 'processGame.id_process_instance.label', default: 'Idprocessinstance')}" />
					
						<th><g:message code="processGame.professor.label" default="Professor" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${processGameInstanceList}" status="i" var="processGameInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${processGameInstance.id}">${fieldValue(bean: processGameInstance, field: "id_process_definition")}</g:link></td>
					
						<td>${fieldValue(bean: processGameInstance, field: "id_process_instance")}</td>
					
						<td>${fieldValue(bean: processGameInstance, field: "professor")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${processGameInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
