
<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deploy.label', default: 'Deploy')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript  src="deploy-index.js"/>
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

			<table class="table table-stripped">
			<thead>
					<tr>
						<g:sortableColumn property="fileName" title="${message(code: 'deploy.id_deploy.label', default: 'Name')}" />

                        <g:sortableColumn property="owner" title="${message(code: 'deploy.id_deploy.label', default: 'Owner')}" />

						<g:sortableColumn property="submittedAt" title="${message(code: 'deploy.data_deploy.label', default: 'Submitted at')}" />

                        <g:sortableColumn property="approvedAt" title="${message(code: 'deploy.data_deploy.label', default: 'Status')}" />

                        <g:sortableColumn property="comment" title="${message(code: 'deploy.data_deploy.label', default: 'Comment')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${deployInstanceList}" status="i" var="deployInstance">
                    <g:if test="${deployInstance.status == 'pending'}">
                        <tr class="warning">
                    </g:if>
                    <g:elseif test="${deployInstance.status == 'approved'}">
                        <tr class="success">
                    </g:elseif>
                    <g:elseif test="${deployInstance.status == 'rejected'}">
                        <tr class="danger">
                    </g:elseif>

                    <td>${deployInstance.name}</td>

                    <td>${deployInstance.owner.name}</td>

                    <td>${fieldValue(bean: deployInstance, field: "submittedAt")}</td>
                    <sec:ifNotGranted roles="ROLE_ADMIN">
                        <td>${deployInstance.status}</td>
                    </sec:ifNotGranted>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <td>
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-status="${deployInstance.status}">
                                    Review <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="review" data-review="approve" data-id="${deployInstance.id}">Approve</a></li>
                                    <li><a class="review" data-review="reject" data-id="${deployInstance.id}">Reject</a></li>
                                </ul>
                            </div>
                        </td>
                    </sec:ifAllGranted>

                    <sec:ifNotGranted roles="ROLE_ADMIN">
                        <td>${deployInstance.comment}</td>
                    </sec:ifNotGranted>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <td><input class="comment" data-id="${deployInstance.id}" type="text" value="${deployInstance.comment}"></td>
                    </sec:ifAllGranted>
                        </tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
