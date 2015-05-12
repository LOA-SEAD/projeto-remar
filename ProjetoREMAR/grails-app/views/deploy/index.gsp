
<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deploy.label', default: 'Deploy')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-deploy" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-deploy" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="data_deploy" title="${message(code: 'deploy.data_deploy.label', default: 'Datadeploy')}" />
					
						<th><g:message code="deploy.desenvolvedor.label" default="Desenvolvedor" /></th>
					
						<g:sortableColumn property="id_deploy" title="${message(code: 'deploy.id_deploy.label', default: 'Iddeploy')}" />
					
						<g:sortableColumn property="war_filename" title="${message(code: 'deploy.war_filename.label', default: 'Warfilename')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${deployInstanceList}" status="i" var="deployInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${deployInstance.id}">${fieldValue(bean: deployInstance, field: "data_deploy")}</g:link></td>
					
						<td>${deployInstance.desenvolvedor.name}</td>
					
						<td>${fieldValue(bean: deployInstance, field: "id_deploy")}</td>
					
						<td>${fieldValue(bean: deployInstance, field: "war_filename")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
