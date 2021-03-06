<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'faseCampoMinado.label', default: 'QuestionFaseCampoMinado')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Fase Campo  Minado - Banco de Questões
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
					<div class="input-field col s9">
						<label id="labelAnswer1" class="active" for="editAnswers0">Alternativa 1</label>
						<input type="text" class="validate" id="editAnswers0" name="answers1" required="" />
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio0" name="correctAnswer" value="0" checked="checked"/>
						<label for="editRadio0">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswer2" class="active" for="editAnswers1">Alternativa 2</label>
						<input type="text" class="validate" id="editAnswers1" name="answers2" required="" />
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio1" name="correctAnswer" value="1" /> <label for="editRadio1">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswer3" class="active" for="editAnswers2">Alternativa 3</label>
						<input type="text" class="validate" id="editAnswers2" name="answers3" required=""/>
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio2" name="correctAnswer" value="2" /> <label for="editRadio2">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswer4" class="active" for="editAnswers3">Alternativa 4</label>
						<input type="text" class="form-control" id="editAnswers3" name="answers4" required="" />
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio3" name="correctAnswer" value="3" /> <label for="editRadio3">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswer5" class="active" for="editAnswers4">Alternativa 5</label>
						<input type="text" class="form-control" id="editAnswers4" name="answers5" required="" />
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio4" name="correctAnswer" value="4" /> <label for="editRadio3">Alternativa correta</label>
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
