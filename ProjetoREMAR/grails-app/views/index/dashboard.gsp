<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <g:set var="entityName"
           value="${message(code: 'user.label', default: 'User')}" />
    <title>Admin page</title>
</head>
<body>

    <div class="row">
        <div class="col-xs-5 format-box-style">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Recusos Personalizáveis</h3>
                    <span class="label label-primary pull-right"><i class="fa fa-html5"></i></span>
                </div>
                <div class="box-body">

                    <g:each in="${gameInstanceList}" var="gameInstance">
                        <div class="col-md-3">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    ${gameInstance.name}
                                </div>
                                <div class="panel-body">
                                    <a href="/process/start/${gameInstance.bpmn}" target="_self">
                                        <img
                                                src="/images/${gameInstance.uri}-banner.png"
                                                class="img img-responsive center-block"/>
                                    </a>
                                </div>
                                <div class="panel-footer">
                                    <div class="pull-right">
                                        <i class="fa fa-at"></i>
                                        <g:if test="${gameInstance.android}">
                                            <i class="fa fa-android"></i>
                                        </g:if>
                                        <g:if test="${gameInstance.linux}">
                                            <i class="fa fa-linux"></i>
                                        </g:if>
                                        <g:if test="${gameInstance.moodle}">
                                            <i class="fa fa-graduation-cap"></i>
                                        </g:if>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </g:each>

                </div>
            </div>
        </div>

        <div class="col-xs-5">
            <div class="box box-danger format-box-style">
                <div class="box-header with-border">
                    <h3 class="box-title">Recursos públicos</h3>
                    <span class="label label-danger pull-right"><i class="fa fa-database"></i></span>
                </div><!-- /.box-header -->
                <div class="box-body">

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col -->
    </div><!-- /.row -->


    %{--<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">--}%
        %{--<div class="main-content">--}%

            %{--<div class="panel panel-success">--}%
                %{--<div class="panel-heading">--}%
                         %{--<h3 class="panel-title">  <i class="fa fa-gamepad"></i> Jogos personalizáveis</h3>--}%
                %{--</div>--}%
                %{--<div class="panel-body">--}%

                    %{--<div class="padded">--}%
                        %{--<div class="row">--}%
                           %{----}%

                        %{--</div>--}%
                    %{--</div>--}%

                %{--</div>--}%
            %{--</div>            --}%
    %{--</div>--}%
</body>
</html>