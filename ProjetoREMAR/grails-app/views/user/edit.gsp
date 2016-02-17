<%@ page import="br.ufscar.sead.loa.remar.UserController" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="materialize-layout">
    <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}"/>
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

	<div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                <i class="left small material-icons">account_circle</i>Meu perfil
            </p>
            <div class="divider"></div>
        </div>
        <div class="row show">
            <form method="POST" action="/user/update" enctype="multipart/form-data">
                <input id="userId" name="userId" type="hidden" value="${session.user.id}" />

                <div class="row" style="margin-top: 20px;">
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
                    <div class="input-field col s12">
                        <i class="material-icons prefix">email</i>
                        <input id="email" name="email" type="email" value="${session.user.email}" />
                        <label for="email">Email</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <i class="material-icons prefix">account_circle</i>
                        <input id="username" name="username" type="hidden" value="${session.user.username}" />
                        <input type="text" value="${session.user.username}" disabled />
                        <label for="username">Nome de Usuário</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <i class="material-icons prefix" style="color: #FF5722; left: 10px;">face</i>
                        <select id="select" name="gender">
                            <g:if test="${session.user.gender == "male"}">
                                <option value="male" selected>Masculino</option>
                                <option value="female">Feminino</option>
                            </g:if>
                            <g:else>
                                <option value="male">Masculino</option>
                                <option value="female" selected>Feminino</option>
                            </g:else>
                        </select>
                        <label for="select">Sexo</label>
                    </div>

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

                    <div class="input-field file-field col s12">
                        <div class="col s3">
                            <img id="profile-picture" class="circle profile-picture" src="/data/users/${session.user.username}/profile-picture" />
                        </div>
                        <div>
                            <input type="file" id="file" name="photo" accept="image/jpeg, image/png">
                            <div class="file-path-wrapper">
                                <input class="file-path" type="text" placeholder="Selecione uma foto (opicional)">
                                <span class="input-description my-left">Outros usuários irão te identificar mais facilmente :)</span>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                    <div class="input-field center-align">
                        <button id="submit" class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
                    </div>
                </div>
            </form>

            <div id="modal-profile-picture" class="modal">
                <div class="modal-content center">
                    <img id="crop-preview" class="responsive-img">
                </div>
                <div class="modal-footer">
                    <a href="#!" class="modal-action modal-close waves-effect btn-flat">Enviar</a>
                </div>
            </div>

            <div class="row">
                <div class="col s12">
                    <ul class="collection">
                        <li class="collection-item">
                            <sec:ifNotGranted roles="ROLE_DEV">
                                <div>
                                    <p>Você ainda não é um desenvolvedor do REMAR. Se deseja tornar-se um desenvolvedor, <a href="/developer/new">clique aqui</a>.</p>
                                </div>
                            </sec:ifNotGranted>
                            <sec:ifAnyGranted roles="ROLE_DEV">
                                <div>
                                    <p align="left">Você já é um desenvolvedor no REMAR.</p>
                                    <p align="left" style="margin-left: 20px;">Para enviar novos jogos, clique no menu <a href="/resource/index">"Desenvolvedor"</a>.</p>
                                    <p align="left" style="margin-left: 20px;">Se não deseja mais ser um desenvolvedor, <a href="/user/unmakeDeveloper">clique aqui</a>.</p>
                                </div>
                            </sec:ifAnyGranted>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="row">
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
        </div>
    </div>
    <g:javascript src="jquery/jquery.validate.js"/>
    <g:javascript src="user/update-validator.js"/>
    <g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>
