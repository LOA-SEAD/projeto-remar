<%@ page contentType="text/html;charset=UTF-8" %>
<head>
    <meta name="layout" content="new-main-inside">
    <title>REMAR</title>
</head>
<body>
<div class="content">
    <div class="row">
        <article class="row">
        <div class="col-md-12" align="center">
            <div class="box box-body box-info" style="width:40%;" align="center" >
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <i class="fa fa-code"></i>
                        Tornar-se um desenvolvedor
                    </h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                    <div class="direct-chat-messages page-size" style="width: 90%;" >
                        <g:form action="makeDeveloper" controller="user" params="">
                            <div class="form-group has-feedback" >
                                <input placeholder="Nome completo" type="text" class="form-control-remar" name="fullName" id="fullName" value="${fullname}" required=""/>
                            </div>
                            <div class="form-group has-feedback" >
                                <input placeholder="Estado (ex: SP)" type="text" class="form-control-remar" name="state" id="state" required=""/>
                            </div>
                            <div class="form-group has-feedback" >
                                <input placeholder="Cidade" type="text" class="form-control-remar" name="city" id="city" required=""/>
                            </div>
                            <div class="form-group has-feedback" >
                                <input placeholder="Data Nascimento (dd/mm/aaaa)" type="date" class="form-control-remar" name="birthday" id="birthday" required=""/>
                            </div>
                            <div class="form-group has-feedback">
                                %{--<input placeholder="Motivos para ser um desenvolvedor do REMAR" type="text" class="form-control input-form" name="reasons" id="reasons" required=""/>--}%
                                <textarea placeholder="Motivos para ser um desenvolvedor do REMAR" class="form-control-remar textarea-remar" name="reasons" id="reasons" cols="30" rows="5"required=""></textarea>
                            </div>

                            <div class="form-group has-feedback">
                                <input type="checkbox" name="agree" id="remember" required=""/>
                                <span class="control-label">Eu concordo com os termos adicionais presentes nos <a>Termos e privacidade</a> do remar.</span>
                            </div>

                            <div style="width: 30%;" align="center">
                                 <g:submitButton class="btn btn-primary btn-block btn-flat" name="Enviar"/>
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
        </article>
    </div>
</div>

</body>