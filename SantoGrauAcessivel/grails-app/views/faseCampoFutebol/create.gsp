<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'faseCampoFutebol.label', default: 'QuestionFaseCampoFutebol')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<div class="cluster-header">
	<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
		<i class="small material-icons left">grid_on</i>Fase Campo Futebol - Banco de Questões
	</p>
</div>
<div class="row">
	<div class="row">
		<div class="input-field col s12">
			<label id="labelTitle" class="active" for="editTitle">Pergunta</label>
			<input id="editTitle" name="title" required=""  type="text" class="validate">
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12">
			<label id="labelAnswer" class="active" for="editAnswer">Resposta</label>
			<input type="text" class="validate" id="editAnswer" name="answer" required="" />
		</div>
	</div>

	<div class="row">
		<div class="col s2">
			<button class="btn waves-effect waves-light my-orange"  name="save" id="submitButton" onclick="_save()">Criar
			</button>
		</div>
	</div>
</div>
</body>
</html>
