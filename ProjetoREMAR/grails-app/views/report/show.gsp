
<%@ page import="br.ufscar.sead.loa.remar.Report" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-report" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-report" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list report">
			
				<g:if test="${report?.url}">
				<li class="fieldcontain">
					<span id="url-label" class="property-label"><g:message code="report.url.label" default="Url" /></span>
					
						<span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${report}" field="url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${report?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="report.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${report}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${report?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="report.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${report}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${report?.screenshot}">
				<li class="fieldcontain">
					<span id="screenshot-label" class="property-label"><g:message code="report.screenshot.label" default="Screenshot" /></span>
					
						<span class="property-value" aria-labelledby="screenshot-label"><g:formatBoolean boolean="${report?.screenshot}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${report?.seen}">
				<li class="fieldcontain">
					<span id="seen-label" class="property-label"><g:message code="report.seen.label" default="Seen" /></span>
					
						<span class="property-value" aria-labelledby="seen-label"><g:formatBoolean boolean="${report?.seen}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${report?.when}">
				<li class="fieldcontain">
					<span id="when-label" class="property-label"><g:message code="report.when.label" default="When" /></span>
					
						<span class="property-value" aria-labelledby="when-label"><g:formatDate date="${report?.when}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${report?.who}">
				<li class="fieldcontain">
					<span id="who-label" class="property-label"><g:message code="report.who.label" default="Who" /></span>
					
						<span class="property-value" aria-labelledby="who-label"><g:link controller="user" action="show" id="${report?.who?.id}">${report?.who?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:report, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${report}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
