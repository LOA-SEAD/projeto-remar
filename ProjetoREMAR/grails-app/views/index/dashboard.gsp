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

        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-body box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">Recursos personalizáveis</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                        <div class="direct-chat-messages" >
                            <g:each in="${gameInstanceList}" var="gameInstance">

                                <div class="col-md-3">
                                    <div class="info-box bg-aqua-gradient">
                                        <span class="info-box-icon">
                                            <a href="/process/start/${gameInstance.bpmn}" target="_self">
                                                %{--<img--}%
                                                        %{--src="/images/${gameInstance.uri}-banner.png"--}%
                                                        %{--class="img img-responsive center-block"/>--}%
                                                <i class="fa fa-magic"></i>
                                            </a>
                                        </span>
                                        <div class="info-box-content">
                                            <span class="info-box-text">${gameInstance.name}</span>
                                            <span id="development" class="info-box-number">
                                                <img class="img-circle" alt="User Image" src="../assets/img/inside/avatar.png"
                                                     height="25" width="25"/>
                                                REMAR
                                            </span>

                                            <span class="progress-description">
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
                                            </span>
                                        </div><!-- /.info-box-content -->
                                    </div><!-- /.info-box -->
                                </div>

                                </g:each>
                        </div><!-- ./box-body -->
                        <div class="box-footer">

                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>
</html>