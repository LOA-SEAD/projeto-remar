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
    <meta name="layout" content="main-inside">
    <g:set var="entityName"
           value="${message(code: 'user.label', default: 'User')}" />
    <title>Admin page</title>
</head>
<body>

    %{--<div class="container-fluid">--}%
        %{--<div class="col-sm-3 col-md-2 sidebar">--}%
            %{--<ul class="nav nav-sidebar">--}%
                %{--<li> <a href="a">Tarefas Pendentes</a></li>--}%
                %{--<li> <a href="a">Meus Processos</a></li>--}%
            %{--</ul>--}%
        %{--</div>--}%
    %{--</div>--}%
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title">
                    <i class="fa fa-gamepad"></i> Jogos personalizáveis
                </h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="row">
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
                        %{--<div class="table-responsive">--}%
                            %{--<table class="table table-striped table-bordered" id="table">--}%
                                %{--<tbody>--}%
                                %{--<tr>--}%
                                    %{--<td align="center"><a href="/forca" target="_blank"><img--}%
                                            %{--src="${resource(dir:'images', file: 'forca.jpg')}"--}%
                                            %{--class="img img-responsive max onhove" /></a></td>--}%
                                    %{--<td align="center"><a href="/mathjong" target="_blank"><img--}%
                                            %{--src="${resource(dir:'images', file: 'mathjong-banner.png')}"--}%
                                            %{--class="img img-responsive max onhove" /></a></td>--}%
                                    %{--<td align="center"><a href="/escolamagica" target="_blank"><img--}%
                                            %{--src="${resource(dir:'escolamagica', file: 'escolamagica-banner.png')}"--}%
                                            %{--class="img img-responsive max onhove" /></a></td>--}%
                                %{--</tr>--}%
                                %{--</tbody>--}%
                            %{--</table>--}%
                        %{--</div>--}%
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
</html>