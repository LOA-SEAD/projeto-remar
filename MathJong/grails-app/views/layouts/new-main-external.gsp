<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 05/09/15
  Time: 15:47
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><g:layoutTitle /></title>
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}" type="image/x-icon">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">


    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet" >
    <!-- Theme style -->
    <link href="${resource(dir: 'assets/css/inside-style', file: 'AdminLTE.css')}" rel="stylesheet">
    <!-- iCheck -->
    <link href="${resource(dir: 'assets/css/inside-style', file: 'iCheck-styleBlue.css')}" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <g:javascript src="../assets/js/jquery.min.js" />

    <g:javascript src="../assets/js/jquery.validate.js" />

    <g:layoutHead/>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-box-body">
        <div class="login-logo">
        <g:link controller="index" action="index">
            <img src="/mathjong/assets/img/logo/logo-remar-preto-transparente.png"
                             class="img-rounded" width="250" height="100"/> </g:link>
        </div>
        <g:layoutBody/>
    </div>
</div>

<!-- jQuery 2.1.4 -->
<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
<!-- Bootstrap 3.3.5 -->
<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
<!-- iCheck -->
<script type="text/javascript" src="${resource(dir: 'assets/js/inside-scripts', file: 'icheck.js')}"></script>

<g:javascript src="../assets/js/jquery.validate.js" />

</body>
</html>
