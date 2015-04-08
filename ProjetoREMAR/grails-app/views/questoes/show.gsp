
<%@ page import="escolamagica.Questoes" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'questoes.label', default: 'Questoes')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-questoes" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-questoes" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list questoes">
			
				<g:if test="${questoesInstance?.alternativas}">
				<li class="fieldcontain">
					<span id="alternativas-label" class="property-label"><g:message code="questoes.alternativas.label" default="Alternativas" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${questoesInstance?.pergunta}">
				<li class="fieldcontain">
					<span id="pergunta-label" class="property-label"><g:message code="questoes.pergunta.label" default="Pergunta" /></span>
					
						<span class="property-value" aria-labelledby="pergunta-label"><g:fieldValue bean="${questoesInstance}" field="pergunta"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:questoesInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${questoesInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
