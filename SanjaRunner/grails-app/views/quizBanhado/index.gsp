
<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizBanhado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Sanja Runner</title>
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<g:external dir="css" file="quizBanhado.css"/>
		<script type="text/javascript" src="/sanjarunner/js/quizBanhado.js"></script>
	</head>
	<body>
		<!--Titulo-->
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				Fase Banhado - Criar quiz
			</p>
		</div>

		<div class="row">
			<!--Texto explicacao-->
			<div style=" margin-bottom: 10px; color:#333333">
				Se desejar, acesse o <a href="https://goo.gl/sTbtFX" target="_blank">tutorial</a> para customizar essa fase.
				<center>
					<div style="margin-top:20px;margin-bottom:15px">
						<img src="https://files.readme.io/617b2c1-campo_minado2.jpg"
							 style="width:400px"/>
					</div>
				</center>
				Informe abaixo quatro questões que serão inseridas no quiz do nível Banhado, mantendo a ordem em que as questões aparecerão no jogo.
			</div>

			<div id="chooseQuestions" class="col s12 m12 l12">
				<br>
				<!--Tabela contendo todos as questoes-->
				<div class="row">
					<div class="col s12 m12 l12">
						<table class="highlight" id="table" style="margin-top: -30px;">
							<!--Cabecalho para editar os textos dos pergaminhos-->
							<thead>
							<tr>
								<th id="titleLabel">Pergunta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Alternativas <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Resposta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Ações <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
							</tr>
							</thead>

							<!--Local para editar as questoes-->
							<tbody>
							<g:each in="${quizBanhadoInstanceList}" status="i" var="quizBanhadoInstance">
								<tr id="tr${quizBanhadoInstance.id}" class="selectable_tr" style="cursor: pointer;"
									data-id="${fieldValue(bean: quizBanhadoInstance, field: "id")}" data-owner-id="${fieldValue(bean: quizBanhadoInstance, field: "ownerId")}">
									<td class="_not_editable">
										<input style="background-color: #727272" id="checkbox-${quizBanhadoInstance.id}" class="filled-in" type="checkbox">
										<label for="checkbox-${quizBanhadoInstance.id}"></label>
									</td>
									<td>${fieldValue(bean: quizBanhadoInstance, field: "question")}</td>
									<td>${fieldValue(bean: quizBanhadoInstance, field: "answers")}</td>
									<td>${quizBanhadoInstance.answers[quizBanhadoInstance.correctAnswer]}</td>
									<td> <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil " onclick="_modal_edit($(this.closest('tr')))" ></i>
									</td>
								</tr>
							</g:each>
							</tbody>
						</table>
					</div>
				</div>

				<!--Botoes modais inferiores-->
				<div class="row">
					<div class="col s1 offset-s1 m1 l1">
						<a data-target="uploadModal" class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped" data-tooltip="Upload arquivo .csv"><i
								class="material-icons">file_upload</i></a>
					</div>
					<div class="col s1 offset-s1 m1 l1">
						<a class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exportar questões para .csv"><i
								class="material-icons" onclick="exportQuestions()">file_download</i></a>
					</div>
				</div>

				<!--Botao salvar-->
				<div class="row">
					<div class="col s2">
						<button class="btn waves-effect waves-light remar-orange"  name="save" id="submitButton" onclick="_submit()">Enviar</button>
					</div>
				</div>

				<!--Editar textos-->
				<div id="editModal" class="modal">
					<div class="modal-content">
						<h4>Editar Questão</h4>
						<div class="row">
							<g:form method="post" action="update" resource="${quizBanhadoInstance}">
								<!--Campos de edicao-->
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


								<input type="hidden" id="quizBanhadoID" name="quizBanhadoID">
								<div class="col l10">
									<g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
								</div>
							</g:form>
						</div>
					</div>
				</div>

				<!--
					<div id="errorSaveModal" class="modal">
						<div class="modal-content">
							Você deve selecionar pelo menos 4 questões para enviar.
						</div>
						<div class="modal-footer">
							<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
						</div>
					</div>


					<div id="errorDownloadModal" class="modal">
						<div class="modal-content">
							Você deve selecionar ao menos uma questão antes de exportar seu banco de questões.
						</div>
						<div class="modal-footer">
							<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
						</div>
					</div>
					-->

			</div>
		</div>
	<input type="hidden" id="errorImportingQuestions" name="errorImportingQuestions" value="${errorImportQuestions}">
	</body>
</html>
