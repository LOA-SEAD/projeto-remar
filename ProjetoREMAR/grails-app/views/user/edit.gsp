<%@ page import="br.ufscar.sead.loa.remar.User; br.ufscar.sead.loa.remar.UserController" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">

	<title>Meu perfil</title>
</head>
<body>
    <g:if test="${params.success}">
        <div id="modal" class="modal">
            <div class="modal-content">

            </div>
            <div class="modal-footer">
                <a href="#" class="modal-close waves-effect btn">Ok</a>
            </div>
        </div>

        <script>
            $(document).ready(function() {
            	$("#modal").modal('open');
            });
        </script>
    </g:if>

    <g:if test="${params.profileUpdated}">
        <script type="text/javascript">
            Materialize.toast('Perfil atualizado!', 3000);
        </script>
    </g:if>

	<g:if test="${params.photoUpdated}">
        <script type="text/javascript">
            Materialize.toast('Foto atualizada!', 3000);
        </script>
    </g:if>

	<div class="row cluster">
		<!-- Seção de Atualização do Perfil -->
		<div class="row">
	        <div class="cluster-header">
	            <h4>Meu Perfil</h4>
	            <div class="divider"></div>
	        </div>
	        <div class="row show">
				<!-- Informações do Perfil -->
				<div class="col s8">
		            <form method="POST" action="/user/update?id=${session.user.id}" enctype="multipart/form-data" data-user-id="${session.user.id}">
		                <div class="row" style="margin-top: 20px;">
							<div class="row">
			                    <div class="input-field col s12 m6">
			                        <i class="material-icons prefix">person</i>
			                        <input required id="firstName" name="firstName" type="text" value="${session.user.firstName}" />
			                        <label for="firstName">Nome</label>
			                    </div>
			                    <div class="input-field col s12 m6">
			                        <i class="material-icons prefix">person</i>
			                        <input required id="lastName" name="lastName" type="text" value="${session.user.lastName}" />
			                        <label for="lastName">Sobrenome</label>
			                    </div>
							</div>
							<div class="row">
				                <div class="input-field col s12">
					                <i class="material-icons prefix">email</i>
					                <input id="email" name="email" type="email" value="${session.user.email}" />
					                <label for="email">Email</label>
				                </div>
							</div>
							<div class="row">
			                    <div class="input-field col s12 m12">
			                        <i class="material-icons prefix">account_circle</i>
			                        <input id="username" name="username" type="hidden" value="${session.user.username}" />
			                        <input type="text" value="${session.user.username}" disabled />
			                        <label for="username">Nome de Usuário</label>
			                    </div>
							</div>
							<div class="row">
			                    <div class="input-field col s12 m6">
			                        <i class="material-icons prefix">lock</i>
			                        <input id="password" name="password" type="password"/>
			                        <label for="password">Nova senha</label>
			                    </div>
			                    <div class="input-field col s12 m6">
			                        <i class="material-icons prefix">lock</i>
			                        <input id="confirm-password" name="confirm_password" type="password"/>
			                        <label for="confirm-password">Confirme sua nova senha</label>
			                    </div>
							</div>
		                    <div class="clearfix"></div>
							<div class="row">
			                    <div id="submitButton" class="input-field">
			                        <button class="btn waves-effect waves-light tooltiped my-orange" type="submit">
										Atualizar
									</button>
			                    </div>
							</div>
		                </div>
		            </form>
				</div>

				<!-- Upload de Foto -->
				<div class="col s4">
					<form method="POST" name="photoUpload" action="/user/updatePhoto?id=${session.user.id}" enctype="multipart/form-data" data-user-id="${session.user.id}">
						<div class="row img-input-container">
							<div id="img-preview">
								<input id="source-image" type="hidden" name="photo" value="/images/avatars/default.png">
								<img id="profile-picture"  class="profile-picture" src="/data/users/${session.user.username}/profile-picture" />
							</div>

							<input id="file" type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png">
							<div id="img-update-button-container">
								<div id="img-update-button">
									<i class="file-field-icon material-icons">camera_alt</i>
									<div class="file-field-text">
										Atualizar foto do perfil
									</div>
								</div>
							</div>

							<!-- Efeito de hovering sobre o botão acima -->
							<div id="img-update-button-effect">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Desenvolvedor REMAR -->
		<div class="row">
			<div class="cluster-header">
	            <h4>Desenvolvedor REMAR</h4>
	            <div class="divider"></div>
	        </div>
			<div class="row show">
				<sec:ifNotGranted roles="ROLE_DEV">
					<div style="padding-left: 15px;">
						<p><u>Você ainda não é um desenvolvedor do REMAR</u></p>
						<a hred="/developer/new" class="waves-effect btn">
							Tornar-se desenvolvedor
						</a>
					</div>
				</sec:ifNotGranted>
				<sec:ifAnyGranted roles="ROLE_DEV">
					<div style="padding-left: 15px;">
						<p align="left"><u>Você já é um desenvolvedor no REMAR</u></p>
						<p align="left" style="margin-left: 20px;">Para enviar novos jogos, clique no menu <a href="/resource/index">"Desenvolvedor"</a>.</p>
						<p align="left" style="margin-left: 20px;">Se não deseja mais ser um desenvolvedor, <a href="/user/unmakeDeveloper">clique aqui</a>.</p>
					</div>
				</sec:ifAnyGranted>
			</div>
		</div>
		
		<!-- Card para DESABILITAR uma conta -->
		<div class="row" style="margin-top: 50px;">
			<div class="cluster-header">
	            <h4>Desativar Conta</h4>
	            <div class="divider"></div>
	        </div>
			<div class="row" id="disableAccountCard">
		        <div class="col s12">
		            <div class="card">
			            <div class="card-header">
				            <span class="card-title">Desativar minha conta </span>
			            </div>

			            <div class="card-content">
				            <p>Uma vez que você desativar sua conta, não há como voltar atrás.</p>
							<p>Por favor tenha certeza antes de prosseguir.</p>
			            </div>

			            <div class="card-action">
			                <a class="waves-effect btn" onclick="disableUser()">
								Desativar minha conta
							</a>
			            </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>

	<!-- MODAIS -->
	<div id="confirmModal" class="modal">
		<div class="modal-content" id="modalContent">
		</div>
		<div class="modal-footer" id="modalFooter">
		</div>
	</div>
	<div id="modal-profile-picture" class="modal remar-modal">
		<div class="modal-content">
				<h4>Envio de Imagem</h4>
				<div class="img-container">
						<img id="crop-preview" class="responsive-img">
				</div>
		</div>
		<div class="modal-footer">
				<a id="accept-picture" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange"
					data-target="photoUpload">
					Enviar
				</a>
				<a id="cancel-picture" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
		</div>
	</div>

    <script>
        $('#toHide').click(function() {
            console.log(this);
            $(this).hide();
        });
        function disableUser(){
            $("#modalContent").empty();
            $("#modalFooter").empty();
            $("#modalContent").append("<p> Ao desabilitar sua conta você não conseguirá mais acessar a plataforma" +
                    ", porém você pode resgatar sua conta à qualquer momento. </p>");
            $("#modalFooter").append("<a href='user/disableAccount' class='btn btn-large modal-close'>Desativar minha conta</button>");
            $("#modalFooter").append("<a class='btn btn-large modal-close disabled'>Cancelar</a>");
            $("#confirmModal").modal('open');
        }
    </script>
    <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}" />
	<link type="text/css" rel="stylesheet" href="${resource(dir: "css/user", file: "profile.css")}" />
	<g:javascript src="remar/user/image-selector.js" />
	<g:javascript src="remar/user/update-validator.js" />
    <g:javascript src="libs/jquery/jquery.validate.js" />
    <g:javascript src="libs/jquery/jquery.jcrop.js" />
</body>
</html>
