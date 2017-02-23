
<%@ page import="br.ufscar.sead.loa.labteca.remar.Composto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'composto.label', default: 'Composto')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-composto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-composto" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list composto">
			
				<g:if test="${compostoInstance?.formula}">
				<li class="fieldcontain">
					<span id="formula-label" class="property-label"><g:message code="composto.formula.label" default="Formula" /></span>
					
						<span class="property-value" aria-labelledby="formula-label"><g:fieldValue bean="${compostoInstance}" field="formula"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${compostoInstance?.tipo}">
				<li class="fieldcontain">
					<span id="tipo-label" class="property-label"><g:message code="composto.tipo.label" default="Tipo" /></span>
					
						<span class="property-value" aria-labelledby="tipo-label"><g:fieldValue bean="${compostoInstance}" field="tipo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${compostoInstance?.nome}">
				<li class="fieldcontain">
					<span id="nome-label" class="property-label"><g:message code="composto.nome.label" default="Nome" /></span>
					
						<span class="property-value" aria-labelledby="nome-label"><g:fieldValue bean="${compostoInstance}" field="nome"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:compostoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${compostoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
