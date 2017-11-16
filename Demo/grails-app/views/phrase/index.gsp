
<%@ page import="br.ufscar.sead.loa.demo.remar.Phrase" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'phrase.label', default: 'Phrase')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-phrase" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-phrase" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="content" title="${message(code: 'phrase.content.label', default: 'Content')}" />
					
						<g:sortableColumn property="ownerId" title="${message(code: 'phrase.ownerId.label', default: 'Owner Id')}" />
					
						<g:sortableColumn property="taskId" title="${message(code: 'phrase.taskId.label', default: 'Task Id')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${phraseInstanceList}" status="i" var="phraseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${phraseInstance.id}">${fieldValue(bean: phraseInstance, field: "content")}</g:link></td>
					
						<td>${fieldValue(bean: phraseInstance, field: "ownerId")}</td>
					
						<td>${fieldValue(bean: phraseInstance, field: "taskId")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${phraseInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
