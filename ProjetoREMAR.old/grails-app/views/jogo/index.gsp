
<%@ page import="projetoremar.Jogo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jogo.label', default: 'Jogo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-jogo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-jogo" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="categoria" title="${message(code: 'jogo.categoria.label', default: 'Categoria')}" />
					
						<g:sortableColumn property="contribuicao" title="${message(code: 'jogo.contribuicao.label', default: 'Contribuicao')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'jogo.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="dica" title="${message(code: 'jogo.dica.label', default: 'Dica')}" />
					
						<g:sortableColumn property="icone" title="${message(code: 'jogo.icone.label', default: 'Icone')}" />
					
						<g:sortableColumn property="nome" title="${message(code: 'jogo.nome.label', default: 'Nome')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jogoInstanceList}" status="i" var="jogoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jogoInstance.id}">${fieldValue(bean: jogoInstance, field: "categoria")}</g:link></td>
					
						<td>${fieldValue(bean: jogoInstance, field: "contribuicao")}</td>
					
						<td><g:formatDate date="${jogoInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: jogoInstance, field: "dica")}</td>
					
						<td>${fieldValue(bean: jogoInstance, field: "icone")}</td>
					
						<td>${fieldValue(bean: jogoInstance, field: "nome")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jogoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
