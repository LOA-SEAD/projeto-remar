
<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizVicentina" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quizVicentina.label', default: 'QuizVicentina')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-quizVicentina" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quizVicentina" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quizVicentina">
			
				<g:if test="${quizVicentinaInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="quizVicentina.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${quizVicentinaInstance}" field="question"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizVicentinaInstance?.answers}">
				<li class="fieldcontain">
					<span id="answers-label" class="property-label"><g:message code="quizVicentina.answers.label" default="Answers" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizVicentinaInstance?.correctAnswer}">
				<li class="fieldcontain">
					<span id="correctAnswer-label" class="property-label"><g:message code="quizVicentina.correctAnswer.label" default="Correct Answer" /></span>
					
						<span class="property-value" aria-labelledby="correctAnswer-label"><g:fieldValue bean="${quizVicentinaInstance}" field="correctAnswer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizVicentinaInstance?.ownerId}">
				<li class="fieldcontain">
					<span id="ownerId-label" class="property-label"><g:message code="quizVicentina.ownerId.label" default="Owner Id" /></span>
					
						<span class="property-value" aria-labelledby="ownerId-label"><g:fieldValue bean="${quizVicentinaInstance}" field="ownerId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizVicentinaInstance?.taskId}">
				<li class="fieldcontain">
					<span id="taskId-label" class="property-label"><g:message code="quizVicentina.taskId.label" default="Task Id" /></span>
					
						<span class="property-value" aria-labelledby="taskId-label"><g:fieldValue bean="${quizVicentinaInstance}" field="taskId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:quizVicentinaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${quizVicentinaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
