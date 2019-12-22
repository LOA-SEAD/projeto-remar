<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 28/04/16
  Time: 08:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Reativar conta</title>



    <g:javascript src="../assets/js/jquery.min.js" />
    <style>
    body {
        background-color: #F2F2F2;
    }
    </style>


</head>
<body>
<div class="container">
    <div class="row">
        <div class="card white col s12 m6 l4 offset-m3 offset-l4 offset-vertical-2" style="margin-top: 30px;">
            <div class="card-content" style="padding: 20px !important;">
                <div class="card-image" style="padding-bottom: 20px;">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <h4 class="title-style center">Reativar conta</h4>
                <br>
                <div class="row">
                    <div class="col s12 m12 l12 center-align">
                        <p>Conta reativada com sucesso!</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col s12 m12 l12 center-align">
                        <a href="../login/auth.gsp" class="btn waves-effect waves-light tooltiped my-orange" >Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>