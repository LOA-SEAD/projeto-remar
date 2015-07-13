<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Entrar</title>
    <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel='stylesheet'>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" ></script>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">


    <link href="${resource(dir: 'assets/css', file: 'jquery.min.js')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap-social.css')}" rel="stylesheet" >

    <script>

    </script>

    <style type="text/css">

          .show {
            display: block !important;

        }
        .modal {
            position: fixed;
            top: 0px;
            right: 0px;
            left: 0px;
            bottom: 0px;
            z-index: 1050;
            display: none;
            overflow: hidden;
            outline: 0px none;
            text-align: center;
        }


        .modal-content {
            position: relative;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid rgba(0, 0, 0, 0.2);
            border-radius: 0px;
            outline: 0px none;
            min-height: 600px;
            font-family: 'Ropa Sans', sans-serif;
            background-color: rgba(255,255,255,0.2);
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.5);
        }

        .modal-body {
            position: relative;
            padding: 15px;
            padding-top: 20%;

        }

        .modal-footer {
            margin-top: 200px;
            border-top: 10px;
            text-align: start;
        }

        .input-lg {
            height: 46px;
            padding: 10px 16px;
            font-size: 18px;
            line-height: 40px;
            border-radius: 0px;
            border-style: solid none solid solid;
            width: 60%;
            display: inline-block;
            margin: 5px 0  5px 0;

        }

        .btn-block {
            display: block;
            width: 50%;
            position: absolute;


        }
        .btn-lg, .btn-group-lg > .btn {
            padding: 10px 16px;
            font-size: 18px;
            line-height: 1.33333;

        }
        .btn-primary {
            color: #FFF;
            background-color: #2EBD59;
            border-color: #2EBD59;
        }
        /*.btn {*/
            /*display: block;*/
            /*padding: 6px 12px;*/
            /*margin-bottom: 0px;*/
            /*font-size: 18px;*/
            /*font-weight: normal;*/
            /*line-height: 1.42857;*/
            /*text-align: center;*/
            /*white-space: nowrap;*/
            /*vertical-align: middle;*/
            /*cursor: pointer ;*/
            /*-moz-user-select: none;*/
            /*background-image: none;*/
            /*border: 1px solid transparent;*/
            /*right: 25%;*/
            /*border-radius: 50px;*/
            /*margin-top: 5%;*/
            /*/!*box-shadow: 2px 2px 2px rgba(0,0,0, 0.25) inset;*!/*/

        /*}*/

        .btn {
            display: block;
            font-size: 18px;
            line-height: 1.2;
            text-align: center;
            -moz-user-select: none;
            border: 1px solid transparent;
            border-radius: 50px;
            margin-left: 20%;
            min-width: 250px;
        }

        .btn-primary:hover, .btn-primary:focus, .btn-primary.focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary {
            color: #FFF;
            background-image: linear-gradient(#2EBD59,#1ed760);
            /*background-color: #1ed760;*/
            border-color: #2EBD59;
        }

          .form-control:focus {
              border-color: #2EBD59;
              outline: 0px none;
              box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.075) inset, 0px 0px 8px rgba(16, 151, 0, 0.6);
          }

        .login span.icon {
            width: 10%;
            transition: all 800ms ease 0s;
            text-align: center;
            color: #999;
            border-radius: 0px 3px 3px 0px;
            background: #E8E8E8 none repeat scroll 0% 0%;
            height: 46px;
            line-height: 46px;
            display: inline-block;
            border-width: 1px 1px 1px medium;
            border-style: solid solid solid none;
            border-color: #CCC #CCC #CCC -moz-use-text-color;
            -moz-border-top-colors: none;
            -moz-border-right-colors: none;
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            border-image: none;
            font-size: 16px;
            margin: 5px 0  5px -10px;
        }

        .icon:focus:invalid{
            border-color: #ba0500;
        }

        .input-lg, .login span.icon {
            vertical-align: top;
        }

        .form-control:focus + .icon{
            border-color: #2EBD59;
            outline: 3px none;
            box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.075) inset, 0px 0px 8px rgba(16, 151, 0, 0.6);
        }
        .fa {
            display: inline-block;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            line-height: 1;
            font-size-adjust: none;
            font-stretch: normal;
            font-feature-settings: normal;
            font-language-override: normal;
            font-kerning: auto;
            font-synthesis: weight style;
            font-variant: normal;
            font-size: inherit;
            text-rendering: auto;
        }

        .container{
            display: block;
            margin: 0px auto;
            max-width: 500px;
            outline: 0px none;
            text-align: center;
            position: static;

            font-family: 'Ropa Sans', sans-serif;
        }

        form{
            display: block !important;
            min-height: 300px;
        }

        .form-group{
            display: block;
            padding: 0px;
            margin: 10px;
        }

        .divider{
            border-top: 1px solid #D9DADC;
            display: block;
            line-height: 1px;
            margin: 30px 0px;
            position: relative;
            text-align: center;
        }
        strong{
            font-size: 18px;
            display: inline;
            background-color: #ffffff;
            margin-top: 25px;
            padding: 10px;
        }

        header{
            min-height: 200px;
        }

        footer span{
            diplay: block;
            font-size: 16px;
            text-align: center;
        }
        footer span a{
            diplay:block;
            color: #2EBD59;
        }
        footer span a:hover{
            color: rgba(16, 151, 0, 1);
        }
    </style>
