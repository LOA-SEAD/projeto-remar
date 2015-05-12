
<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deploy.label', default: 'Deploy')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-deploy" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-deploy" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list deploy">
			
				<g:if test="${deployInstance?.data_deploy}">
				<li class="fieldcontain">
					<span id="data_deploy-label" class="property-label"><g:message code="deploy.data_deploy.label" default="Datadeploy" /></span>
					
						<span class="property-value" aria-labelledby="data_deploy-label"><g:formatDate date="${deployInstance?.data_deploy}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${deployInstance?.desenvolvedor}">
				<li class="fieldcontain">
					<span id="desenvolvedor-label" class="property-label"><g:message code="deploy.desenvolvedor.label" default="Desenvolvedor" /></span>
					
						<span class="property-value" aria-labelledby="desenvolvedor-label"><g:link controller="usuario" action="show" id="${deployInstance?.desenvolvedor?.id}">${deployInstance?.desenvolvedor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${deployInstance?.id_deploy}">
				<li class="fieldcontain">
					<span id="id_deploy-label" class="property-label"><g:message code="deploy.id_deploy.label" default="Iddeploy" /></span>
					
						<span class="property-value" aria-labelledby="id_deploy-label"><g:fieldValue bean="${deployInstance}" field="id_deploy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${deployInstance?.war_filename}">
				<li class="fieldcontain">
					<span id="war_filename-label" class="property-label"><g:message code="deploy.war_filename.label" default="Warfilename" /></span>
					
						<span class="property-value" aria-labelledby="war_filename-label"><g:fieldValue bean="${deployInstance}" field="war_filename"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:deployInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
