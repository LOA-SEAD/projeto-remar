<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="new-main-inside">
		<title>Novo R.E.A.</title>

		<!-- jQuery 2.1.4 -->
		<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>


	</head>
	<body>
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-body box-info">
					<div class="box-header with-border">
						<h3 class="box-title">
							<i class="fa fa-upload"></i>
							Novo R.E.A.
						</h3>
					</div><!-- /.box-header -->
					<div class="box-body">
						<div class="direct-chat-messages page-size" >
							<div class="widget-content-white glossed">
								<div class="padded">
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

	</body>
</html>
