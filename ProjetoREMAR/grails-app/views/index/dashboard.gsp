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
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'user.label', default: 'User')}" />
    <title>Admin page</title>
</head>
<body>
<div class="page-header">
    <h1>DASHBOARD</h1>
</div>
<div class="main-content">
    <div class="widget">
        <h3 class="section-title first-title">
            <i class="icon-table"></i> Jogos personalizáveis
        </h3>
        <div class="widget-content-white glossed">
            <div class="padded">
                <div class="row">
                    <g:each in="${games}" var="game">
                        <div class="col-md-4">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    ${game[0].toUpperCase()}
                                </div>
                                <div class="panel-body">
                                    <a href="/${game[0].toLowerCase()}" target="_blank">
                                        <img
                                            src="/assets/${game[0].toLowerCase()}-banner.png"
                                            class="img img-responsive center-block"/>
                                    </a>
                                </div>
                                <div class="panel-footer">
                                    <div class="pull-right">
                                        <g:if test=" ${(game[1] as String).indexOf('Web') != -1}">
                                            <i class="fa fa-at"></i>
                                        </g:if>
                                        <g:if test=" ${(game[1] as String).indexOf('Android') != -1}">
                                            <i class="fa fa-android"></i>
                                        </g:if>
                                        <g:if test=" ${(game[1] as String).indexOf('Linux') != -1}">
                                            <i class="fa fa-linux"></i>
                                        </g:if>
                                        <g:if test=" ${(game[1] as String).indexOf('Moodle') != -1}">
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
                                    src="${resource(dir:'images', file: 'forca.jpg')}"
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


</body>
</html>