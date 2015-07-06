
<%@ page import="br.ufscar.sead.loa.remar.Word" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'word.label', default: 'Word')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-word" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-word" class="content scaffold-list" role="main">
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

					</tr>
				</thead>
				<tbody>
				<g:each in="${wordInstanceList}" status="i" var="wordInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${wordInstance.id}">${fieldValue(bean: wordInstance, field: "answer")}</g:link></td>

						<td>${fieldValue(bean: wordInstance, field: "word")}</td>

						<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${wordInstanceCount ?: 0}" />
			</div>
			<g:form controller="word" action="toJsonAnswer">
				<input type="submit" value="ToJsonAnswer" />
			</g:form>
			<g:form controller="word" action="toJsonWord">
				<input type="submit" value="ToJsonWord" />
			</g:form>
		</div>
	</body>
</html>
