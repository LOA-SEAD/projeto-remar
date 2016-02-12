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
							<i class="left small material-icons">games</i>Submeter jogo
						</p>
						<div class="divider"></div>
						<br />
						<div class="row show">
							%{--<div class="row show"></div>--}%
							<ul class="collapsible popout" data-collapsible="accordion">
								<li>
									<div class="collapsible-header active"><i class="material-icons">filter_drama</i>Upload War</div>
									<div class="collapsible-body">
										<div class="file-field input-field">
											<div class="btn waves-effect waves-light my-orange col s2">
												<span>File</span>
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
												<div class="send-war right">
													<a href="#!" data-position="bottom" data-delay="5" data-tooltip="Enviar" class="waves-effect waves-light btn-flat send">
														Enviar <i class="material-icons send-icon" style="color: green;">done</i>
													</a>
												</div>
											</div>
											<br class="clear" />
										</div>
										%{--<div class="progress">--}%
											%{--<div class="determinate" style="width: 0;"></div>--}%
										%{--</div>--}%
									</div>
								</li>
								<li>
									<div id="info-add" class="collapsible-header"><i class="material-icons">info_outline</i>Informações adicionais</div>
									<div class="collapsible-body">
										%{--<p>Lorem ipsum dolor sit amet.</p>--}%
										<div class="row loaded-form">
										%{-- TODO mudar controlador --}%
											%{--<g:form url="[action: 'update']" enctype="multipart/form-data">--}%
												<input type="hidden" name="id" id="hidden">
												<div class="col-s12" >
													<g:render template="form"/>
												</div>
											%{--</g:form>--}%
										</div>
									</div>
								</li>
							</ul>
							%{--<div class="direct-chat-messages page-size" >--}%
								%{--<div class="widget-content-white glossed">--}%
									%{--<div class="padded">--}%
										%{--<div class="row">--}%
											%{--<div class="form-group has-feedback" >--}%

											%{--</div>--}%
										%{--</div>--}%


									%{--</div>--}%
								%{--</div>--}%
							%{--</div>--}%
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'game-index.js')}"></script>
	</body>
</html>
