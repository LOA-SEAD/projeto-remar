<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">
	<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
	<title>${resourceInstance.name}</title>
</head>

<body>
	<div class="content">
		<div class="row">
			<form action="/process/start/${resourceInstance.uri}" method="POST">
				<input type="hidden" name="id" value="${resourceInstance.id}" id="hidden">
				<div class="card col l12 s11 m11" style="position: relative; left: 1.2em;">
					<div class="col l12">
						<div class="card-content">
							<img class="col l4 s5 m3" src="/images/${resourceInstance.uri}-banner.png">
							<div class="col l6 s4 m7">
								<span class="card-title black-text truncate left" style="font-size: 1.6em;" data-id="${resourceInstance.id}">${resourceInstance.name}</span><br>
							</div>
							<div class="col l4 s4 m5">
								<span style="color: dimgrey" class="left"> ${resourceInstance.category.name}</span>
							</div>
							<div class="stars hide-on-small-only col l4">
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

							<div class="col l8 m7 s7">
								<img  class="col l2 s5 m3" src="/data/users/${resourceInstance.owner.username}/profile-picture" alt="Contact Person">
								<span style="color: dimgrey" class="left">${resourceInstance.owner.firstName} ${resourceInstance.owner.lastName}</span><br>
								<span style="color: dimgrey" class="hide-on-small-only left"> ${resourceInstance.owner.email} </span>

							</div>
							<div class="col l8 m9">
								<div class="platform gray-color">
									<p class="" style="font-size: 16px; display: inline-block;"><strong> Disponível para: </strong></p>
									<div class="">
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
							</div>

							<div class="col l8 m9">
								<div class="platform gray-color">
									<p class="" style="font-size: 16px; display: inline-block;"><strong> Grupos (Compartilhamento): </strong></p>
									<div class="">
										<g:if test="${resourceInstance.shareable}">
											<p class="" style="font-size: 16px; display: inline-block;">Sim</p>
										</g:if>
										<g:else>
												<p class="" style="font-size: 16px; display: inline-block;"> Não </p>
										</g:else>

									</div>
								</div>
							</div>

							<div class="col l8 m8">
								<button type="submit" class="btn waves-effect waves-light my-orange right">
									Criar jogo
								</button>
							</div>
						</div>
					</div>
					<br class="clear" />
					<div class="row"></div>
					<div class="divider"></div>
					<div class="slider" style="margin-top: 50px;">
						<ul class="slides">
							%{--Imagens devem ter 720x400 pixels --}%
							<li><img src="/data/resources/assets/${resourceInstance.uri}/description-1" width="auto" height="400px"></li>
							<li><img src="/data/resources/assets/${resourceInstance.uri}/description-2" width="auto" height="400px;"></li>
							<li><img src="/data/resources/assets/${resourceInstance.uri}/description-3" width="auto" height="400px;"></li>
						</ul>
					</div>

					<div class="row">
						<div class="col s12 m12 l12">
							<p class="description" style="text-align: justify"><strong>Descrição:</strong> ${resourceInstance.description}</p>
						</div>
					</div>
					<div class="row">
						<div class="col s12 m12 l12">
							<p style="text-align: justify"><strong>Itens customizáveis:</strong> ${resourceInstance.customizableItems}</p>
						</div>
					</div>
					<div class="row">
						<div class="col s12 m12 l12">
							<g:if test="${resourceInstance.videoLink == null}">
								<p><strong>Vídeo Tutorial:</strong> Não Disponível</p>
							</g:if>
							<g:else>
								<p><strong>Vídeo Tutorial:</strong><a target="_blank" href="${resourceInstance.videoLink}"> Clique aqui</a> </p>
							</g:else>
						</div>
					</div>
					<div class="row">
						<div class="col s12 m12 l12" id="documentation">
							<g:if test="${resourceInstance.documentation == null}">
								<p><strong>Documentação do Modelo:</strong> Não Disponível</p>
							</g:if>
							<g:else>
								<p><strong>Documentação do Modelo:</strong><a target="_blank" href="${resourceInstance.documentation}"> ${resourceInstance.name}</a> </p>
							</g:else>
						</div>
					</div>
					<div class="row"></div>
					<div class="row"></div>
					<input type="hidden" id="licenseValue" value="${resourceInstance.license}">
					<div class="row">
						<div class="col s12 m12 l12" id="licenseInfo">

						</div>
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
									<li id="rating${rating.id}" class="collection-item avatar">
										<input type="hidden" name="user-id" value="${rating.user.id}" id="user-id">
										<img src="/data/users/${rating.user.username}/profile-picture" alt="${rating.user.firstName}" class="circle">

										<g:if test="${rating.user.id == session.user.id}">
											<ul id='dropdown${rating.id}' class='my-dropdown'>
												<li>
													<a title="Editar" onclick="editRating(${rating.id})" class="edit-rating" id-rating="${rating.id}">
														<i class="fa fa-pencil"></i>
													</a>
												</li>
												<li>
													<a title="Excluir" onclick="deleteRating(${rating.id})" class="delete-rating" id-rating="${rating.id}">
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
										<div id="rateYo${rating.id}" class="left rating-stars" style="display: inline-block;" data-stars="${rating.stars * 2}"
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


	<div id="modal-comment" class="modal remar-modal">
		<div class="modal-content">
			<h4>Deixe seu comentário</h4>
			<div class="row">
				<form class="col s12">
					<div class="row">
						<div class="col s12">
							<label for="rateYo">Qual a sua nota?</label>
							<br>
							<div id="rateYo" style="display: inline-block;"></div>
							<div class="counter"></div>
							<div style="clear: both"></div>
						</div>
					</div>
					<div class="row">
						<div class="input-field center">
							<textarea required id="comment-area" class="materialize-textarea"></textarea>
							<label for="comment-area">Comentário</label>
							<span id="comment-error" class="invalid-textarea" style="display: block; left: 2.75rem;">Este campo não pode ser vazio!</span>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!" id="create-rating" class="modal-action modal-close btn waves-effect waves-light remar-orange">Enviar</a>
			<a href="#!" id="edit-rating" class="modal-action modal-close btn waves-effect waves-light remar-orange">Salvar</a>
			<a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
		</div>
	</div>

	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.0.1/jquery.rateyo.min.css">
	<g:external dir="css" file="resource.css"/>

	<g:javascript src="libs/jquery/jquery.rateyo.min.js"/>
	<g:javascript src="remar/licenseShow.js"/>
	<g:javascript src="remar/rating.js" />
</body>
</html>

