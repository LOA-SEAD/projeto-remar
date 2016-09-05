
<%@ page import="br.ufscar.sead.loa.santograu.remar.QuestionFaseBlocoGelo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Em Busca do Santo Grau</title>
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<script type="text/javascript" src="/santograu/js/faseBlocoGelo.js"></script>
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Fase Bloco de Gelo - Banco de Questões
			</p>
		</div>
		<div class="row">
			<div id="chooseQuestion" class="col s12 m12 l12">
				<br>
				<div class="row">
					<div class="col s6 m3 l3 offset-s6 offset-m9 offset-l9">
						<input  type="text" id="SearchLabel" placeholder="Buscar"/>
					</div>
				</div>
				<div class="row">
					<div class="col s12 m12 l12">
						<table class="highlight" id="table" style="margin-top: -30px;">
							<thead>
							<tr>
								<th>Selecionar
									<div class="row" style="margin-bottom: -10px;">
										<button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnCheckAll" onclick="check_all()"><i  class="material-icons">check_box_outline_blank</i></button>
										<button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnUnCheckAll" onclick="uncheck_all()"><i  class="material-icons">done</i></button>
									</div>
								</th>
								<th id="titleLabel">Pergunta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Respostas <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Alternativa Correta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Ações <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
							</tr>
							</thead>

							<tbody>
							<g:each in="${questionFaseBlocoGeloInstanceList}" status="i" var="faseBlocoGeloInstance">
								<tr id="tr${faseBlocoGeloInstance.id}" class="selectable_tr" style="cursor: pointer;"
									data-id="${fieldValue(bean: faseBlocoGeloInstance, field: "id")}" data-owner-id="${fieldValue(bean: faseBlocoGeloInstance, field: "ownerId")}"
									data-checked="false">
									<td class="_not_editable">
										<input style="background-color: #727272" id="checkbox-${faseBlocoGeloInstance.id}" class="filled-in" type="checkbox">
										<label for="checkbox-${faseBlocoGeloInstance.id}"></label>
									</td>
									<td>${fieldValue(bean: faseBlocoGeloInstance, field: "title")}</td>
									<td>${fieldValue(bean: faseBlocoGeloInstance, field: "answers")}</td>
									<td>${faseBlocoGeloInstance.answers[faseBlocoGeloInstance.correctAnswer]}</td>
									<td> <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil " onclick="_modal_edit($(this.closest('tr')))" ></i>
									</td>
								</tr>
							</g:each>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row">
					<div class="col s1 m1 l1 offset-s4 offset-m8 offset-l8">
						<a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar questão"><i class="material-icons">add</i></a>
					</div>
					<div class="col s1 offset-s1 m1 l1">
						<a name="delete" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir questão" ><i class="material-icons" onclick="_open_modal_delete()">delete</i></a>
					</div>
					<div class="col s1 offset-s1 m1 l1">
						<a data-target="uploadModal" class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped" data-tooltip="Upload arquivo .csv"><i
								class="material-icons">file_upload</i></a>
					</div>
					<div class="col s1 offset-s1 m1 l1">
						<a class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exportar questões para .csv"><i
								class="material-icons" onclick="exportQuestions()">file_download</i></a>
					</div>
				</div>

				<div class="row">
					<div class="col s2">
						<g:form method="post"  action="save" resource="${faseBlocoGeloInstance}">
							<button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="submitButton" onclick="submit()">Enviar
								<i class="material-icons">send</i>
							</button>
						</g:form>
					</div>
				</div>

				<div id="editModal" class="modal">
					<div class="modal-content">
						<h4>Editar Questão</h4>
						<div class="row">
							<g:form method="post" action="update" resource="${faseBlocoGeloInstance}">
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
								<input type="hidden" id="faseBlocoGeloID" name="faseBlocoGeloID">
								<div class="col l10">
									<g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
								</div>
							</g:form>
						</div>
					</div>
				</div>

				<div id="createModal" class="modal">
					<div class="modal-content">
						<h4>Criar Questão</h4>
						<div class="row">
							<g:form action="save" resource="${faseBlocoGeloInstance}">
								<div class="row">
									<div class="input-field col s12">
										<label id="labelTitleCreate" class="active" for="editTitleCreate">Pergunta</label>
										<input id="editTitleCreate" name="title" required=""  type="text" class="validate">
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer1Create" class="active" for="editAnswers0Create">Alternativa 1</label>
										<input type="text" class="validate" id="editAnswers0Create" name="answers1" required="" />
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio0Create" name="correctAnswer" value="0"/>
										<label for="editRadio0Create">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer2Create" class="active" for="editAnswers1Create">Alternativa 2</label>
										<input type="text" class="validate" id="editAnswers1Create" name="answers2" required="" />
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio1Create" name="correctAnswer" value="1" /> <label for="editRadio1Create">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer3Create" class="active" for="editAnswers2Create">Alternativa 3</label>
										<input type="text" class="validate" id="editAnswers2Create" name="answers3" required=""/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio2Create" name="correctAnswer" value="2" /> <label for="editRadio2Create">Alternativa correta</label>
									</div>
								</div>
								<div class="col l10">
									<g:submitButton name="create" class="btn btn-success btn-lg my-orange" value="Criar" />
								</div>
							</g:form>
						</div>
					</div>
				</div>

				<div id="deleteModal" class="modal">
					<div class="modal-content">
						<div id="delete-one-question">
							Você tem certeza que deseja excluir essa questão?
						</div>
						<div id="delete-several-questions">
							Você tem certeza que deseja excluir essas questões?
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()" style="margin-right: 10px;">Sim</button>
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Não</button>
					</div>
				</div>

				<div id="erroDeleteModal" class="modal">
					<div class="modal-content">
						Você deve selecionar ao menos uma questão para excluir.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
