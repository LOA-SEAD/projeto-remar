
<%@ page import="br.ufscar.sead.loa.remar.ProcessoJogo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'processoJogo.label', default: 'ProcessoJogo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-processoJogo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-processoJogo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list processoJogo">
			
				<g:if test="${processoJogoInstance?.id_process_definition}">
				<li class="fieldcontain">
					<span id="id_process_definition-label" class="property-label"><g:message code="processoJogo.id_process_definition.label" default="Idprocessdefinition" /></span>
					
						<span class="property-value" aria-labelledby="id_process_definition-label"><g:fieldValue bean="${processoJogoInstance}" field="id_process_definition"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${processoJogoInstance?.id_process_instance}">
				<li class="fieldcontain">
					<span id="id_process_instance-label" class="property-label"><g:message code="processoJogo.id_process_instance.label" default="Idprocessinstance" /></span>
					
						<span class="property-value" aria-labelledby="id_process_instance-label"><g:fieldValue bean="${processoJogoInstance}" field="id_process_instance"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${processoJogoInstance?.professor}">
				<li class="fieldcontain">
					<span id="professor-label" class="property-label"><g:message code="processoJogo.professor.label" default="Professor" /></span>
					
						<span class="property-value" aria-labelledby="professor-label"><g:link controller="usuario" action="show" id="${processoJogoInstance?.professor?.id}">${processoJogoInstance?.professor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:processoJogoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
