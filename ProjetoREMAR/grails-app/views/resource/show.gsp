<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">
	<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
	<title>${resourceInstance.name}</title>
</head>

<body>
<div class="row cluster">

	<div class="row show">
		<div class="row cluster-header">
			<h4>${resourceInstance.name}</h4>
			<div class="divider"></div>
		</div>
	</div>

	<div class="row no-margin">
		<div class="col l2 s12 m3">
			<img class="responsive-img" src="/images/${resourceInstance.uri}-banner.png">
		</div>

		<div class="col l9 s12 m4">

			<div class="row">

				<div class="col l4">

					<div class="row no-margin">
						<p class="gray-color no-margin" style="font-size: 16px;"><strong> Gênero</strong></p>
					</div>
					<div class="row">
						<div class="col l12 s12 m9 no-padding">
							<div class="platform gray-color no-margin">
								<span style="font-size: 16px;">${resourceInstance.category.name}</span>
							</div>
						</div>
					</div>

					<div class="row no-margin">
						<p class="gray-color no-margin" style="font-size: 16px;"><strong> Plataformas</strong></p>
					</div>
					<div class="row">
						<div class="col l12 s12 m9 no-padding">
							<div class="platform gray-color no-margin">
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

					<div class="row no-margin">
						<p class="gray-color no-margin" style="font-size: 16px;"><strong> Suporte a grupos</strong></p>
					</div>
					<div class="row">
						<div class="col l12 m12 s12 no-padding">
							<div class="platform gray-color no-margin">
								<div class="">
									<g:if test="${resourceInstance.shareable}">
										<span style="font-size: 16px;">Sim</span>
									</g:if>
									<g:else>
										<span style="font-size: 16px;"> Não </span>
									</g:else>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col l5">

					<div class="row no-margin hide-on-small-only">
						<p class="gray-color no-margin" style="font-size: 16px"><strong> Avaliação</strong></p>
					</div>
					<div class="row hide-on-small-only">
						<div class="col l12 s12 valign-wrapper no-padding">
							<div class="stars">
								<g:if test="${resourceInstance.sumUser == 0}">
									<div id="rateYo-main" style="display: inline-block;" data-stars="0"></div>
								</g:if>
								<g:else>
									<div id="rateYo-main" style="display: inline-block;" data-stars="${resourceInstance.sumStars*2/resourceInstance.sumUser}"></div>
								</g:else>

								<span id="users">(${resourceInstance.sumUser})</span>
								<%-- i class="fa fa-users"></i--%>
							</div>
						</div>
					</div>


					<div class="row no-margin">
						<p class="gray-color no-margin" style="font-size: 16px;"><strong>Autoria</strong></p>
					</div>
					<div class="row">

						<div class="col l12 no-padding">
							<div class="row no-margin valign-wrapper">
<%--
								<div class="col l2 s3 no-padding">
									<img class="responsive-img" src="/data/users/${resourceInstance.owner.username}/profile-picture" alt="Contact Person">
								</div>
--%>
								<div class="col l10 s9">
<%--
									<span style="color: dimgrey" class="left">${resourceInstance.owner.firstName} ${resourceInstance.owner.lastName}</span><br>
									<span style="color: dimgrey" class="hide-on-small-only left"> ${resourceInstance.owner.email} </span>

--%>

<span style="color: dimgrey" class="left">${resourceInstance.info} </span><br>

								</div>
							</div>
						</div>
					</div>

					<div class="row left-align no-margin">
						<div class="col s12">
							<button type="submit" class="btn waves-effect waves-light my-orange" id="createGame">
								Criar jogo
							</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>



	<div class="row show">
		<div class="row cluster-header">
			<h4>Detalhes do modelo</h4>
			<div class="divider"></div>
		</div>
	</div>

	<div class="row">

		<input type="hidden" name="id" value="${resourceInstance.id}" id="hiddenId">

		<div class="row">
			<div class="col s7">
				<div class="slider" style="width: 800px; margin: 0 auto;"> <!-- Tornar responsivo! -->
					<ul class="slides">
						%{--Imagens devem ter 720x400 pixels --}%
						<li><img src="/data/resources/assets/${resourceInstance.uri}/description-1" width="auto" height="400px"></li>
						<li><img src="/data/resources/assets/${resourceInstance.uri}/description-2" width="auto" height="400px"></li>
						<li><img src="/data/resources/assets/${resourceInstance.uri}/description-3" width="auto" height="400px"></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col s12 m12 l7">
				<g:if test="${resourceInstance.description == null}">
					<p><strong>Descrição:</strong> Não Disponível</p>
				</g:if>
				<g:else>
					<p><strong>Descrição:</strong> ${resourceInstance.description}</p>
				</g:else>
			</div>
		</div>

		<div class="row">
			<div class="col s12 m12 l7">
				<g:if test="${resourceInstance.customizableItems == null}">
					<p><strong>Itens customizáveis:</strong> Não Disponível</p>
				</g:if>
				<g:else>
					<p><strong>Itens customizáveis:</strong> ${resourceInstance.customizableItems}</p>
				</g:else>
			</div>
		</div>

		<div class="row">
			<div class="col s12 m12 l7">
				<g:if test="${resourceInstance.videoLink == null}">
					<p><strong>Vídeo Tutorial:</strong> Não Disponível</p>
				</g:if>
				<g:else>
					<p><strong>Vídeo Tutorial:</strong><a target="_blank" href="${resourceInstance.videoLink}"> Clique aqui</a> </p>
				</g:else>
			</div>
		</div>

		<div class="row">
			<div class="col s12 m12 l7" id="documentation">
				<g:if test="${resourceInstance.documentation == null}">
					<p><strong>Documentação do Modelo:</strong> Não Disponível</p>
				</g:if>
				<g:else>
					<p><strong>Documentação do Modelo:</strong><a target="_blank" href="${resourceInstance.documentation}"> ${resourceInstance.name}</a> </p>
				</g:else>
			</div>
		</div>

		<div class="row">
			<div class="col s12 m12 l7" id="info">
				<g:if test="${resourceInstance.info == null}">
					<p><b>Info do Modelo:</b> Não Disponível</p>
				</g:if>
				<g:else>
					<p><b>Info do Modelo:</b> ${resourceInstance.info}</p>
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

		<div class="card-action hide">
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

<script>

	// Criação do processo do jogo
    $('#createGame').on("click",function(){
        var id = $("#hiddenId").val();
        console.log(id);

        $.ajax({
            type: 'POST',
            url: "/process/start/",
            data: {
                id: id,
				uri: "${resourceInstance.uri}"
			},
            success: function (data) {
                window.location.href = data;
            },
            error: function(req, res, err) {
                Materialize.toast('Problema no seguimento de tarefas.', 3000);
            }
        });
    });

</script>
</body>
</html>

