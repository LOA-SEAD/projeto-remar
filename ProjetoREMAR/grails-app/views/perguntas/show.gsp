
<%@ page import="escolamagica.Perguntas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'perguntas.label', default: 'Perguntas')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-perguntas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-perguntas" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list perguntas">
			
				<g:if test="${perguntasInstance?.classe}">
				<li class="fieldcontain">
					<span id="classe-label" class="property-label"><g:message code="perguntas.classe.label" default="Classe" /></span>
					
						<span class="property-value" aria-labelledby="classe-label"><g:fieldValue bean="${perguntasInstance}" field="classe"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${perguntasInstance?.respCorreta}">
				<li class="fieldcontain">
					<span id="respCorreta-label" class="property-label"><g:message code="perguntas.respCorreta.label" default="Resp Correta" /></span>
					
						<span class="property-value" aria-labelledby="respCorreta-label"><g:fieldValue bean="${perguntasInstance}" field="respCorreta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${perguntasInstance?.resp}">
				<li class="fieldcontain">
					<span id="resp-label" class="property-label"><g:message code="perguntas.resp.label" default="Resp" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${perguntasInstance?.titulo}">
				<li class="fieldcontain">
					<span id="titulo-label" class="property-label"><g:message code="perguntas.titulo.label" default="Titulo" /></span>
					
						<span class="property-value" aria-labelledby="titulo-label"><g:fieldValue bean="${perguntasInstance}" field="titulo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:perguntasInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${perguntasInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
