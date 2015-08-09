
<%@ page import="br.ufscar.sead.loa.remar.Game" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main-developer">
    <g:set var="entityName" value="${message(code: 'game.label', default: 'Game')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript  src="game-index.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}"	type="text/css">
</head>
<body>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <div class="main-content">
        <div class="widget">
            <h3 class="section-title first-title">
                <i class="fa fa-archive"></i> WARs
            </h3>
            <div class="widget-content-white glossed">
                <div class="padded">
                    <div class="row">
                        <g:each in="${gameInstanceList}" status="i" var="gameInstance">
                            <div class="col-md-3">
                            <g:if test="${gameInstance.status == 'pending'}">
                                <div class="panel panel-yellow">
                            </g:if>
                            <g:elseif test="${gameInstance.status == 'approved'}">
                                <div class="panel panel-green">
                            </g:elseif>
                            <g:elseif test="${gameInstance.status == 'rejected'}">
                                <div class="panel panel-red">
                            </g:elseif>
                            <div class="panel-heading">
                                ${gameInstance.name.toUpperCase()}
                                <div class="pull-right">
                                    <div class="dropdown pointer">
                                        %{--<a href="#" data-toggle="dropdown" class="dropdown-toggle"><b class="caret"></b></a>--}%
                                        <div class="dropdown-toggle" data-toggle="dropdown">
                                            <i class="fa fa-ellipsis-v"></i>
                                        </div>
                                        <ul class="dropdown-menu">
                                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                                <li><a class="review" data-review="approve" data-id="${gameInstance.id}">Approve</a></li>
                                                <li><a class="review" data-review="reject" data-id="${gameInstance.id}">Reject</a></li>
                                                <li class="divider"></li>
                                            </sec:ifAllGranted>
                                            <li><a href="/game/delete/${gameInstance.id}">Delete</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <img src="/images/${gameInstance.uri}-banner.png"
                                     class="img img-responsive center-block"/>
                            </div>
                            <div class="panel-footer">
                                <input class="comment" data-id="${gameInstance.id}" type="text" placeholder="Comment" value="${gameInstance.comment}">
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
                        <div class="col-md-3">
                            <a href="/game/create">
                                <div class="panel panel-default">
                                    <div class="panel-heading">New deploy</div>
                                    <div class="panel-body">
                                        <img src="/assets/new-deploy.png"
                                             class="img img-responsive center-block"/>
                                    </div>
                                    <div class="panel-footer">
                                        <div class="pull-right">
                                            <i class="fa fa-at"></i>
                                            <i class="fa fa-android"></i>
                                            <i class="fa fa-linux"></i>
                                            <i class="fa fa-graduation-cap"></i>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
</body>
</html>
