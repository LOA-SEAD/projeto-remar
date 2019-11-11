<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>
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
				<fieldset class="form">
					<g:render template="form"/>

					<div class="row right-align" style="right-margin: 15em;">
						<a id="back" name="back" class="btn btn-success remar-orange">${message(code:'tile.create.backButton')}</a>
						<button id="submitEdit" type="button" name="submitEdit" class="btn btn-success remar-orange" value="Salvar">Salvar</button>
					</div>
				</fieldset>
			</g:form>
		</div>

	<g:javascript src="tile.js"/>
	<g:javascript src="recording.js"/>
	<g:javascript src="recorder.js"/>
	</body>
</html>

