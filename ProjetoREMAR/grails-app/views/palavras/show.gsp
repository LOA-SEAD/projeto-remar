
<%@ page import="projetoremar.Palavras" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'palavras.label', default: 'Palavras')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-palavras" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-palavras" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list palavras">
			
				<g:if test="${palavrasInstance?.resposta}">
				<li class="fieldcontain">
					<span id="resposta-label" class="property-label"><g:message code="palavras.resposta.label" default="Resposta" /></span>
					
						<span class="property-value" aria-labelledby="resposta-label"><g:fieldValue bean="${palavrasInstance}" field="resposta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${palavrasInstance?.dica}">
				<li class="fieldcontain">
					<span id="dica-label" class="property-label"><g:message code="palavras.dica.label" default="Dica" /></span>
					
						<span class="property-value" aria-labelledby="dica-label"><g:fieldValue bean="${palavrasInstance}" field="dica"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${palavrasInstance?.contribuicao}">
				<li class="fieldcontain">
					<span id="contribuicao-label" class="property-label"><g:message code="palavras.contribuicao.label" default="Contribuicao" /></span>
					
						<span class="property-value" aria-labelledby="contribuicao-label"><g:fieldValue bean="${palavrasInstance}" field="contribuicao"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:palavrasInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${palavrasInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
