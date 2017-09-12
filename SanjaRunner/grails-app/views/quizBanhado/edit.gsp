<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizBanhado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quizBanhado.label', default: 'QuizBanhado')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Fase Banhado - Editar quiz
			</p>
		</div>
		<div class="row">
			<g:form method="post" action="update" resource="${quizBanhadoInstance}">
				<div class="row">
					<div class="input-field col s12">
						<label id="labelQuestion" class="active" for="editQuestion">Questão</label>
						<input id="editQuestion" name="question" required=""  type="text" class="validate" length="200" maxlength="200">
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswers1" class="active" for="editAnswers0">Alternativa A</label>
						<input type="text" class="validate" id="editAnswers0" name="answers1" required="" maxlength="200" length="200"/>
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio0" name="correctAnswer" value="0" checked="checked"/>
						<label for="editRadio0">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswers2" class="active" for="editAnswers1">Alternativa B</label>
						<input type="text" class="validate" id="editAnswers1" name="answers2" required="" maxlength="200" length="200"/>
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio1" name="correctAnswer" value="1" />
						<label for="editRadio1">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswers3" class="active" for="editAnswers2">Alternativa C</label>
						<input type="text" class="validate" id="editAnswers2" name="answers3" required="" maxlength="200" length="200"/>
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio2" name="correctAnswer" value="2" />
						<label for="editRadio2">Alternativa correta</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s9">
						<label id="labelAnswers4" class="active" for="editAnswers3">Alternativa D</label>
						<input type="text" class="form-control" id="editAnswers3" name="answers4" required="" maxlength="15" length="15"/>
					</div>
					<div class="col s2">
						<input type="radio" id="editRadio3" name="correctAnswer" value="3" />
						<label for="editRadio3">Alternativa correta</label>
					</div>
				</div>

				<div class="col l10">
					<g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
				</div>
			</g:form>
		</div>
	</body>
</html>
