
<%@ page import="br.ufscar.sead.loa.remar.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <g:set var="entityName" value="${message(code: 'game.label', default: 'Game')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript  src="game-index.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}"	type="text/css">
    <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>

    <script>
        $(document).on('change', '.btn-file :file', function() {
            var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });

        $(document).ready( function() {
            $('.btn-file :file').on('fileselect', function(event, numFiles, label) {

                var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                if( input.length ) {
                    input.val(log);
                } else {
                    if( log ) alert(log);
                }

            });
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
                        <i class="fa fa-archive"></i>
                        Meus Recursos
                    </h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="small-box">
                            <div class="inner">
                                <h3>Submeter um recurso:</h3>
                                <g:form class="" url="[resource:gameInstance, action:'save']" enctype="multipart/form-data" useToken="true">
                                    <div class="direct-chat-messages direct-chat-submit-war" >
                                        <g:render template="form"/>

                                        <button name="create" class="btn btn-primary btn-flat">
                                            <i class="fa fa-upload"></i>
                                        </button>

                                        %{--<fieldset>--}%
                                        %{--<g:submitButton name="create" class="btn btn-block btn-default btn-flat"  value="Enviar"/> --}%
                                        %{--<input type="submit" name="create" > <i class="fa fa-upload"></i></input>--}%
                                        %{--</fieldset>--}%
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-upload"></i>
                                    </div>
                                </g:form>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="direct-chat-messages page-size" >
                            <div class="widget-content-white glossed">
                                <div class="padded">
                                    <div class="row">
                                        <g:each in="${resourceInstanceList}" status="i" var="gameInstance">
                                            %{--${gameInstance.status}--}%
                                            <div class="col-md-3">
                                            <g:if test="${gameInstance.status == 'pending'}">
                                                <div class="info-box bg-yellow-gradient">
                                            </g:if>
                                            <g:elseif test="${gameInstance.status == 'approved'}">
                                                <div class="info-box bg-green-gradient">
                                            </g:elseif>
                                            <g:elseif test="${gameInstance.status == 'rejected'}">
                                                <div class="info-box bg-red-gradient">
                                            </g:elseif>

                                            <span class="info-box-icon">
                                                %{--<a href="/process/start/${gameInstance.bpmn}" target="_self">                                                           --}%
                                                %{--<i class="fa fa-magic"></i>--}%
                                                %{--</a>--}%

                                                <img src="http://localhost:9090/images/${gameInstance.uri}-banner.png"
                                                     class="img img-responsive center-block"/>
                                            </span>

                                            <div class="info-box-content">
                                                <div class="pull-right">
                                                    <div class="dropdown pointer">
                                                        %{--<a href="#" data-toggle="dropdown" class="dropdown-toggle"><b class="caret"></b></a>--}%
                                                        <div class="dropdown-toggle" data-toggle="dropdown">
                                                            <i class="fa fa-ellipsis-v"></i>
                                                        </div>
                                                        <ul class="dropdown-menu">
                                                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                                                <li><a class="review" data-review="approve" data-id="${gameInstance.id}">Aprovar</a></li>
                                                                <li><a class="review" data-review="reject" data-id="${gameInstance.id}">Rejeitar</a></li>
                                                                <li class="divider"></li>
                                                            </sec:ifAllGranted>
                                                            <li><a class="delete" data-id="${gameInstance.id}">Excluir</a></li>
                                                        </ul>
                                                    </div>
                                                </div>

                                                <span class="info-box-text">${gameInstance.name.toUpperCase()}</span>
                                                <span id="development" class="info-box-number">
                                                    <sec:ifAllGranted roles="ROLE_ADMIN">
                                                        <input class="form-control" data-id="${gameInstance.id}" type="text" placeholder="Comment" value="${gameInstance.comment}">
                                                    </sec:ifAllGranted>
                                                    <sec:ifNotGranted roles="ROLE_ADMIN">
                                                        ${gameInstance.comment}
                                                    </sec:ifNotGranted>
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
                                        %{--<div class="col-md-3">--}%
                                        %{--<g:if test="${gameInstance.status == 'pending'}">--}%
                                        %{--<div class="panel panel-yellow">--}%
                                        %{--</g:if>--}%
                                        %{--<g:elseif test="${gameInstance.status == 'approved'}">--}%
                                        %{--<div class="panel panel-green">--}%
                                        %{--</g:elseif>--}%
                                        %{--<g:elseif test="${gameInstance.status == 'rejected'}">--}%
                                        %{--<div class="panel panel-red">--}%
                                        %{--</g:elseif>--}%
                                        %{--<div class="panel-heading">--}%
                                        %{--${gameInstance.name.toUpperCase()}--}%
                                        %{--<div class="pull-right">--}%
                                        %{--<div class="dropdown pointer">--}%
                                        %{--<a href="#" data-toggle="dropdown" class="dropdown-toggle"><b class="caret"></b></a>--}%
                                        %{--<div class="dropdown-toggle" data-toggle="dropdown">--}%
                                        %{--<i class="fa fa-ellipsis-v"></i>--}%
                                        %{--</div>--}%
                                        %{--<ul class="dropdown-menu">--}%
                                        %{--<sec:ifAllGranted roles="ROLE_ADMIN">--}%
                                        %{--<li><a class="review" data-review="approve" data-id="${gameInstance.id}">Approve</a></li>--}%
                                        %{--<li><a class="review" data-review="reject" data-id="${gameInstance.id}">Reject</a></li>--}%
                                        %{--<li class="divider"></li>--}%
                                        %{--</sec:ifAllGranted>--}%
                                        %{--<li><a class="delete" data-id="${gameInstance.id}">Delete</a></li>--}%
                                        %{--</ul>--}%
                                        %{--</div>--}%
                                        %{--</div>--}%
                                        %{--</div>--}%
                                        %{--<div class="panel-body">--}%
                                        %{--<img src="/images/${gameInstance.uri}-banner.png"--}%
                                        %{--class="img img-responsive center-block"/>--}%
                                        %{--</div>--}%
                                        %{--<div class="panel-footer">--}%
                                        %{--<sec:ifAllGranted roles="ROLE_ADMIN">--}%
                                        %{--<input class="comment" data-id="${gameInstance.id}" type="text" placeholder="Comment" value="${gameInstance.comment}">--}%
                                        %{--</sec:ifAllGranted>--}%
                                        %{--<sec:ifNotGranted roles="ROLE_ADMIN">--}%
                                        %{--${gameInstance.comment}--}%
                                        %{--</sec:ifNotGranted>--}%

                                        %{--<div class="pull-right">--}%
                                        %{--<i class="fa fa-at"></i>--}%
                                        %{--<g:if test="${gameInstance.android}">--}%
                                        %{--<i class="fa fa-android"></i>--}%
                                        %{--</g:if>--}%
                                        %{--<g:if test="${gameInstance.linux}">--}%
                                        %{--<i class="fa fa-linux"></i>--}%
                                        %{--</g:if>--}%
                                        %{--<g:if test="${gameInstance.moodle}">--}%
                                        %{--<i class="fa fa-graduation-cap"></i>--}%
                                        %{--</g:if>--}%
                                        %{--</div>--}%
                                        %{--<div class="clearfix"></div>--}%
                                        %{--</div>--}%
                                        %{--</div>--}%
                                        %{--</div>--}%
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

</body>
</html>
