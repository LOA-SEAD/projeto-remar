
<%@ page import="br.ufscar.sead.loa.santograuinclusivo.remar.QuestionFaseCampoFutebol" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'faseCampoFutebol.label', default: 'QuestionFaseCampoFutebol')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-faseCampoFutebol" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
	<ul>
		<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
		<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
	</ul>
</div>
<div id="show-faseCampoFutebol" class="content scaffold-show" role="main">
	<h1><g:message code="default.show.label" args="[entityName]" /></h1>
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<ol class="property-list faseCampoFutebol">

		<g:if test="${faseCampoFutebolInstance?.answers}">
			<li class="fieldcontain">
				<span id="answers-label" class="property-label"><g:message code="faseCampoFutebol.answers.label" default="Answers" /></span>

			</li>
		</g:if>

		<g:if test="${faseCampoFutebolInstance?.correctAnswer}">
			<li class="fieldcontain">
				<span id="correctAnswer-label" class="property-label"><g:message code="faseCampoFutebol.correctAnswer.label" default="Correct Answer" /></span>

				<span class="property-value" aria-labelledby="correctAnswer-label"><g:fieldValue bean="${faseCampoFutebolInstance}" field="correctAnswer"/></span>

			</li>
		</g:if>

		<g:if test="${faseCampoFutebolInstance?.ownerId}">
			<li class="fieldcontain">
				<span id="ownerId-label" class="property-label"><g:message code="faseCampoFutebol.ownerId.label" default="Owner Id" /></span>

				<span class="property-value" aria-labelledby="ownerId-label"><g:fieldValue bean="${faseCampoFutebolInstance}" field="ownerId"/></span>

			</li>
		</g:if>

		<g:if test="${faseCampoFutebolInstance?.taskId}">
			<li class="fieldcontain">
				<span id="taskId-label" class="property-label"><g:message code="faseCampoFutebol.taskId.label" default="Task Id" /></span>

				<span class="property-value" aria-labelledby="taskId-label"><g:fieldValue bean="${faseCampoFutebolInstance}" field="taskId"/></span>

			</li>
		</g:if>

		<g:if test="${faseCampoFutebolInstance?.title}">
			<li class="fieldcontain">
				<span id="title-label" class="property-label"><g:message code="faseCampoFutebol.title.label" default="Title" /></span>

				<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${faseCampoFutebolInstance}" field="title"/></span>

			</li>
		</g:if>

	</ol>
	<g:form url="[resource:faseCampoFutebolInstance, action:'delete']" method="DELETE">
		<fieldset class="buttons">
			<g:link class="edit" action="edit" resource="${faseCampoFutebolInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
			<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
		</fieldset>
	</g:form>
</div>
</body>
</html>
