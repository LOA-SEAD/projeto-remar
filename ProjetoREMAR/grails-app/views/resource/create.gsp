<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="materialize-layout">
		<title>Novo Jogo</title>
	</head>
	<body>
		<div class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-body box-info">
						<p class="left-align margin-bottom" style="font-size: 24px;">
							<i class="left small material-icons">games</i>Submeter modelo de jogo
						</p>
						<div class="divider"></div>
						<br />
						<div class="row show">
							<ul class="collapsible popout" data-collapsible="accordion">
								<li>
									<div class="collapsible-header active"><i class="material-icons">filter_drama</i>Upload War</div>
									<div class="collapsible-body">
										<div class="file-field input-field">
											<div class="btn waves-effect waves-light my-orange col s2">
												<span>Arquivo</span>
												<input type="file" required name="war" id="war" accept=".war">
											</div>
											<div class="file-path-wrapper col s10">
												<input class="file-path validate" type="text" name="create" required placeholder="Selecione o arquivo do seu jogo (.war)" readonly>
											</div>
											<div class="col s12" >
												<div id="preloader-wrapper" class="preloader-wrapper small active right">
													<div class="spinner-layer spinner-red-only">
														<div class="circle-clipper left">
															<div class="circle"></div>
														</div><div class="gap-patch">
														<div class="circle"></div>
													</div><div class="circle-clipper right">
														<div class="circle"></div>
													</div>
													</div>
												</div>
												<div class="row">
													<div class="col s12 m12 l12">
															<p> <i  class="material-icons tooltipped cursor-pointer" data-tooltip="Mais informações" onclick="openThisModal('modalShareAsLike')">info</i> Permitir que adaptações do seu trabalho sejam compartilhadas?</p>
														<input readonly class="with-gap" checked="checked" name="shareLicense" type="radio" id="shareYesAsLike"/>
														<label for="shareYesAsLike">Sim, desde que outros compartilhem igual  <span class="required-indicator">*</span> </label>
													</div>
												</div>
												<div class="row">
													<div class="col s12 m12 l12">
														<p><i class="material-icons tooltipped cursor-pointer" data-tooltip="Mais informações" onclick="openThisModal('modalComercial')">info</i> Permitir usos comerciais do seu trabalho?</p>
														<input onchange="showLicense()"  class="with-gap" name="comercialLicense" type="radio" id="comercialYes"/>
														<label for="comercialYes">Sim</label>
														<input onchange="showLicense()" class="with-gap" name="comercialLicense" type="radio" id="comercialNo"/>
														<label for="comercialNo">Não</label>
													</div>
												</div>
												<br>
												<input type="hidden" name="license" value="cc-by" id="licenseValue" >
												<div class="row">
													<div class="col s12" id="licenseImage">

													</div>
												</div>

												<br>

												<!-- Botão Enviar -->
												<div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:20px">
													<button class="btn waves-effect waves-light my-orange" data-delay="5" data-tooltip="Enviar" onclick="confirmLicense()" type="submit" name="save" id="submitButton">
														Enviar
													</button>
												</div>



												<!--<div class="send-war right">
													<a href="#!" data-position="bottom" data-delay="5" data-tooltip="Enviar" class="waves-effect waves-light btn-flat send" onclick="confirmLicense()">
														Enviar <i class="material-icons send-icon" style="color: green;">done</i>
													</a>
												</div>
												-->



											</div>
											<br class="clear" />
										</div>
									</div>
								</li>
								<li>
									<div id="info-add" class="collapsible-header"><i class="material-icons">info_outline</i>Informações adicionais</div>
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
			</div>
		</div>
	<!-- Modal Structure -->
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

	<!-- Modal Structure -->
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

	<!-- Modal Structure -->
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
			<a href="#!" class=" btn btn-large modal-close my-orange" onclick="submit()">Sim, tenho certeza</a>
			<a href="#!" class=" btn btn-large modal-close disabled" onclick="return false;">Não</a>
		</div>
	</div>

    <div id="modal-picture" class="modal">
        <div class="modal-content center">
            <img id="crop-preview" class="responsive-img">
        </div>
        <div class="modal-footer">
            <a href="#!" class="modal-action modal-close waves-effect btn-flat">Enviar</a>
        </div>
    </div>

		<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'game-index.js')}"></script>
	    <script type="text/javascript" src="${resource(dir: 'js', file: 'validate.js')}"></script>
    	<script type="text/javascript" src="${resource(dir: 'js', file: 'license.js')}"></script>
	    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.Jcrop.js')}"></script>
    </body>
</html>
