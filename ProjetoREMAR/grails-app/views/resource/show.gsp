<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">
	<title>${resourceInstance.name}</title>
</head>
<body>
<div class="content">
	<div class="row show">
		<div class="col l12 m12 s12">
			<form action="/process/start/${resourceInstance.uri}" method="POST">
				<div class="card show-personalize">
					<div class="card-content ">
						<div class="card-content " style="margin-bottom: 10px;">
							<div class="image">
								<img src="/images/${resourceInstance.uri}-banner.png" class="">
							</div>
							<span class="card-title black-text truncate" data-id="${resourceInstance.id}">${resourceInstance.name}</span>
							<input type="hidden" name="id" value="${resourceInstance.id}" id="hidden">
							<div class="category">
								<p> ${resourceInstance.category.name}</p>
								<div class="stars hide-on-small-only">
									<g:if test="${resourceInstance.sumUser == 0}">
										<div id="rateYo-main" style="display: inline-block;"
											 data-stars="0"></div>
									</g:if>
									<g:else>
										<div id="rateYo-main" style="display: inline-block;"
											 data-stars="${resourceInstance.sumStars/resourceInstance.sumUser}"></div>
									</g:else>

									<span id="users">(${resourceInstance.sumUser})</span>
									<i class="fa fa-users"></i>
								</div>
							</div>

							<div class="chip-dev">

								<img class="img-responsive" src="/data/users/${resourceInstance.owner.username}/profile-picture" alt="Contact Person">
								<p>
									${resourceInstance.owner.firstName} ${resourceInstance.owner.lastName} <br>
									<span class="hide-on-small-only"> ${resourceInstance.owner.email} </span>


								<div class="hide-on-med-and-up" style="color: rgba(0, 0, 0, 0.6);">
										<i class="fa fa-globe tooltipped" data-position="bottom" data-delay="30" data-tooltip="Web"></i>
										<g:if test="${resourceInstance.android}">
											<i class="fa fa-android tooltipped" data-position="bottom" data-delay="30" data-tooltip="Android"></i>
										</g:if>
										<g:if test="${resourceInstance.desktop}">
											<i class="fa fa-desktop tooltipped" data-position="bottom" data-delay="30" data-tooltip="Moodle"></i>
										</g:if>
										<g:if test="${resourceInstance.moodle}">
											<i class="fa fa-graduation-cap tooltipped" data-position="bottom" data-delay="30" data-tooltip="Moodle"></i>
										</g:if>
									</div>
								</p>

							</div>

							<div class="plataform gray-color">
								<p class="hide-on-med-and-down" style="font-size: 16px; display: inline-block;"> Disponível para: </p>
								<div class="hide-on-small-only">
									<i class="fa fa-globe tooltipped" data-position="bottom" data-delay="30" data-tooltip="Web"></i>
									<g:if test="${resourceInstance.android}">
										<i class="fa fa-android tooltipped" data-position="bottom" data-delay="30" data-tooltip="Android"></i>
									</g:if>
									<g:if test="${resourceInstance.desktop}">
										<i class="fa fa-windows tooltipped" data-position="bottom" data-delay="30" data-tooltip="Windows"></i>
										<i class="fa fa-linux tooltipped" data-position="bottom" data-delay="30" data-tooltip="Linux"></i>
										<i class="fa fa-apple tooltipped" data-position="bottom" data-delay="30" data-tooltip="Mac"></i>
									</g:if>
									<g:if test="${resourceInstance.moodle}">
										<i class="fa fa-graduation-cap tooltipped" data-position="bottom" data-delay="30" data-tooltip="Moodle"></i>
									</g:if>

								</div>
							</div>

							%{--<div class="info"></div>--}%
							<br class="clear" />

							<button type="submit" class="btn waves-effect waves-light my-orange right">
								Customizar
							</button>
						</div>
						<input type="hidden" id="licenseValue" value="${resourceInstance.license}">

						<div class="row">
							<div class="col s12 m12 l12" id="documentation">
								<p>Documentação do modelo: <a target="_blank" href="${resourceInstance.documentation}">${resourceInstance.documentation}</a> </p>
							</div>
						</div>
						<div class="row">
							<div class="col s12 m12 l12 license" id="licenseInfo">

							</div>
						</div>
						<br class="clear" />
						<div class="slider">
							<ul class="slides">
								%{--Imagens devem ter 720x400 pixels --}%
							    <li><img src="/data/resources/assets/${resourceInstance.uri}/description-1" width="auto" height="400px"></li>
								<li><img src="/data/resources/assets/${resourceInstance.uri}/description-2" width="auto" height="400px;"></li>
								<li><img src="/data/resources/assets/${resourceInstance.uri}/description-3" width="auto" height="400px;"></li>
							</ul>
						</div>

						<p class="description">${resourceInstance.description}</p>
					</div>
					<div class="card-action">
						<p class="left comment-text">Comentários</p>
						<a  href="#modal-comment" class="modal-trigger btn-floating btn-large waves-effect waves-light right tooltipped"
						   data-position="bottom" data-delay="50" data-tooltip="Escrever comentário">
							<i class="material-icons">edit</i>
							<i class="fa fa-pencil-square-o"></i>
						</a>

						<div class="clearfix"></div>
						<ul class="collection rating">
							<g:if test="${resourceInstance.ratings.size() > 0}">
								<g:each in="${resourceInstance.ratings.sort{it.date}.reverse()}" var="rating">
									<li class="collection-item avatar">
										<input type="hidden" name="user-id" value="${rating.user.id}" id="user-id">
										<img src="/data/users/${rating.user.username}/profile-picture" alt="${rating.user.firstName}" class="circle">

										<g:if test="${rating.user.id == session.user.id}">
											<ul id='dropdown${rating.id}' class='my-dropdown'>
												<li>
													<a href="#!" title="Editar" class="edit-rating" id-rating="${rating.id}">
														<i class="fa fa-pencil"></i>
													</a>
												</li>
												<li>
													<a href="#!" title="Excluir" class="delete-rating" id-rating="${rating.id}">
														<i class="fa fa-trash"></i>
													</a>
												</li>
											</ul>
											<a id="more-vert" class='right dropdown-button' href='#' data-activates='dropdown${rating.id}'>
												<i class="material-icons">more_vert</i>
											</a>
										</g:if>

										<g:if test='${(rating.date - today) < 0}'>
											<p class="title">${rating.user.firstName} <small>- <g:formatDate format="dd/MM/yyyy" date="${rating.date}"/></small></p>
										</g:if>
										<g:else>
											<p class="title">${rating.user.firstName} <small>- <g:formatDate format="HH:mm" date="${rating.date}"/></small></p>
										</g:else>
										<p class="rating-desc">${rating.comment}</p>
										<div id="rateYo${rating.id}" class="left rating-stars" style="display: inline-block;" data-stars="${rating.stars}"
											 data-rating-id="${rating.id}" data-medium-stars="" data-sum-users="">
										</div>
										<p class="stars-font">(0)</p>
										<div class="clearfix"></div>
									</li>
								</g:each>
							</g:if>
							<g:else>
								<li id="not-comment"> Ainda não há comentários sobre este jogo!</li>
							</g:else>
						</ul>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- Modal Structure -->
