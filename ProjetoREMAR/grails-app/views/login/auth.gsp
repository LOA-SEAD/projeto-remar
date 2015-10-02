<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}?v=2">
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>

    <link type="text/css" rel="stylesheet" href="../css/style.css"/>

    <title>REMAR</title>
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}?v=2" type="image/x-icon">

</head>
<body>
<div class="container">
    ${flash.message}
    <div class="row">
        <div class="card white z-depth-4 col s12 m6 l4 offset-m3 offset-l4 offset-vertical-15">
            <div class="card-content">
                <div class="card-image">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <form action="/j_spring_security_check" method="POST">
                    <div class="input-field">
                        <i class="material-icons prefix">account_circle</i>
                        <input id="username" name="j_username" type="text">
                        <label for="username">Usuário</label>
                    </div> <!-- input-field -->

                    <div class="input-field">
                        <i class="material-icons prefix">lock</i>
                        <input id="password" name="j_password" type="password">
                        <label for="password">Senha</label>
                    </div> <!-- input-field -->
                    <div class="input-field center">
                        <button type="submit" class="btn waves-effect waves-light">Entrar</button>
                    </div>
                    <div class="input-field center">
                        <g:link class="margin" mapping="resetPassword">Esqueceu sua senha?</g:link><br>
                        <g:link  controller="user" action="create">Cadastre-se</g:link>
                    </div> <!-- input field -->
                </form>
            </div> <!-- card-content -->
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script>

</body>
</html>