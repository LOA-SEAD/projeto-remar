<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 19/08/15
  Time: 09:44
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="new-main-inside">

    <title></title>
</head>

<body>
<div class="content">
    <div class="row">
        <article class="row">
        <div class="col-md-12" align="center">
            <div class="box box-body box-info" style="width:40%;" align="center" >
                <div class="box-header with-border">
                    <h3 class="box-title">
                        %{--<i class="fa fa-level-up"></i>--}%
                        Tornar-se um desenvolvedor
                    </h3>
                </div><!-- /.box-header -->
                <div class="box-body" style="height: 300px;">
                    <div class="direct-chat-messages page-size container-center" style="width: 90%;"  >
                        <h2 class="text-center" style="margin-bottom: 40px; font-weight: bold;">Obrigado pelas informações!</h2>
                        <h4 style="margin-bottom: 20px; text-align: justify"> Agora você é um desenvolvedor do REMAR. Para efetivar as mudanças saia do sistema e faça login novamente.</h4>
                        %{--<a href="/logout/index"  class="btn btn-primary btn-block btn-flat">Sair</a>--}%
                        <div align="center" style="width: 30%;">
                            <a href="/logout/index"  class="btn btn-primary btn-block btn-flat">Sair</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </article>
    </div>
</div>

</body>
</html>