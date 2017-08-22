
<%@ page import="sanjarunner_1.SantosDumontController" %>
<!DOCTYPE html>
<html>
	 <<head>
	 
	 
		<meta name="layout" content="main">
		<title>SanjaRunner</title>
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="/sanjarunner_1/css/materialize.min.css"  media="screen,projection"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<script type="text/javascript" src="http://davidjbradshaw.com/iframe-resizer/js/iframeResizer.min.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="/sanjarunner_1/js/faseSantos.js"></script>
	</head>

	<body>
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
      <script type="text/javascript" src="/sanjarunner_1/js/materialize.js"></script>
	
	<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Fase - Santos Dumont
			</p>
	</div>		
	
	
	
	
	
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'pergaminho.label', default: 'Pergaminho')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
	
	
		<div class="row">
		<div id="choosePergaminho" class="col s12 m12 l12">
			<br>
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
								<th id="titleLabel">Texto <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								</tr>
						</thead>
						
						<tbody>
							<g:each in="${pergaminhoInstanceList}" status="i" var="pergaminhoInstance">
								<tr id="tr${pergaminhoInstance.id}" class="selectable_tr" style="cursor: pointer;"
									data-checked="false">
									<td class="_not_editable">
										<input style="background-color: #727272" id="checkbox-${pergaminhoInstance.id}" class="filled-in" type="checkbox">
										<label for="checkbox-${pergaminhoInstance.id}"></label>
									</td>
									<td>${fieldValue(bean: pergaminhoInstance, field: "title")}</td>
									<td> <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil " onclick="_modal_editPergaminho($(this.closest('tr')))" ></i>
									</td>
								</tr>
							</g:each>
							</tbody>
						
					</table>
				</div>
			</div>
		</div>
		
		<div class="row">
				<div class="col s1 m1 l1 offset-s4 offset-m8 offset-l8">
					<a data-target="createModalPergaminho" name="createPergaminho" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar questão"><i class="material-icons">add</i></a>
				</div>
				<div class="col s1 offset-s1 m1 l1">
					<a name="deletePergaminho" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir questão" ><i class="material-icons" onclick="_open_modal_delete()">delete</i></a>
				</div>
			</div>
			
			<div class="row">
				<div class="col s2">
					<button class="btn waves-effect waves-light my-orange"  name="savePergaminho" id="submitButton" onclick="_submitPergaminho()">Enviar
						<i class="material-icons">send</i>
					</button>
				</div>
			</div>
			
			<div id="editModal" class="modal">
					<div class="modal-content">
						<h4>Editar Pergaminho</h4>
						<div class="row">
							<g:form method="post" action="updatePergaminho" resource="${pergaminhoInstance}">
								<div class="row">
									<div class="input-field col s12">
										<label id="labelTitle" class="active" for="editTitle">Texto</label>
										<input id="editTitle" name="title" required=""  type="text" class="validate" length="95" maxlength="95">
									</div>
								</div>
								<input type="hidden" id="title" name="title">
								<div class="col l10">
									<g:submitButton name="updatePergaminho" class="btn btn-success btn-lg my-orange" value="Salvar" />
								</div>
								<input type="hidden" id="faseSantosPergaminhoID" name="faseSantosPergaminhoID">
								<div class="col l10">
									<g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
								</div>
							</g:form>
						</div>
					</div>
				</div>
			
				<div id="createModalPergaminho" class="modal">
					<div class="modal-content">
						<h4>Criar Pergaminho</h4>
						<div class="row">
							<g:form action="savePergaminho" resource="${pergaminhoInstance}">
								<div class="row">
									<div class="input-field col s12">
										<label id="labelTitleCreate" class="active" for="editTitleCreate">Texto</label>
										<input id="editTitleCreate" name="title" required=""  type="text" class="validate" length="95" maxlength="95">
									</div>
								</div>
								</div>
								<div class="col l10">
									<g:submitButton name="createPergaminho" class="btn btn-success btn-lg my-orange" value="Criar" />
								</div>
							</g:form>
						</div>
					</div>
				</div>

				<div id="deleteModal" class="modal">
					<div class="modal-content">
						<div id="delete-one-question">
							Você tem certeza que deseja excluir esse pergaminho?
						</div>
						<div id="delete-several-questions">
							Você tem certeza que deseja excluir esses pergaminhos?
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()" style="margin-right: 10px;">Sim</button>
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Não</button>
					</div>
				</div>
				
				<div id="erroDeleteModal" class="modal">
					<div class="modal-content">
						Você deve selecionar ao menos um pergaminho para excluir.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>
				<div id="errorSaveModal" class="modal">
					<div class="modal-content">
						Você deve selecionar pelo menos 4 pergaminhos para enviar.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>
				

		
	</div>
		
		
		
	<div class="row">
		<div id="chooseQuestion" class="col s12 m12 l12">
			<br>
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
							<g:each in="${quizInstanceList}" status="i" var="quizInstance">
								<tr id="tr${quizInstance.id}" class="selectable_tr" style="cursor: pointer;"
									data-checked="false">
									<td class="_not_editable">
										<input style="background-color: #727272" id="checkbox-${quizInstance.id}" class="filled-in" type="checkbox">
										<label for="checkbox-${quizInstance.id}"></label>
									</td>
									<td>${fieldValue(bean: quizInstance, field: "title")}</td>
									<td>${fieldValue(bean: quizInstance, field: "answers")}</td>
									<td>${quizInstance.answers[quizInstance.correctAnswer]}</td>
									<td> <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil " onclick="($(this.closest('tr')))" ></i>
									</td>
								</tr>
							</g:each>
							</tbody>
						
					</table>
				</div>
			</div>
		</div>
		
		<div class="row">
				<div class="col s1 m1 l1 offset-s4 offset-m8 offset-l8">
					<a data-target="createModal" name="createQuiz" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar questão"><i class="material-icons">add</i></a>
				</div>
				<div class="col s1 offset-s1 m1 l1">
					<a name="deleteQuiz" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir questão" ><i class="material-icons" onclick="_open_modal_delete()">delete</i></a>
				</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col s2">
					<button class="btn waves-effect waves-light my-orange"  name="saveQuiz" id="submitButton" onclick="_submit()">Enviar
						<i class="material-icons">send</i>
					</button>
				</div>
			</div>
			
			<div id="editModal" class="modal">
					<div class="modal-content">
						<h4>Editar Questão</h4>
						<div class="row">
							<g:form method="post" action="updateQuiz" resource="${quizInstance}">
								<div class="row">
									<div class="input-field col s12">
										<label id="labelTitle" class="active" for="editTitle">Pergunta</label>
										<input id="editTitle" name="title" required=""  type="text" class="validate" length="95" maxlength="95">
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer1" class="active" for="editAnswers0">Alternativa 1</label>
										<input type="text" class="validate" id="editAnswers0" name="answers1" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio0" name="correctAnswer" value="0" checked="checked"/>
										<label for="editRadio0">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer2" class="active" for="editAnswers1">Alternativa 2</label>
										<input type="text" class="validate" id="editAnswers1" name="answers2" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio1" name="correctAnswer" value="1" /> <label for="editRadio1">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer3" class="active" for="editAnswers2">Alternativa 3</label>
										<input type="text" class="validate" id="editAnswers2" name="answers3" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio2" name="correctAnswer" value="2" /> <label for="editRadio2">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer4" class="active" for="editAnswers3">Alternativa 4</label>
										<input type="text" class="validate" id="editAnswers3" name="answers4" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio3" name="correctAnswer" value="3" /> <label for="editRadio3">Alternativa correta</label>
									</div>
								</div>

								</div>
								<input type="hidden" id="faseSantos" name="faseSantos">
								<div class="col l10">
									<g:submitButton name="updateQuiz" class="btn btn-success btn-lg my-orange" value="Salvar" />
								</div>
							</g:form>
						</div>
					</div>
				</div>
			
				<div id="createModal" class="modal">
					<div class="modal-content">
						<h4>Criar Questão</h4>
						<div class="row">
							<g:form action="saveQuiz" resource="${quizInstance}">
								<div class="row">
									<div class="input-field col s12">
										<label id="labelTitleCreate" class="active" for="editTitleCreate">Pergunta</label>
										<input id="editTitleCreate" name="title" required=""  type="text" class="validate" length="95" maxlength="95">
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer1Create" class="active" for="editAnswers0Create">Alternativa 1</label>
										<input type="text" class="validate" id="editAnswers0Create" name="answers1" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio0Create" name="correctAnswer" value="0"/>
										<label for="editRadio0Create">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer2Create" class="active" for="editAnswers1Create">Alternativa 2</label>
										<input type="text" class="validate" id="editAnswers1Create" name="answers2" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio1Create" name="correctAnswer" value="1" /> <label for="editRadio1Create">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer3Create" class="active" for="editAnswers2Create">Alternativa 3</label>
										<input type="text" class="validate" id="editAnswers2Create" name="answers3" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio2Create" name="correctAnswer" value="2" /> <label for="editRadio2Create">Alternativa correta</label>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s9">
										<label id="labelAnswer4Create" class="active" for="editAnswers3Create">Alternativa 4</label>
										<input type="text" class="validate" id="editAnswers3Create" name="answers4" required="" maxlength="15" length="15"/>
									</div>
									<div class="col s2">
										<input type="radio" id="editRadio3Create" name="correctAnswer" value="3" /> <label for="editRadio3Create">Alternativa correta</label>
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
				<div id="errorSaveModal" class="modal">
					<div class="modal-content">
						Você deve selecionar pelo menos 5 questões para enviar.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>
				

		
	</div>
		
		
		
	</body>
</html>
