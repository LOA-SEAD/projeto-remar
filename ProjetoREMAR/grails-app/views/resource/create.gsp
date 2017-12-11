<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">
	<title>Novo Jogo</title>
</head>

<body>

<div class="row cluster">

	<div class="row show">
		<div class="row cluster-header">
			<h4>Desenvolvedor</h4>
			<div class="divider"></div>
		</div>
	</div>

	<div class="success-box row show hidden">
		<div class="col s1">
			<i class="material-icons tiny no-margin">check_circle</i>
		</div>

		<div id="success-box-message" class="col s7">
			<strong>Sucesso!</strong> O carregamento do arquivo foi carregado conforme o esperado.
		</div>

		<div class="col s4 right-align">
			<button id="close-success" class="btn-flat">Fechar</button>
		</div>
	</div>

	<div class="row">
		<div class="row show">

			<ul class="collapsible popout" data-collapsible="accordion">
				<li class="no-margin" style="width: 100% !important">

					<div class="collapsible-header active" style="padding: 10px">
						Upload War

						<div id="preloader-wrapper" class="preloader-wrapper small active right">
							<div class="spinner-layer spinner-red-only">
								<div class="circle-clipper left">
									<div class="circle"></div>
								</div>
								<div class="gap-patch">
									<div class="circle"></div>
								</div>
								<div class="circle-clipper right">
									<div class="circle"></div>
								</div>
							</div>
						</div>
					</div>

					<div class="collapsible-body">

						<div class="file-field input-field">

							<div class="row">
								<div class="col l12 s12">
									<div class="btn waves-effect waves-light my-orange col s4 l1">
										<span>Arquivo</span>
										<input type="file" required name="war" id="war" accept=".war">
									</div>

									<div class="file-path-wrapper col s8 l11">
										<input class="file-path validate" type="text" name="create" required placeholder="Selecione o arquivo do seu jogo (.war)" readonly>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col l6 s12">
									<div class="row no-margin">
										<div class="col l12 valign-wrapper">
											<p class="valign no-margin"> Permitir usos comerciais do seu trabalho?</p>
											<i class="material-icons tooltipped cursor-pointer valign" data-tooltip="Mais informações" onclick="openThisModal('modalComercial')">&nbspinfo</i>
										</div>
									</div>

									<div class="row">
										<div class="col l12">
											<input onchange="showLicense()"  class="with-gap" name="comercialLicense" type="radio" id="comercialYes"/>
											<label for="comercialYes">Sim</label>

											<input onchange="showLicense()" class="with-gap" name="comercialLicense" type="radio" id="comercialNo"/>
											<label for="comercialNo">Não</label>
										</div>
									</div>
								</div>

								<div class="col l6 s12">
									<div class="row no-margin">
										<div class="col l12 valign-wrapper">
											<p class="valign no-margin">Permitir que adaptações do seu trabalho sejam compartilhadas?</p>
											<i class="material-icons tooltipped cursor-pointer valign" data-tooltip="Mais informações" onclick="openThisModal('modalShareAsLike')">&nbspinfo</i>
										</div>
									</div>

									<div class="row">
										<div class="col l12 valign-wrapper">
											<input class="with-gap" name="shareGame" type="radio" id="shareYes" disabled checked="checked"/>
											<label for="shareYes">Sim, desde que outros compartilhem igual <span class="required-indicator">*</span></label>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col l6">
									<div id="license-container" style="display: none">
										<input type="hidden" name="license" value="cc-by" id="licenseValue" >
										<div class="row">
											<div class="col s12" id="licenseImage">
											</div>
										</div>
									</div>
								</div>

								<div class="col l6">
									<button class="btn waves-effect waves-light my-orange" onclick="confirmLicense()" name="save" id="submitButton" style="margin-top:25px">
										Enviar
									</button>
								</div>
							</div>

							<!-- Botão Enviar -->
							<div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:20px">

							</div>
						</div>
						<br class="clear" />
					</div>
				</li>

				<li id="info-add-container" class="no-margin" style="position: relative; width: 100% !important">

					<a href="#modal-exportdata" id="import-button" class="btn-floating waves-effect waves-light remar-orange tooltipped modal-trigger" data-tooltip="Importar dados"  data-position="top" style="position: absolute; right: 0px; margin:13px;">
						<i class="material-icons">file_upload</i>
					</a>

					<div id="info-add" class="collapsible-header" style="padding:10px">
						Informações adicionais
					</div>
					<div class="collapsible-body">
						<div class="row loaded-form">
							%{-- TODO mudar controlador --}%
							<input type="hidden" name="id" id="hidden" value="">
							<div class="col-s12" >
								<g:render template="form"/>
							</div>
						</div>
					</div>
				</li>
			</ul>

		</div>
	</div>
