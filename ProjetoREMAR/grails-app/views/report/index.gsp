
<%@ page import="br.ufscar.sead.loa.remar.Report" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-report" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-report" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="url" title="${message(code: 'report.url.label', default: 'Url')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'report.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'report.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="screenshot" title="${message(code: 'report.screenshot.label', default: 'Screenshot')}" />
					
						<g:sortableColumn property="seen" title="${message(code: 'report.seen.label', default: 'Seen')}" />
					
						<g:sortableColumn property="when" title="${message(code: 'report.when.label', default: 'When')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${reportList}" status="i" var="report">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${report.id}">${fieldValue(bean: report, field: "url")}</g:link></td>
					
						<td>${fieldValue(bean: report, field: "description")}</td>
					
						<td>${fieldValue(bean: report, field: "type")}</td>
					
						<td><g:formatBoolean boolean="${report.screenshot}" /></td>
					
						<td><g:formatBoolean boolean="${report.seen}" /></td>
					
						<td><g:formatDate date="${report.when}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${reportCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
