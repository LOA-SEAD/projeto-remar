<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}"/>
    <title>Registrar-se</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="card white z-depth-2 col s12 m8 l6 offset-m2 offset-l3">
            <div class="card-content" style="padding: 20px !important;">
                <div class="card-image" style="padding-bottom: 20px;">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <form action="/user/save" method="POST" enctype="multipart/form-data">
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="first-name" name="firstName" type="text"/>
                            <label for="first-name">Nome</label>
                        </div>

                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="last-name" name="lastName" type="text"/>
                            <label for="last-name">Sobrenome</label>
                        </div>


                        <div class="input-field col s12">
                            <i class="material-icons prefix">email</i>
                            <input id="email" name="email" type="email"/>
                            <label for="email">Email</label>
                        </div>

                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_circle</i>
                            <input id="username" name="username" type="text"/>
                            <label for="username">Nome de usuário</label>
                        </div>

                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix" style="color: #FF5722;">face</i>
                            <select id="select" name="gender">
                                <option value="male">Masculino</option>
                                <option value="female">Feminino</option>
                            </select>
                            <label for="select">Sexo</label>
                        </div>

                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">lock</i>
                            <input id="password" name="password" type="password"/>
                            <label for="password">Senha</label>
                        </div>

                        <input id="firstAccess" name="firstAccess" type="hidden" value="true">

                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">lock</i>
                            <input id="confirm-password" name="confirm_password" type="password"/>
                            <label for="confirm-password">Confirme sua senha</label>
                        </div>

                        <div class="input-field file-field col s12">
                            <div class="col s3">
                                <img id="profile-picture" class="circle profile-picture" src="/images/avatars/default.png" />
                            </div>
                            <div>
                                <input type="file" id="file" name="photo" accept="image/jpeg, image/png">
                                <div class="file-path-wrapper">
                                    <input class="file-path" type="text" placeholder="Selecione uma foto (opicional)">
                                    <span class="input-description">Outros usuários irão te identificar mais facilmente :)</span>
                                </div>
                            </div>
                        </div>

                        <div class="input-field col s12 center">
                            <div class="g-recaptcha text-center" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"> </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="input-field center-align">
                            <button id="submit" class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
                        </div>
                    </div>
                </form>
            </div> <!-- card-content -->
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->

<div id="modal-profile-picture" class="modal">
    <div class="modal-content center">
        <img id="crop-preview" class="responsive-img">
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect btn-flat">Enviar</a>
    </div>
</div>
<g:javascript src="jquery/jquery.validate.js"/>
<recaptcha:script/>
<g:javascript src="user/form.js"/>
<g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>
