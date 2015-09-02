
<%@ page import="br.ufscar.sead.loa.remar.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <g:set var="entityName" value="${message(code: 'game.label', default: 'Game')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript  src="game-index.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}"	type="text/css">
</head>
<body>
<div class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-body box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <i class="fa fa-archive"></i>
                        Meus envios
                    </h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                   <div class="row">
                       %{--<div class="callout callout-info">--}%
                           %{--<h4>--}%
                               %{--<i class="fa fa-upload"></i>--}%
                               %{--Novo Recurso--}%
                           %{--</h4>--}%
                           %{--<div class="direct-chat-messages direct-chat-submit-war" >--}%
                               %{--<g:form class="" url="[resource:gameInstance, action:'save']" enctype="multipart/form-data" useToken="true">--}%
                                   %{--<fieldset class="form">--}%
                                       %{--<g:render template="form"/>--}%
                                   %{--</fieldset>--}%
                                   %{--<fieldset>--}%
                                       %{--<g:submitButton name="create" class="btn btn-block btn-default btn-flat" value="Enviar" />--}%
                                   %{--</fieldset>--}%

                               %{--</g:form>--}%
                           %{--</div>--}%
                       %{--</div>--}%
                       <div class="small-box bg-yellow">
                           <div class="inner">
                               <div class="direct-chat-messages direct-chat-submit-war" >
                                   <g:form class="" url="[resource:gameInstance, action:'save']" enctype="multipart/form-data" useToken="true">
                                       <fieldset class="form">
                                           <g:render template="form"/>
                                       </fieldset>
                                       <fieldset>
                                           <g:submitButton name="create" class="btn btn-block btn-default btn-flat" value="Enviar" />
                                       </fieldset>
                                   </g:form>
                               </div>
                               <div class="icon">
                                   <i class="fa fa-upload"></i>
                               </div>
                           </div>
                       </div>

                   </div>
                    <div class="row">
                        <div class="direct-chat-messages" >
                            <div class="widget-content-white glossed">
                                <div class="padded">
                                    <div class="row">
                                        <g:each in="${resourceInstanceList}" status="i" var="gameInstance">
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
                                                            <li><a class="delete" data-id="${gameInstance.id}">Delete</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel-body">
                                                <img src="/images/${gameInstance.uri}-banner.png"
                                                     class="img img-responsive center-block"/>
                                            </div>
                                            <div class="panel-footer">
                                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                                    <input class="comment" data-id="${gameInstance.id}" type="text" placeholder="Comment" value="${gameInstance.comment}">
                                                </sec:ifAllGranted>
                                                <sec:ifNotGranted roles="ROLE_ADMIN">
                                                    ${gameInstance.comment}
                                                </sec:ifNotGranted>

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
                                        %{--<div class="col-md-3">--}%
                                            %{--<a href="/resource/create">--}%
                                                %{--<div class="panel panel-default">--}%
                                                    %{--<div class="panel-heading">New deploy</div>--}%
                                                    %{--<div class="panel-body">--}%
                                                        %{--<img src="/assets/new-deploy.png"--}%
                                                             %{--class="img img-responsive center-block"/>--}%
                                                    %{--</div>--}%
                                                    %{--<div class="panel-footer">--}%
                                                        %{--<div class="pull-right">--}%
                                                            %{--<i class="fa fa-at"></i>--}%
                                                            %{--<i class="fa fa-android"></i>--}%
                                                            %{--<i class="fa fa-linux"></i>--}%
                                                            %{--<i class="fa fa-graduation-cap"></i>--}%
                                                        %{--</div>--}%
                                                        %{--<div class="clearfix"></div>--}%
                                                    %{--</div>--}%
                                                %{--</div>--}%
                                            %{--</a>--}%
                                        %{--</div>--}%
                                    </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    </div>
</div>

</body>
</html>
