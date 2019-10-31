<%@ page import="br.ufscar.sead.loa.memoria.Tile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tile.label', default: 'Tile')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="cluster-header">
			<h4><g:message code="tile.create.title"/></h4>
			<div class="divider"></div>
		</div>

		<div class="row">
			<g:form class="col s12" controller="tile" action="update" enctype="multipart/form-data" method="PUT">
				<g:hiddenField name="version" value="${tileInstance?.version}" />
				<g:render template="form"/>
			</g:form>
		</div>
	</body>
</html>