<div id="modal-comment" class="modal">
	<div class="modal-content">
		<h4><i class="material-icons">edit</i> Deixe seu comentário</h4>
		<div class="row">
			<form class="col s12">
				<div class="row">
					<div class="col s12">
						<label for="rateYo">Qual a sua nota?</label>
						<div id="rateYo" style="display: inline-block;"></div>
						<div class="counter" style="
													font-weight: bold;
													margin-left: 10px;
													margin-top: 7px;
													display: inline-block;">
						</div>
						<div style="clear: both"></div>
					</div>
				</div>
				<div class="row">
					<div class="input-field center">
						<i class="material-icons prefix">input</i>
						<textarea required id="comment-area" class="materialize-textarea"></textarea>
						<label for="comment-area">Comentário</label>
						<span id="comment-error" class="invalid-textarea" style="display: block; left: 2.75rem;">Este campo não pode ser vazio!</span>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="modal-footer">
		<a id="create-rating" href="#!" class="modal-action waves-effect waves-green btn-flat ">Enviar</a>
		<a id="edit-rating" href="#!" class="modal-action waves-effect waves-green btn-flat ">Salvar</a>
	</div>
</div>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.0.1/jquery.rateyo.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.0.1/jquery.rateyo.min.js"></script>
<g:javascript src="licenseShow.js"/>
<g:javascript src="rating.js" />
<g:javascript src="tooltip.js" />
</body>
</html>

