
<%@ page import="br.ufscar.sead.loa.remar.ProcessoJogo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'processoJogo.label', default: 'ProcessoJogo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-processoJogo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="jogos">Novo jogo</g:link></li>
			</ul>
		</div>
		<div id="list-processoJogo" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="id_process_definition" title="${message(code: 'processoJogo.id_process_definition.label', default: 'Idprocessdefinition')}" />
					
						<g:sortableColumn property="id_process_instance" title="${message(code: 'processoJogo.id_process_instance.label', default: 'Idprocessinstance')}" />
					
						<th><g:message code="processoJogo.professor.label" default="Professor" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${processoJogoInstanceList}" status="i" var="processoJogoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${processoJogoInstance.id}">${fieldValue(bean: processoJogoInstance, field: "id_process_definition")}</g:link></td>
					
						<td>${fieldValue(bean: processoJogoInstance, field: "id_process_instance")}</td>
					
						<td>${fieldValue(bean: processoJogoInstance, field: "professor")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${processoJogoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
