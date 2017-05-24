<%@ page import="br.ufscar.sead.loa.remar.User; br.ufscar.sead.loa.remar.UserController" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">

	<title>Meu perfil</title>
</head>
<body>
    <g:if test="${params.success}">
        <script>
            console.log("asdsadsdsaadsda");
        </script>
        <div id="modal" class="modal">
            <div class="modal-content">

            </div>
            <div class="modal-footer">
                <a href="#" class="modal-close waves-effect btn">Ok</a>
            </div>
        </div>

        <script>
            $(document).ready(function() {
               $("#modal").openModal();
            });
        </script>
    </g:if>

    <g:if test="${params.profileUpdated}">
        <script type="text/javascript">
            Materialize.toast('Perfil atualizado!', 3000, 'rounded') // 'rounded' is the class I'm applying to the toast
        </script>
    </g:if>

	<div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                <i class="left small material-icons">account_circle</i>Meu perfil
            </p>
            <div class="divider"></div>
        </div>
        <div class="row show">
            <form method="POST" action="/user/update?id=${session.user.id}" enctype="multipart/form-data" data-user-id="${session.user.id}">
                <div class="row" style="margin-top: 20px;">
										<div class="row">
		                    <div class="input-field col s12 m6">
		                        <i class="material-icons prefix">person</i>
		                        <input id="firstName" name="firstName" type="text" value="${session.user.firstName}" />
		                        <label for="firstName">Nome</label>
		                    </div>

		                    <div class="input-field col s12 m6">
		                        <i class="material-icons prefix">person</i>
		                        <input id="lastName" name="lastName" type="text" value="${session.user.lastName}" />
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

										<div class="row img-input-container">
                        <div class="col s2 m2 l2 img-preview">
                            <input type="hidden" name="photo" value="/images/avatars/default.png" id="srcImage">
                            <img id="profile-picture" class="circle profile-picture" src="/data/users/${session.user.username}/profile-picture?${new Date()}" />
                        </div>
                        <div class="col s8 offset-s2 m10 l10">
                            <div class="file-field input-field">
                                <div class="btn waves-effect waves-light my-orange">
                                    <span>Arquivo</span>
                                    <input id="file" type="file" data-image="true" accept="image/jpeg, image/png">
                                </div>
                                <div class="file-path-wrapper">
                                    <input readonly class="file-path validate" type="text" placeholder="Selecione uma foto (opcional)" style="margin-bottom: 0;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>

										<div class="row">
		                    <div class="input-field center-align">
		                        <button class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
		                    </div>
										</div>
                </div>
            </form>

						<div id="modal-profile-picture" class="modal remar-modal">
						    <div class="modal-content">
						        <h4>Envio de Imagem</h4>
						        <div class="img-container">
						            <img id="crop-preview" class="responsive-img">
						        </div>
						    </div>
						    <div class="modal-footer">
						        <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Enviar</a>
						    </div>
						</div>

            <div class="row">
                <div class="col s12">
                    <ul class="collection">
                        <li class="collection-item">
                            <sec:ifNotGranted roles="ROLE_DEV">
                                <div>
                                    <p><u>Você ainda não é um desenvolvedor do REMAR</u>. Se deseja tornar-se um desenvolvedor, <a href="/developer/new">clique aqui</a>.</p>
                                </div>
                            </sec:ifNotGranted>
                            <sec:ifAnyGranted roles="ROLE_DEV">
                                <div>
                                    <p align="left"><u>Você já é um desenvolvedor no REMAR</u>.</p>
                                    <p align="left" style="margin-left: 20px;">Para enviar novos jogos, clique no menu <a href="/resource/index">"Desenvolvedor"</a>.</p>
                                    <p align="left" style="margin-left: 20px;">Se não deseja mais ser um desenvolvedor, <a href="/user/unmakeDeveloper">clique aqui</a>.</p>
                                </div>
                            </sec:ifAnyGranted>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="row" id="moodle">
                <div class="col s12 left-align">
                    <ul class="collection with-header">
                        <li class="collection-header">
                            <h4>Contas do Moodle</h4>
                        </li>
                        <g:each var="moodleInstance" in="${moodleList}">
                            <li class="collection-item">
                                <div class="row no-margin-bottom">
                                    <div class="col s10">
                                        <b>Moodle</b>: <a href="${moodleInstance.domain}">${moodleInstance.name}</a><br />
                                        <g:if test="${(new UserController()).getMoodleAccount((int) moodleInstance.id)}">
                                            <b>Conta</b>: ${(new UserController()).getMoodleAccount((int) moodleInstance.id).accountName} (<a href="/moodle/unlink/${(new UserController()).getMoodleAccount((int) moodleInstance.id).token}">X</a>)
                                        </g:if>
                                        <g:else>
                                            <b>Conta</b>: -
                                        </g:else>
                                    </div>
                                    <div class="col s2 right">
                                        <g:if test="${!(new UserController()).getMoodleAccount((int) moodleInstance.id)}">
                                            <a href="/moodle/link/${moodleInstance.id}" class="btn-floating btn-medium waves-effect waves-light my-orange right">
                                                <i class="mdi-content-add"></i>
                                            </a>
                                        </g:if>
                                    </div>
                                </div>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>

            <div class="row" id="desableAccount">
                <div class="col s12 left-align">
                    <ul class="collection with-header">
                        <h5>Desativar minha conta</h5>

                        <a onclick="disableUser()" >Desabilitar minha conta</a>
                        <br>
                        %{--<a onclick="deleteUser()" >Excluir minha conta</a>--}%

                    </ul>
                </div>
            </div>
        </div>
    </div>

<!-- Modal Structure -->
<div id="confirmModal" class="modal">
    <div class="modal-content" id="modalContent">

    </div>
    <div class="modal-footer" id="modalFooter">

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
            $("#confirmModal").openModal({
                dismissible:false
            });
        }

        function deleteUser(){
            $("#modalContent").empty();
            $("#modalFooter").empty();
            $("#modalContent").append("<p> Ao excluir sua conta, todos os seus dados serão deletados permanentemente (usuário, modelos e jogos customizados) e você não poderá recuperar sua conta posteriormente</p>");
            $("#modalFooter").append("<a href='user/deleteAccount' class='btn btn-large modal-close'>Excluir minha conta</button>");
            $("#modalFooter").append("<a class='btn btn-large modal-close disabled'>Cancelar</a>");
            $("#confirmModal").openModal({
                dismissible:false
            });
        }
    </script>

    <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}"/>
    <g:javascript src="jquery/jquery.validate.js"/>
    <g:javascript src="user/update-validator.js"/>
    <g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>
