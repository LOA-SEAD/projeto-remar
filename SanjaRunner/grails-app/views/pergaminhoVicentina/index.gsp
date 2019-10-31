
<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoVicentina" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Sanja Runner</title>
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<g:external dir="css" file="pergaminhoVicentina.css"/>
		<script type="text/javascript" src="/sanjarunner/js/pergaminhoVicentina.js"></script>
	</head>
	<body>
		<!--Titulo-->
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				Fase Vicentina - Criar pergaminho
			</p>
		</div>
		
		<div class="row">
			<!--Texto explicacao-->
			<div style=" margin-bottom: 10px; color:#333333">
				Se desejar, acesse o <a href="https://goo.gl/M2LEJp" target="_blank">tutorial</a> para customizar essa fase.
				<center>
					<div style="margin-top:20px;margin-bottom:15px">
						<img src="https://files.readme.io/ce34ace-vicentina.png"
							 style="width:400px"/>
					</div>
				</center>
				Informe abaixo quatro textos que serão inseridos nos pergaminhos do nível Vicentina, mantendo a ordem em que as informações aparecerão no jogo.
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
							<g:each in="${pergaminhoVicentinaInstanceList}" status="i" var="pergaminhoVicentinaInstance">
								<tr id="tr${pergaminhoVicentinaInstance.id}" class="selectable_tr" style="cursor: pointer;"
									data-id="${fieldValue(bean: pergaminhoVicentinaInstance, field: "id")}" data-owner-id="${fieldValue(bean: pergaminhoVicentinaInstance, field: "ownerId")}">
									<td>${fieldValue(bean: pergaminhoVicentinaInstance, field: "information")}</td>
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
							<g:form method="post" action="update" resource="${pergaminhoVicentinaInstance}">
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
		
								<input type="hidden" id="pergaminhoVicentinaID" name="pergaminhoVicentinaID">
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

				<div id="errorImportingInformationsModal" class="modal">
					<div class="modal-content">
						Erro - Para importar textos, você deve deixá-los no formato indicado.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>

				<div id="uploadModal" class="modal">
					<div class="modal-content">
						<h4>Enviar arquivo .csv</h4>
						<div class="row">
							<g:uploadForm  method="post" action="generateInformations" resource="${pergaminhoVicentinaInstance}">
								<div class="file-field input-field">
									<div class="btn my-orange">
										<span>File</span>
										<input type="file" accept="text/csv" id="csv" name="csv">
									</div>
									<div class="file-path-wrapper">
										<input class="file-path validate" type="text">
									</div>
								</div>
								<div class="row">
									<div class="col s1 offset-s10">
										<g:submitButton class="btn my-orange" name="generateInformations" value="Enviar"/>
									</div>
								</div>
							</g:uploadForm>
						</div>

						<blockquote>Formatação do arquivo .csv</blockquote>
						<div class="row">
							<div class="col s12">
								<ol>
									<li>O separador do arquivo .csv deve ser um <b> ';' (ponto e vírgula)</b>  </li>
									<li>O arquivo deve ser composto apenas por <b>dados</b></li>
									<li>O arquivo deve representar a estrutura da tabela de exemplo</li>
								</ol>
								<ul>
									<li><a href="/sanjarunner/samples/exemploPergaminho.csv">Download do arquivo exemplo</a></li>
								</ul>
							</div>
						</div>
						<div class="row">
							<div class="col s12">
								<table class="center" style="font-size: 12px;">
									<thead>
									<tr>
										<th>Textos</th>
									</tr>
									</thead>
									<tbody>
									<tr>
										<td>Informação 1</td>
									</tr>
									<tr>
										<td>Informação 2</td>
									</tr>
									<tr>
										<td>Informação 3</td>
									</tr>
									<tr>
										<td>Informação 4</td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<input type="hidden" id="errorImportingInformations" name="errorImportingInformations" value="${errorImportInformations}">
	</body>
</html>
