
<%@ page import="br.ufscar.sead.loa.remar.Word" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'word.label', default: 'Word')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-word" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-word" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list word">
			
				<g:if test="${wordInstance?.answer}">
				<li class="fieldcontain">
					<span id="answer-label" class="property-label"><g:message code="word.answer.label" default="Answer" /></span>
					
						<span class="property-value" aria-labelledby="answer-label"><g:fieldValue bean="${wordInstance}" field="answer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wordInstance?.word}">
				<li class="fieldcontain">
					<span id="word-label" class="property-label"><g:message code="word.word.label" default="Word" /></span>
					
						<span class="property-value" aria-labelledby="word-label"><g:fieldValue bean="${wordInstance}" field="word"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wordInstance?.initial_position}">
				<li class="fieldcontain">
					<span id="initial_position-label" class="property-label"><g:message code="word.initial_position.label" default="Initialposition" /></span>
					
						<span class="property-value" aria-labelledby="initial_position-label"><g:fieldValue bean="${wordInstance}" field="initial_position"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:wordInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${wordInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
			<g:form controller="word" action="move_to_right">
				<input type="hidden" name="id" value="${wordInstance.id}"/>
				<input type="submit" value="Mover para direita" />
			</g:form>
			<g:form controller="word" action="move_to_left">
				<input type="hidden" name="id" value="${wordInstance.id}"/>
				<input type="submit" value="Mover para esquerda" />
			</g:form>
			<g:form controller="word" action="mark_letter">
				<input type="hidden" name="id" value="${wordInstance.id}"/>
				<input type="number" name="pos" value="pos"/>
				<input type="submit" value="Esconder letra" />
			</g:form>
			<g:form controller="word" action="clear_position">
				<input type="hidden" name="id" value="${wordInstance.id}"/>
				<input type="number" name="pos" value="pos"/>
				<input type="submit" value="Mostrar letra" />
			</g:form>
		</div>
	</body>
</html>
