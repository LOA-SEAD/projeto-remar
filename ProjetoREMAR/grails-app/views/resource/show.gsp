<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="new-main-inside">
	<title>R.E.A.</title>

	<!-- jQuery 2.1.4 -->
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>


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
					<div class="direct-chat-messages page-size">

						<form action="/process/start/${resourceInstance.bpmn}" method="POST">
							<div class="row">
								<div class="col-xs-4">
									<img src="/images/${resourceInstance.uri}-banner.png"
										 class="img img-responsive img-bordered-sm" style="background-color: #3c8dbc;"/>
								</div>
								<div class="col-xs-4">
									<h1>${resourceInstance.name}</h1>
									<span id="development" class="info-box-number">
										<img class="img-circle" alt="User Image" src="assets/img/inside/avatar.png"
											 height="25" width="25"/>
										REMAR
									</span>
								</div>
								<div class="col-xs-4">
									<div style="">
										<button type="submit" class="btn btn-primary btn-file btn-flat">
											Personalizar
										</button>
									</div>

								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
									<img src="/data/resources/assets/${resourceInstance.uri}/description-1"
										 class="img img-responsive img-bordered-sm" />
								</div>
								<div class="col-lg-4">
									<img src="/data/resources/assets/${resourceInstance.uri}/description-1"
										 class="img img-responsive img-bordered-sm" />
								</div>
								<div class="col-lg-4">
									<img src="/data/resources/assets/${resourceInstance.uri}/description-1"
										 class="img img-responsive img-bordered-sm" />
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<p>${resourceInstance.description}</p>
								</div>
							</div>


							%{--<div class="box-body">--}%
								%{--<span class="" style="display: inline-block;">--}%
								%{----}%
								%{--</span>--}%

								%{--<div class="" style="display: inline-block; margin-left: 20px; vertical-align: top">--}%
									%{----}%
								%{--</div><!-- /.info-box-content -->--}%
								%{--<div class="pull-right" style="vertical-align:bottom;">--}%
									%{----}%
								%{--</div>--}%
							%{--</div><!-- /.info-box -->--}%



						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>
