
<%@ page import="projetoremar.Design" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'design.label', default: 'Design')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-design" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-design" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list design">
			
				<g:if test="${designInstance?.icone}">
				<li class="fieldcontain">
					<span id="icone-label" class="property-label"><g:message code="design.icone.label" default="Icone" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${designInstance?.telaFundo}">
				<li class="fieldcontain">
					<span id="telaFundo-label" class="property-label"><g:message code="design.telaFundo.label" default="Tela Fundo" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${designInstance?.telaAbertura}">
				<li class="fieldcontain">
					<span id="telaAbertura-label" class="property-label"><g:message code="design.telaAbertura.label" default="Tela Abertura" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:designInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${designInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
