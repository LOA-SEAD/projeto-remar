<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'tile.label', default: 'tile')}" />
</head>

<body>
	<div class="cluster-header">
		<h4><g:message code="tile.create.title"/></h4>
		<div class="divider"></div>
	</div>


	<div class="row">
		<g:form class="col s12 sendForm" controller="tile" action="save" enctype="multipart/form-data">
			<g:render template="form"/>

			<div class="row right-align" style="right-margin: 15em;">
				<a id="back" name="back" class="btn btn-success remar-orange">Voltar</a>
				<button id="submit" type="button" name="submit" class="btn btn-success remar-orange" value="Criar">Criar</button>
			</div>
		</g:form>
	</div>





<g:javascript src="recording.js"/>
<g:javascript src="recorder.js"/>
<g:javascript src="tile.js"/>
<script src="https://cdn.rawgit.com/mattdiamond/Recorderjs/08e7abd9/dist/recorder.js"></script>


</body>
</html>
