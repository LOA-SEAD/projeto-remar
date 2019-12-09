
<%@ page import="br.ufscar.sead.loa.santograuacessivel.remar.QuestionFaseBiblioteca" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'faseBiblioteca.label', default: 'QuestionFaseBiblioteca')}" />
	<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-faseBiblioteca" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
	<ul>
		<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
		<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
	</ul>
</div>
<div id="show-faseBiblioteca" class="content scaffold-show" role="main">
	<h1><g:message code="default.show.label" args="[entityName]" /></h1>
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<ol class="property-list faseBiblioteca">

		<g:if test="${faseBibliotecaInstance?.answer}">
			<li class="fieldcontain">
				<span id="answers-label" class="property-label"><g:message code="faseBiblioteca.answers.label" default="Answer" /></span>

			</li>
		</g:if>

		<g:if test="${faseBibliotecaInstance?.ownerId}">
			<li class="fieldcontain">
				<span id="ownerId-label" class="property-label"><g:message code="faseBiblioteca.ownerId.label" default="Owner Id" /></span>

				<span class="property-value" aria-labelledby="ownerId-label"><g:fieldValue bean="${faseBibliotecaInstance}" field="ownerId"/></span>

			</li>
		</g:if>

		<g:if test="${faseBibliotecaInstance?.taskId}">
			<li class="fieldcontain">
				<span id="taskId-label" class="property-label"><g:message code="faseBiblioteca.taskId.label" default="Task Id" /></span>

				<span class="property-value" aria-labelledby="taskId-label"><g:fieldValue bean="${faseBibliotecaInstance}" field="taskId"/></span>

			</li>
		</g:if>


	</ol>
	<g:form url="[resource:faseBibliotecaInstance, action:'delete']" method="DELETE">
		<fieldset class="buttons">
			<g:link class="edit" action="edit" resource="${faseBibliotecaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
			<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
		</fieldset>
	</g:form>
</div>
</body>
</html>
