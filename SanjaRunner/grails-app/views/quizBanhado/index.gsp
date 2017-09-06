
<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizBanhado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quizBanhado.label', default: 'QuizBanhado')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quizBanhado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quizBanhado" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="question" title="${message(code: 'quizBanhado.question.label', default: 'Question')}" />
					
						<g:sortableColumn property="answers" title="${message(code: 'quizBanhado.answers.label', default: 'Answers')}" />
					
						<g:sortableColumn property="correctAnswer" title="${message(code: 'quizBanhado.correctAnswer.label', default: 'Correct Answer')}" />
					
						<g:sortableColumn property="ownerId" title="${message(code: 'quizBanhado.ownerId.label', default: 'Owner Id')}" />
					
						<g:sortableColumn property="taskId" title="${message(code: 'quizBanhado.taskId.label', default: 'Task Id')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quizBanhadoInstanceList}" status="i" var="quizBanhadoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${quizBanhadoInstance.id}">${fieldValue(bean: quizBanhadoInstance, field: "question")}</g:link></td>
					
						<td>${fieldValue(bean: quizBanhadoInstance, field: "answers")}</td>
					
						<td>${fieldValue(bean: quizBanhadoInstance, field: "correctAnswer")}</td>
					
						<td>${fieldValue(bean: quizBanhadoInstance, field: "ownerId")}</td>
					
						<td>${fieldValue(bean: quizBanhadoInstance, field: "taskId")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quizBanhadoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
