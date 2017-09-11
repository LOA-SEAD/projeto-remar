
<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoBanhado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Sanja Runner</title>
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<g:external dir="css" file="pergaminhoBanhado.css"/>
		<script type="text/javascript" src="/sanjarunner/js/pergaminhoBanhado.js"></script>
	</head>
	<body>
		<!--Titulo-->
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				Fase Banhado - Criar pergaminho
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
				Informe abaixo quatro textos que serão inseridos nos pergaminhos do nível Banhado, mantendo a ordem em que as informações aparecerão no jogo.
			</div>

			<div id="chooseInformations" class="col s12 m12 l12">
				<br>
				<!--Tabela contendo todos os textos dos pergaminhos-->
				<div class="row">
					<div class="col s12 m12 l12">
						<table class="highlight" id="table" style="margin-top: -30px;">
							<!--Cabecalho para editar os textos dos pergaminhos-->
							<thead>
							<tr>
								<th id="titleLabel">Textos <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
								<th>Ações <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
							</tr>
							</thead>

							<!--Local para editar os textos dos pergaminhos-->
							<tbody>
							<g:each in="${pergaminhoBanhadoInstanceList}" status="i" var="pergaminhoBanhadoInstance">
								<tr id="tr${pergaminhoBanhadoInstance.id}" class="selectable_tr" style="cursor: pointer;"
									data-id="${fieldValue(bean: pergaminhoBanhadoInstance, field: "id")}" data-owner-id="${fieldValue(bean: pergaminhoBanhadoInstance, field: "ownerId")}">
									<td class="_not_editable">
										<input style="background-color: #727272" id="checkbox-${pergaminhoBanhadoInstance.id}" class="filled-in" type="checkbox">
										<label for="checkbox-${pergaminhoBanhadoInstance.id}"></label>
									</td>
									<td>${fieldValue(bean: pergaminhoBanhadoInstance, field: "information")}</td>
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
								class="material-icons" onclick="exportInformations()">file_download</i></a>
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
						<h4>Editar Texto</h4>
						<div class="row">
							<g:form method="post" action="update" resource="${pergaminhoBanhadoInstance}">
								<!--Campos de edicao-->
								<div class="row">
									<div class="input-field col s12">
										<label id="labelInformation1" class="active" for="editInformation0">Texto 1</label>
										<input type="text" class="validate" id="editInformation0" name="information1" required="" maxlength="600" length="600"/>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s12">
										<label id="labelInformation2" class="active" for="editInformation1">Texto 2</label>
										<input type="text" class="validate" id="editInformation1" name="information2" required="" maxlength="600" length="600"/>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s12">
										<label id="labelInformation3" class="active" for="editInformation2">Texto 3</label>
										<input type="text" class="validate" id="editInformation2" name="information3" required="" maxlength="600" length="600"/>
									</div>
								</div>

								<div class="row">
									<div class="input-field col s12">
										<label id="labelInformation4" class="active" for="editInformation3">Texto 4</label>
										<input type="text" class="validate" id="editInformation3" name="information4" required="" maxlength="600" length="600"/>
									</div>
								</div>

								<input type="hidden" id="pergaminhoBanhadoID" name="pergaminhoBanhadoID">
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
	<input type="hidden" id="errorImportingInformations" name="errorImportingInformations" value="${errorImportInformations}">
	</body>
</html>
