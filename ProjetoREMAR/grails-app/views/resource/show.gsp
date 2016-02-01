<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">
	<title>${resourceInstance.name}</title>

	<!-- jQuery 2.1.4 -->
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
	<script>
//		$(function(){
//			$('.slider').slider('start');
//		});
		$(document).ready(function(){
			$('.slider').slider('start');
		});
	</script>

</head>
<body>
<div class="content">
	<div class="row show">
		<div class="col l12 m12 s12">
			<form action="/process/start/${resourceInstance.bpmn}" method="POST">
				<div class="card show-personalize">
					<div class="card-content ">
						<div class="card-content " style="margin-bottom: 10px;">
							<div class="image">
								<img src="/images/${resourceInstance.uri}-banner.png" class="">
							</div>
							<span class="card-title black-text truncate">${resourceInstance.name}</span>
							<div class="category">
								<p> Ação</p>
								<div class="stars">
									<img src="/images/star.png" width="14" height="14" alt="Estrela">
									<img src="/images/star.png" width="14" height="14" alt="Estrela">
									<img src="/images/star.png" width="14" height="14" alt="Estrela">
									<img src="/images/star.png" width="14" height="14" alt="Estrela">
									<img src="/images/star.png" width="14" height="14" alt="Estrela">
								</div>
							</div>

							<div class="chip-dev">
								<img class="img-responsive" src="/data/users/${resourceInstance.owner.username}/profile-picture" alt="Contact Person">
								<p>
									${resourceInstance.owner.firstName} ${resourceInstance.owner.lastName} <br>
									<span class="hide-on-small-only"> ${resourceInstance.owner.email} </span>

									<div class="hide-on-med-and-up" style="color: rgba(0, 0, 0, 0.6);">
										<i class="fa fa-globe"></i>
										<g:if test="${resourceInstance.android}">
											<i class="fa fa-android"></i>
										</g:if>
										<g:if test="${resourceInstance.linux}">
											<i class="fa fa-linux"></i>
										</g:if>
										<g:if test="${resourceInstance.moodle}">
											<i class="fa fa-graduation-cap"></i>
										</g:if>
									</div>
								</p>
							</div>

							<div class="plataform gray-color">
								<p class="hide-on-med-and-down" style="font-size: 16px; display: inline-block;"> Disponível para: </p>
								<div class="hide-on-small-only">
									<i class="fa fa-globe"></i>
									<g:if test="${resourceInstance.android}">
										<i class="fa fa-android"></i>
									</g:if>
									<g:if test="${resourceInstance.linux}">
										<i class="fa fa-linux"></i>
									</g:if>
									<g:if test="${resourceInstance.moodle}">
										<i class="fa fa-graduation-cap"></i>
									</g:if>
								</div>
							</div>
							%{--<div class="info"></div>--}%
							<br class="clear" />
							<button type="submit" class="btn waves-effect waves-light my-orange right">
								Personalizar
							</button>
						</div>
						<br class="clear" />
						<div class="slider">
							<ul class="slides">
								<li>
									<!-- tamanho ideal para imagem 500x250 -->
									<img src="/data/resources/assets/${resourceInstance.uri}/description-1">
									%{--<div class="caption center-align">--}%
										%{--<h3>This is our big Tagline!</h3>--}%
										%{--<h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>--}%
									%{--</div>--}%
								</li>
								<li>
									<img src="/data/resources/assets/${resourceInstance.uri}/description-2">
									%{--<img src="/data/resources/assets/${resourceInstance.uri}/teste.jpg">--}%
								</li>
								<li>
									<img src="/data/resources/assets/${resourceInstance.uri}/description-3">
								%{--<img src="/data/resources/assets/${resourceInstance.uri}/teste.jpg">--}%
								</li>
								%{--<li>--}%
									%{--<img src="/data/resources/assets/${resourceInstance.uri}/description-1">--}%
								%{--</li>--}%
								%{--<li>--}%
									%{--<img src="/data/resources/assets/${resourceInstance.uri}/description-1">--}%
								%{--</li>--}%
							</ul>
						</div>

						<p class="">${resourceInstance.description}</p>
					</div>
					%{--<div class="card-action">--}%
						%{--<a href="#">This is a link</a>--}%
						%{--<a href="#">This is a link</a>--}%
					%{--</div>--}%
				</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>
