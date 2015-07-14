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

        .btn-login{
            min-width: 50px;
            width: 150px;
            display: inline-block;
            margin-left: -12%;

        }


        .btn-primary:hover, .btn-primary:focus, .btn-primary.focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary {
            color: #FFF;
            background-image: linear-gradient(#2EBD59,#1ed760);
            /*background-color: #1ed760;*/
            border-color: transparent ;
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
            border-top: 1px solid #2EBD59;
            display: block;
            line-height: 1px;
            margin: 30px 0px;
            position: relative;
            text-align: center;
            outline: 3px none;
            box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.075) inset;
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
            padding-top: 30px;
            margin-bottom: 50px;
        }

        header h1{
            font-size: 120px;
            color: #2EBD59;
            text-shadow: 2px 4px 2px rgba(0,0,0,0.3);
        }

        .footer-span{
            diplay: block;
            font-size: 16px;
            text-align: center;
        }
        .footer-span a{
            diplay:block;
            color: #2EBD59;

        }
        .footer-span a:hover{
            color: rgba(16, 151, 0, 1);
        }

        footer{
            margin-bottom: 80px;
        }

        /*Style para ajustar propriedade float*/
        .clearfix::before,
        .clearfix::after {
            content: "";
            display: table;
        }
        .clearfix::after {
            clear: both;
        }

        .ck-style{
            display: inline-block;
            float: left;
            margin-left: 15%;
        }

        .ck-style input[type="checkbox"]{
            border-color: #2EBD59;
        }

    </style>
</head>
<body>
    <div class="container">
        <header class="row">
            <div class="col-md-12">
                <h1 class="text-center">REMAR</h1>
            </div>
        </header>
        <article class="row">
            <div class="col-md-12">
                <form action='/j_spring_security_check' method='POST' class="form center-block login" >

                    <sec:ifNotGranted roles="ROLE_USER">
                        <facebookAuth:connect />
                    </sec:ifNotGranted>
                    <sec:ifAllGranted roles="ROLE_USER">
                        Welcome <sec:username/>! (<g:link uri="/j_spring_security_logout">Logout</g:link>)
                    </sec:ifAllGranted>
                    <g:if test='${flash.message}'>
                        <div class="">${flash.message}</div>
                    </g:if>

                    <div class="divider">
                        <strong class="">ou</strong>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-lg" placeholder="Nome de usu&aacute;rio" name='j_username'>
                        <span class="icon"><i class="fa fa-user"></i></span>

                        <input type="password" class="form-control input-lg" placeholder="Senha" name='j_password'>
                        <span class="icon"><i class="fa fa-lock"></i></span>
                    </div>
                    <div class="form-group clearfix">
                        <div class="ck-style">
                            <input type="checkbox" name="remember">
                            <span class="footer-span">Lembre-me</span>
                        </div>
                        <button class="btn btn-primary btn-block btn-login" >Entrar</button>
                    </div>
                </form>
            </div>
        </article>
        <footer class="row">
            <div class="col-md-12">
                <span class="footer-span"><g:link class="footer-span" mapping="resetPassword">Esqueci a Senha!</g:link></span> <br>
                <span class="footer-span">Ainda n&atilde;o est&aacute; cadastrado? <g:link class="footer-span" controller="user" action="create" >Registre-se</g:link> </span>
            </div>
        </footer>
    </div>
</body>
</html>