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
						<div class="box-body">
							<div class="direct-chat-messages page-size" >
								<div class="widget-content-white glossed">
									<div class="padded">
										<div class="row">
											<g:form class="" url="[resource:gameInstance, action:'save']" enctype="multipart/form-data" useToken="true">

												<div class="form-group has-feedback" >
													<div class="input-group">
														<span class="input-group-btn">
															<span class="btn btn-primary btn-file btn-flat">
																Selecionar <input name="war" type="file"  multiple >
															</span>
														</span>
														<input type="text" class="form-control" placeholder="WAR file..." readonly>
														<span class="input-group-btn">
															<button name="create" class="btn btn-primary btn-file btn-flat" >
																<i class="fa fa-upload"></i>
															</button>
														</span>
													</div>
												</div>

											</g:form>

										</div>

										<div class="row">
											%{-- TODO mudar controlador --}%
											<g:form url="[action: 'update']" method="PUT" enctype="multipart/form-data">
												<input type="hidden" name="id" value="${id}">
												<div class="col-xs-6" >
													<g:render template="form"/>
												</div>
											</g:form>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
		<script>
			$(document).ready(function() {
				$('textarea#textarea1').characterCounter();
			});
		</script>

	</body>
</html>
