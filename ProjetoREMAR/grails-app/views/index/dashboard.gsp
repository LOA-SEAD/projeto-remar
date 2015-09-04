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

    <!-- jQuery 2.1.4 -->
    <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>


    <script type="text/javascript">
        $(function(){
           $("#dashboard_page").addClass("active");

        });
    </script>
</head>
<body>


<div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-body box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">
                                <i class="fa fa-edit"></i>
                                Recursos personalizáveis
                            </h3>

                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <div class="direct-chat-messages" >
                                <g:each in="${gameInstanceList}" var="gameInstance">
                                    <div class="col-md-3">
                                        <div class="info-box bg-aqua">
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
                                                    <img class="img-circle" alt="User Image" src="http://myapp.dev:9090/assets/img/inside/avatar.png"
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
                            </div>
                        </div>
                        <div class="box-footer text-center">
                            <a href="#" class="uppercase">Ir para recursos personalizáveis</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <!-- REAS PUBLICOS -->
                    <div class="box box-danger">
                        <div class="box-header with-border">
                            <h3 class="box-title">
                                <i class="fa fa-users"></i>
                                Recursos Públicos
                            </h3>
                        </div>
                        <div class="box-body no-padding">

                            <div class="direct-chat-messages" >
                                <g:if test="${publicExportedResourcesList.size() == 0}">
                                    <p>Nenhum jogo foi publicado no modo público.</p>
                                </g:if>
                                <g:else>
                                    <g:each in="${publicExportedResourcesList}" var="exportedResourceInstance">
                                        <div class="col-md-6">
                                            <div class="info-box bg-red">
                                                <span class="info-box-icon">
                                                    <i class="fa fa-simplybuilt"></i>
                                                </span>
                                                <div class="info-box-content">
                                                    <span class="info-box-text">${exportedResourceInstance.name}</span>
                                                    <span class="info-box-number">
                                                        <img class="img-circle" alt="User Image" src="http://myapp.dev:9090/assets/img/inside/avatar04.png"
                                                             height="25" width="25"/>
                                                        ${exportedResourceInstance.owner.name}
                                                    </span>
                                                    <span class="progress-description">
                                                        <div class="pull-right">
                                                            <g:if test="${exportedResourceInstance.webUrl != null}">
                                                                <a href="${exportedResourceInstance.webUrl}" style="color: white;"><i class="fa fa-at"></i></a>
                                                            </g:if>
                                                            <g:if test="${exportedResourceInstance.androidUrl != null}">
                                                                <a href="${exportedResourceInstance.androidUrl}"><i class="fa fa-android"></i></a>
                                                            </g:if>
                                                            <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                                                <a href="${exportedResourceInstance.linuxUrl}"><i class="fa fa-linux"></i></a>
                                                            </g:if>
                                                            <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                                                <a href="${exportedResourceInstance.moodleUrl}"><i class="fa fa-graduation-cap"></i></a>
                                                            </g:if>
                                                        </div>
                                                    </span>
                                                </div><!-- /.info-box-content -->
                                            </div><!-- /.info-box -->
                                        </div>
                                    </g:each>
                                </g:else>

                            </div>

                        </div>
                        <div class="box-footer text-center">
                            <a href="#" class="uppercase">Ir para recursos públicos</a>
                        </div>
                    </div>
                </div><!-- /.col -->

                <div class="col-md-6">
                    <div class="box box-warning direct-chat direct-chat-warning">
                        <div class="box-header with-border">
                            <h3 class="box-title">
                                <i class="fa fa-lock"></i>
                                Meus Recursos
                            </h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <div class="direct-chat-messages" >

                                <g:if test="${myExportedResourcesList.size() == 0}">
                                    <p>Você ainda não tem nenhum jogo publicado</p>
                                </g:if>
                                <g:else>
                                    <g:each in="${myExportedResourcesList}" var="myExportedResourceInstance">
                                        <div class="col-md-6">
                                            <div class="info-box bg-yellow">
                                                <span class="info-box-icon">
                                                    <i class="fa fa-simplybuilt"></i>
                                                </span>
                                                <div class="info-box-content">
                                                    <span class="info-box-text">${myExportedResourceInstance.name}</span>
                                                    <span class="info-box-number">
                                                        <img class="img-circle" alt="User Image" src="http://myapp.dev:9090/assets/img/inside/avatar04.png"
                                                             height="25" width="25"/>
                                                        ${myExportedResourceInstance.owner.name}
                                                    </span>
                                                    <span class="progress-description">
                                                        <div class="pull-right">
                                                            <g:if test="${myExportedResourceInstance.webUrl != null}">
                                                                <a href="${myExportedResourceInstance.webUrl}" style="color: white;"><i class="fa fa-at"></i></a>
                                                            </g:if>
                                                            <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                                                <a href="${myExportedResourceInstance.androidUrl}"><i class="fa fa-android"></i></a>
                                                            </g:if>
                                                            <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                                                <a href="${myExportedResourceInstance.linuxUrl}"><i class="fa fa-linux"></i></a>
                                                            </g:if>
                                                            <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                                                <a href="${myExportedResourceInstance.moodleUrl}"><i class="fa fa-graduation-cap"></i></a>
                                                            </g:if>
                                                        </div>
                                                    </span>
                                                </div><!-- /.info-box-content -->
                                            </div><!-- /.info-box -->
                                        </div>
                                    </g:each>
                                </g:else>

                        </div><!-- /.box-body -->
                        <div class="box-footer text-center">
                            <a href="#" class="uppercase">Ir para meus recursos</a>
                        </div><!-- /.box-footer-->
                    </div><!--/.direct-chat -->
                </div><!-- /.col -->
            </div><!-- /.row -->

            %{--<div class="row">--}%
                %{--<!-- Left col -->--}%
                %{--<div class="col-md-8">--}%
                    %{--<!-- MAP & BOX PANE -->--}%
                    %{--<div class="box box-success">--}%
                        %{--<div class="box-header with-border">--}%
                            %{--<h3 class="box-title">--}%
                                %{--<i class="fa fa-list-alt"></i>--}%
                                %{--Tarefas Pendentes--}%
                            %{--</h3>--}%

                        %{--</div><!-- /.box-header -->--}%
                        %{--<div class="box-body no-padding">--}%
                            %{--<div class="row">--}%
                                %{--<div class="col-md-9 col-sm-8">--}%
                                    %{--<div class="pad">--}%
                                        %{--<!-- Map will be created here -->--}%
                                        %{--<div id="world-map-markers" style="height: 325px;"></div>--}%
                                    %{--</div>--}%
                                %{--</div><!-- /.col -->--}%
                                %{--<div class="col-md-3 col-sm-4">--}%
                                    %{--<div class="pad box-pane-right bg-green" style="min-height: 280px">--}%
                                        %{--<div class="description-block margin-bottom">--}%

                                            %{--<h5 class="description-header">100</h5>--}%
                                            %{--<span class="description-text">Tarefas</span>--}%
                                        %{--</div><!-- /.description-block -->--}%
                                        %{--<div class="description-block margin-bottom">--}%

                                            %{--<h5 class="description-header">30%</h5>--}%
                                            %{--<span class="description-text">Concluídas</span>--}%
                                        %{--</div><!-- /.description-block -->--}%
                                        %{--<div class="description-block">--}%

                                            %{--<h5 class="description-header">70%</h5>--}%
                                            %{--<span class="description-text">Pendentes</span>--}%
                                        %{--</div><!-- /.description-block -->--}%
                                    %{--</div>--}%
                                %{--</div><!-- /.col -->--}%
                            %{--</div><!-- /.row -->--}%
                            %{--<div class="box-footer text-center">--}%
                                %{--<a href="#" class="uppercase">Ir para tarefas pendentes</a>--}%
                            %{--</div><!-- /.box-footer-->--}%
                        %{--</div><!-- /.box-body -->--}%
                    %{--</div><!-- /.box -->--}%
                %{--</div>--}%
                %{--<div class="col-md-4">--}%
                    %{--<div class="box box-default">--}%
                        %{--<div class="box-header with-border">--}%
                            %{--<h3 class="box-title">--}%
                                %{--<i class="fa fa-info"></i>--}%
                                 %{--Recursos mais personalizáveis--}%
                            %{--</h3>--}%

                        %{--</div><!-- /.box-header -->--}%
                        %{--<div class="box-body">--}%
                            %{--<div class="row">--}%
                                %{--<div class="col-md-8">--}%
                                    %{--<div class="chart-responsive">--}%
                                        %{--<canvas id="pieChart" height="150"></canvas>--}%
                                    %{--</div><!-- ./chart-responsive -->--}%
                                %{--</div><!-- /.col -->--}%
                                %{--<div class="col-md-4">--}%
                                    %{--<ul class="chart-legend clearfix">--}%
                                        %{--<li><i class="fa fa-circle-o text-red"></i> Escola Mágica</li>--}%
                                        %{--<li><i class="fa fa-circle-o text-green"></i> QuiForca</li>--}%
                                        %{--<li><i class="fa fa-circle-o text-yellow"></i> MathJong</li>--}%
                                        %{--<li><i class="fa fa-circle-o text-aqua"></i> Piramática</li>--}%
                                        %{--<li><i class="fa fa-circle-o text-light-blue"></i> Ortotetris</li>--}%
                                        %{--<li><i class="fa fa-circle-o text-gray"></i> Musikinésia</li>--}%
                                    %{--</ul>--}%
                                %{--</div><!-- /.col -->--}%
                            %{--</div><!-- /.row -->--}%
                        %{--</div><!-- /.box-body -->--}%
                        %{--<div class="box-footer no-padding">--}%
                            %{--<ul class="nav nav-pills nav-stacked">--}%
                                %{--<li>--}%
                                    %{--<a href="#">Escola Mágica--}%
                                        %{--<span class="pull-right text-red">--}%
                                        %{--</span>--}%
                                    %{--</a>--}%
                                %{--</li>--}%
                                %{--<li>--}%
                                    %{--<a href="#">QuiForca--}%
                                        %{--<span class="pull-right text-green">--}%
                                        %{--</span>--}%
                                    %{--</a>--}%
                                %{--</li>--}%
                                %{--<li>--}%
                                    %{--<a href="#">MathJong--}%
                                        %{--<span class="pull-right text-yellow">--}%
                                        %{--</span>--}%
                                    %{--</a>--}%
                                %{--</li>--}%
                            %{--</ul>--}%
                        %{--</div><!-- /.footer -->--}%
                    %{--</div><!-- /.box -->--}%
                %{--</div>--}%
            %{--</div>--}%
        </div>
</body>
</html>