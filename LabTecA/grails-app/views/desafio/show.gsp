
<%@ page import="br.ufscar.sead.loa.labteca.remar.Desafio" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'desafio.label', default: 'Desafio')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-desafio" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-desafio" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list desafio">
			
				<g:if test="${desafioInstance?.volInicial}">
				<li class="fieldcontain">
					<span id="volInicial-label" class="property-label"><g:message code="desafio.volInicial.label" default="Vol Inicial" /></span>
					
						<span class="property-value" aria-labelledby="volInicial-label"><g:fieldValue bean="${desafioInstance}" field="volInicial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${desafioInstance?.volFinal}">
				<li class="fieldcontain">
					<span id="volFinal-label" class="property-label"><g:message code="desafio.volFinal.label" default="Vol Final" /></span>
					
						<span class="property-value" aria-labelledby="volFinal-label"><g:fieldValue bean="${desafioInstance}" field="volFinal"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${desafioInstance?.molInicial}">
				<li class="fieldcontain">
					<span id="molInicial-label" class="property-label"><g:message code="desafio.molInicial.label" default="Mol Inicial" /></span>
					
						<span class="property-value" aria-labelledby="molInicial-label"><g:fieldValue bean="${desafioInstance}" field="molInicial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${desafioInstance?.molFinal}">
				<li class="fieldcontain">
					<span id="molFinal-label" class="property-label"><g:message code="desafio.molFinal.label" default="Mol Final" /></span>
					
						<span class="property-value" aria-labelledby="molFinal-label"><g:fieldValue bean="${desafioInstance}" field="molFinal"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${desafioInstance?.composto}">
				<li class="fieldcontain">
					<span id="composto-label" class="property-label"><g:message code="desafio.composto.label" default="Composto" /></span>
					
						<span class="property-value" aria-labelledby="composto-label"><g:link controller="composto" action="show" id="${desafioInstance?.composto?.id}">${desafioInstance?.composto?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:desafioInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${desafioInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
