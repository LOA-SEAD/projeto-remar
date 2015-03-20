
<%@ page import="projetoremar.Jogo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jogo.label', default: 'Jogo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-jogo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-jogo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jogo">
			
				<g:if test="${jogoInstance?.categoria}">
				<li class="fieldcontain">
					<span id="categoria-label" class="property-label"><g:message code="jogo.categoria.label" default="Categoria" /></span>
					
						<span class="property-value" aria-labelledby="categoria-label"><g:fieldValue bean="${jogoInstance}" field="categoria"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.contribuicao}">
				<li class="fieldcontain">
					<span id="contribuicao-label" class="property-label"><g:message code="jogo.contribuicao.label" default="Contribuicao" /></span>
					
						<span class="property-value" aria-labelledby="contribuicao-label"><g:fieldValue bean="${jogoInstance}" field="contribuicao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="jogo.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${jogoInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.dica}">
				<li class="fieldcontain">
					<span id="dica-label" class="property-label"><g:message code="jogo.dica.label" default="Dica" /></span>
					
						<span class="property-value" aria-labelledby="dica-label"><g:fieldValue bean="${jogoInstance}" field="dica"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.icone}">
				<li class="fieldcontain">
					<span id="icone-label" class="property-label"><g:message code="jogo.icone.label" default="Icone" /></span>
					
						<span class="property-value" aria-labelledby="icone-label"><g:fieldValue bean="${jogoInstance}" field="icone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.nome}">
				<li class="fieldcontain">
					<span id="nome-label" class="property-label"><g:message code="jogo.nome.label" default="Nome" /></span>
					
						<span class="property-value" aria-labelledby="nome-label"><g:fieldValue bean="${jogoInstance}" field="nome"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.palavra}">
				<li class="fieldcontain">
					<span id="palavra-label" class="property-label"><g:message code="jogo.palavra.label" default="Palavra" /></span>
					
						<span class="property-value" aria-labelledby="palavra-label"><g:fieldValue bean="${jogoInstance}" field="palavra"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.tela_inicial}">
				<li class="fieldcontain">
					<span id="tela_inicial-label" class="property-label"><g:message code="jogo.tela_inicial.label" default="Telainicial" /></span>
					
						<span class="property-value" aria-labelledby="tela_inicial-label"><g:fieldValue bean="${jogoInstance}" field="tela_inicial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jogoInstance?.tela_jogo}">
				<li class="fieldcontain">
					<span id="tela_jogo-label" class="property-label"><g:message code="jogo.tela_jogo.label" default="Telajogo" /></span>
					
						<span class="property-value" aria-labelledby="tela_jogo-label"><g:fieldValue bean="${jogoInstance}" field="tela_jogo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:jogoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${jogoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
