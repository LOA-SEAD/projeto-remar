<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'tile.label', default: 'tile')}" />
</head>

<body>
	<div class="cluster-header">
		<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
			<g:message code="tile.create.title"/>
		</p>
	</div>

	<div class="row">
		<g:form class="col s12" controller="tile" action="save" enctype="multipart/form-data">
			<g:render template="form"/>
		</g:form>
	</div>
</body>
</html>
