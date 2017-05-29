<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <link type="text/css" rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.Jcrop.css')}"/>
    <link type="text/css" rel="stylesheet" href="${resource(dir: 'css', file: 'signup.css')}"/>

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
                        <div class="input-field col s6 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="first-name" name="firstName" type="text"/>
                            <label for="first-name">Nome</label>
                        </div>

                        <div class="input-field col s6 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="last-name" name="lastName" type="text"/>
                            <label for="last-name">Sobrenome</label>
                        </div>
                    </div>

                   <div class="row">
                        <div class="input-field col s12 m12">
                            <i class="material-icons prefix">account_circle</i>
                            <input id="username" name="username" type="text"/>
                            <label for="username">Nome de usuário</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s12 m12">
                            <i class="material-icons prefix">email</i>
                            <input id="email" name="email" type="email"/>
                            <label for="email">Email</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s6 m6">
                            <i class="material-icons prefix">lock</i>
                            <input id="password" name="password" type="password"/>
                            <label for="password">Senha</label>
                        </div>

                        <div class="input-field col s6 m6">
                            <i class="material-icons prefix">lock</i>
                            <input id="confirm-password" name="confirm_password" type="password"/>
                            <label for="confirm-password">Confirme sua senha</label>
                        </div>
                    </div>

                    <input id="firstAccess" name="firstAccess" type="hidden" value="true">

                    <div class="row img-input-container">
                        <div class="col s2 m2 l2 img-preview">
                            <input type="hidden" name="photo" value="/images/avatars/default.png" id="source-image">
                            <img id="profile-picture"  class="circle profile-picture" src="/images/avatars/default.png" />
                        </div>
                        <div class="col s8 offset-s2 m10 l10">
                            <div class="file-field input-field">
                                <div class="btn waves-effect waves-light my-orange">
                                    <span>Arquivo</span>
                                    <input id="file" type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png">
                                </div>
                                <div class="file-path-wrapper">
                                    <input readonly class="file-path validate" type="text" placeholder="Selecione uma foto (opcional)" style="margin-bottom: 0;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field center-align">
                            <div class="g-recaptcha text-center" data-sitekey="6Ldm4CAUAAAAAMs6FsUuQIweiP-bhiCGsnNdrtBb"> </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                    <div class="row">
                        <div class="input-field center-align">
                            <button id="submit" class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
                        </div>
                    </div>
                </form>
            </div> <!-- card-content -->
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->

<div id="modal-profile-picture" class="modal remar-modal">
    <div class="modal-content">
        <h4>Envio de Imagem</h4>
        <div class="img-container">
            <img id="crop-preview" class="responsive-img">
        </div>
    </div>
    <div class="modal-footer">
        <a id="accept-picture" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Enviar</a>
        <a id="cancel-picture" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
    </div>
</div>

<g:javascript src="jquery/jquery.validate.js"/>
<recaptcha:script/>
<g:javascript src="user/form.js"/>
<g:javascript src="user/image-selector.js"/>
<g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>
