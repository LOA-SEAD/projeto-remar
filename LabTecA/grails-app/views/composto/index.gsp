
<%@ page import="br.ufscar.sead.loa.labteca.remar.Composto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'composto.label', default: 'Composto')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-composto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-composto" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="formula" title="${message(code: 'composto.formula.label', default: 'Formula')}" />
					
						<g:sortableColumn property="tipo" title="${message(code: 'composto.tipo.label', default: 'Tipo')}" />
					
						<g:sortableColumn property="nome" title="${message(code: 'composto.nome.label', default: 'Nome')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${compostoInstanceList}" status="i" var="compostoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${compostoInstance.id}">${fieldValue(bean: compostoInstance, field: "formula")}</g:link></td>
					
						<td>${fieldValue(bean: compostoInstance, field: "tipo")}</td>
					
						<td>${fieldValue(bean: compostoInstance, field: "nome")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${compostoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