</div>

<div id="modalComercial" class="modal">
	<div class="modal-content">
		<h4>Permitir usos comerciais do seu trabalho?</h4>
		<div class="row">
			<div class="col s6 m6 l6 license">
				<h5>Sim</h5>
				<p align="justify">O licenciante autoriza que outros copiem, distribuam, exibam e executem o trabalho, inclusive para fins comerciais.</p>
			</div>
			<div class="col s6 m6 l6 license">
				<h5>Não</h5>
				<p align="justify">O licenciante autoriza que outros copiem, distribuam, exibam e executem o trabalho somente para fins não comerciais.</p>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#!" class="  btn btn-large modal-close my-orange">Entendi</a>
	</div>
</div>

<div id="modalShareAsLike" class="modal">
	<div class="modal-content">
		<h4>Permitir que adaptações do seu trabalho sejam compartilhadas?</h4>
		<div class="row">
			<div class="col s12 m12 l12 license">
				<h5 align="left">Sim, desde que os outros compartilhem igual</h5>
				<p align="justify">O licenciante autoriza que outros criem e distribuam trabalhos derivados, mas apenas ao abrigo da mesma licença ou de uma licença <a target="_blank" href="https://creativecommons.org/compatiblelicenses/">compatível</a>.</p>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#!" class=" btn btn-large modal-close my-orange">Entendi</a>
	</div>
</div>

<div id="modalConfirmLicense" class="modal">
	<div class="modal-content">
		<h4>Você tem certeza que deseja escolher esta licença?</h4>
		<div class="row">
			<div class="col s12 m12 l12">
				<p align="justify">Após escolher a licença do seu modelo, você não poderá alterá-la posteriormente.</p>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange" onclick="submit()" style="margin-right: 10px;">Sim</a>
		<a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange" onclick="return false;" style="margin-right: 10px;">Não</a>
	</div>
</div>

<div id="modal-picture" class="modal remar-modal">
	<div class="modal-content">
		<h4>Upload de Imagem</h4>
		<div class="img-container">
			<img id="crop-preview" class="responsive-img">
		</div>
	</div>
	<div class="modal-footer">
		<a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
		<a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Enviar</a>
	</div>
</div>

<div class="modal-wrapper-50">
	<div id="modal-exportdata" class="modal remar-modal">
		<div class="modal-content text-justify">
			<h4>Importar dados de uma planilha</h4>
			<div id="data-import" class="row">
				<p>Se você deseja preencher automaticamente os campos:</p>
				<ul class="collection">
					<li class="collection-item">Descrição</li>
					<li class="collection-item">Info</li>
					<li class="collection-item">Itens Customizáveis</li>
					<li class="collection-item">Link de Vídeo Tutorial</li>
					<li class="collection-item">Documentação</li>
				</ul>
				<p>Então insira um arquivo <strong>.csv</strong>, <strong>.xls</strong> ou <strong>.xlsx</strong> no campo abaixo (<a href="/samples/ModeloPreencheDesenvolvedor.xlsx">baixe o modelo padrão</a>):</p>
				<div class="row no-margin valign-wrapper">
					<div class="col s12">
						<div class="file-field input-field">
							<div class="btn">
								<span>Arquivo</span>
								<input id="arquivo" type="file" name="spreadsheet-file">
							</div>
							<div class="file-path-wrapper">
								<input class="file-path validate" type="text">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<a id="send-import" class="btn">Enviar</a>
			<a id="cancel-import" class="btn modal-action modal-close">Cancelar</a>
		</div>
	</div>
</div>

<g:external dir="css" file="resource.css"/>

<script type="text/javascript" src="${resource(dir: 'js', file: "remar/imgPreview.js")}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'remar/game-index.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'remar/validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'remar/license.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/libs/jquery', file: 'jquery.jcrop.js')}"></script>
</body>

</html>
