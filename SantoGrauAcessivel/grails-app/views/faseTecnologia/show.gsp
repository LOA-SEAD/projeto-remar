
<%@ page import="br.ufscar.sead.loa.santograuacessivel.remar.FaseTecnologia" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'faseTecnologia.label', default: 'FaseTecnologia')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-faseTecnologia" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-faseTecnologia" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list faseTecnologia">
			
				<g:if test="${faseTecnologiaInstance?.link}">
				<li class="fieldcontain">
					<span id="link-label" class="property-label"><g:message code="faseTecnologia.link.label" default="Link" /></span>
					
						<span class="property-value" aria-labelledby="link-label"><g:fieldValue bean="${faseTecnologiaInstance}" field="link"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${faseTecnologiaInstance?.tipoLink}">
				<li class="fieldcontain">
					<span id="tipoLink-label" class="property-label"><g:message code="faseTecnologia.tipoLink.label" default="Tipo Link" /></span>
					
						<span class="property-value" aria-labelledby="tipoLink-label"><g:fieldValue bean="${faseTecnologiaInstance}" field="tipoLink"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${faseTecnologiaInstance?.palavras}">
				<li class="fieldcontain">
					<span id="palavras-label" class="property-label"><g:message code="faseTecnologia.palavras.label" default="Palavras" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${faseTecnologiaInstance?.ownerId}">
				<li class="fieldcontain">
					<span id="ownerId-label" class="property-label"><g:message code="faseTecnologia.ownerId.label" default="Owner Id" /></span>
					
						<span class="property-value" aria-labelledby="ownerId-label"><g:fieldValue bean="${faseTecnologiaInstance}" field="ownerId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${faseTecnologiaInstance?.taskId}">
				<li class="fieldcontain">
					<span id="taskId-label" class="property-label"><g:message code="faseTecnologia.taskId.label" default="Task Id" /></span>
					
						<span class="property-value" aria-labelledby="taskId-label"><g:fieldValue bean="${faseTecnologiaInstance}" field="taskId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:faseTecnologiaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${faseTecnologiaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