</head>
<body>

<body>

<div class="container">
    <header class="row">
        <div class="col-md-12">
            <h1 class="text-center">Login</h1>

        </div>

    </header>
    <article class="row">
        <div class="col-md-12">
            <form action='/j_spring_security_check' method='POST' class="form center-block login" >
                <g:if test='${flash.message}'>
                    <div class='login_message'>${flash.message}</div>
                </g:if>
                <div class="form-group">
                    <button class="btn  btn-social btn-facebook" ><i class="fa fa-facebook"></i> Entrar com o Facebook</button>
                </div>
                <div class="divider">
                    <strong class="">ou</strong>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control input-lg" placeholder="Nome de usu&aacute;rio" name='j_username'>
                    <span class="icon"><i class="fa fa-user"></i></span>

                    <input type="password" class="form-control input-lg" placeholder="Senha" name='j_password'>
                    <span class="icon"><i class="fa fa-lock"></i></span>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-block" >Entrar</button>
                </div>
            </form>
        </div>
    </article>
    <footer class="row">
        <div class="col-md-12">
            <span><a href="#">Esqueci a senha!</a></span> <br>
            <span>Ainda n&atilde;o est&aacute; cadastrado?<a href="#"> Registre-se</a></span>
            <g:link controller="user" action="create" >Registre-se</g:link>
            <g:link class="btn btn-danger" mapping="resetPassword">Esqueci a Senha</g:link>

        </div>
    </footer>
</div>




%{--<div id="loginModal" class="modal show" tabindex="-1" role="dialog" aria-hidden="true">--}%
    %{--<div class="modal-dialog">--}%
        %{--<div class="modal-content">--}%
            %{--<div class="modal-header">--}%
                %{--<h1 class="text-center">Login</h1>--}%
            %{--</div>--}%
            %{--<div class="modal-body">--}%
                %{--<form action='/j_spring_security_check' method='POST' class="form center-block login" >--}%

                    %{--<button class="btn btn-block btn-social btn-facebook"  style="top:0px"  ><i class="fa fa-facebook"></i> Entrar com o Facebook</button>--}%

                    %{--<div class="form-group ">--}%
                        %{--<input type="text" class="form-control input-lg" placeholder="Nome de usu&aacute;rio" name='j_username'>--}%
                        %{--<span class="icon"><i class="fa fa-user"></i></span>--}%
                   %{--</div>--}%
                    %{--<div class="form-group">--}%
                        %{--<input type="password" class="form-control input-lg" placeholder="Senha" name='j_password'>--}%
                        %{--<span class="icon"><i class="fa fa-lock"></i></span>--}%
                    %{--</div>--}%
                    %{--<div class="form-group">--}%
                        %{--<button class="btn btn-primary btn-block" >Entrar</button>--}%
                    %{--</div>--}%
                %{--</form>--}%
            %{--</div>--}%
            %{--<div class="show modal-footer">--}%
                %{--<div class="col-md-12">--}%
                    %{--<div class="form-group">--}%
                        %{--<a href="#">&#8227; Esqueceu a senha?</a>--}%
                        %{--<span class="pull-bottom">Ainda n&atilde;o possui cadastro? <a class="link_password" href="#">Registre-se</a></span>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%


</body>
</html>