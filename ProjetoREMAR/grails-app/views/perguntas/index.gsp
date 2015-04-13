
<%@ page import="escolamagica.Perguntas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'perguntas.label', default: 'Perguntas')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-perguntas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-perguntas" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="classe" title="${message(code: 'perguntas.classe.label', default: 'Classe')}" />
					
						<g:sortableColumn property="respCorreta" title="${message(code: 'perguntas.respCorreta.label', default: 'Resp Correta')}" />
					
						<g:sortableColumn property="resp" title="${message(code: 'perguntas.resp.label', default: 'Resp')}" />
					
						<g:sortableColumn property="titulo" title="${message(code: 'perguntas.titulo.label', default: 'Titulo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${perguntasInstanceList}" status="i" var="perguntasInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${perguntasInstance.id}">${fieldValue(bean: perguntasInstance, field: "classe")}</g:link></td>
					
						<td>${fieldValue(bean: perguntasInstance, field: "respCorreta")}</td>
					
						<td>${fieldValue(bean: perguntasInstance, field: "resp")}</td>
					
						<td>${fieldValue(bean: perguntasInstance, field: "titulo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
                <g:link action="createXML">Finalizar</g:link>
				<g:paginate total="${perguntasInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
