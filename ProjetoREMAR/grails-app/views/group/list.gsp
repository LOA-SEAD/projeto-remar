<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
    <div class="row">
        <div class="col l12 s12 m12">
            <ul class="tabs">
                <li class="tab"><a href="#others-groups">Sou Membro</a></li>
                <li class="tab"><a href="#my-groups">Sou Administrador</a></li>
            </ul>
        </div>
    </div>

    <div id="others-groups">
        <div class="row" id="belong">
            <g:if test="${groupsIBelong.empty}">
                <h5 class="center-align no-groups-message">Você ainda não pertence a nenhum grupo :(</h5>
            </g:if>
            <g:else>
                <g:each var="group" in="${groupsIBelong}">
                    <a href="/group/show/${group.id}">
                        <div class="col l3 s6 m3 offset-s3">
                            <div style="padding-bottom: 8.0em; position: relative; left: 0.6em;;" class="card white hoverable">
                                <div style="top: 3.2em; position: relative;" class="card-content">
                                    <p>${group.name}</p>
                                </div>

                            </div>
                        </div>
                    </a>
                </g:each>
            </g:else>
        </div>

        <div id="modal-user-in-group" class="modal">
            <div class="modal-content">
                <h5 id="modal-message"></h5>
            </div>
            <div class="modal-footer">
                <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Ok</a>
            </div>
        </div>
        <ul class="collapsible popout" data-collapsible="expandable">
            <li>
                <div class="collapsible-header"> <i class="material-icons">fingerprint</i>Código de Acesso</div>
                <div id="info" class="collapsible-body">
                    <div class="row">
                        %{--<g:form action="addUser" method="post">--}%
                        <div class="col offset-l4 offset-s2 offset-m3">
                            <form id="add-user-form">
                                <div class="input-field col l6 s6">
                                    <input class="user-input" name="membertoken" id="member-token" type="text" placeholder="Código de acesso" required>
                                    <label for="member-token"></label>
                                </div>
                                <div id="input-bottom" class="col l6 s4 m6">
                                    <button type="submit" title="Entre com o código de acesso" style="font-size: 0.8em; top: 1.4em; position:relative;"  class="btn waves-effect waves-light add-user">Entrar
                                        <i class="material-icons right">person_add</i>
                                    </button>
                                </div>
                            </form>
                        </div>
                        %{--</g:form>--}%
                    </div>
                </div>
            </li>
        </ul>
    </div>

    <div id="my-groups">
        <div style="position: relative; left: 1em" class="row">
            <g:if test="${groupsIOwn.empty && groupsIAdmin.empty}">
                <h5>Você ainda não possui nenhum grupo criado ou administrado :(</h5>
            </g:if>
                <g:else>
                    <g:if test="${!groupsIOwn.empty}">
                        <g:each var="group" in="${groupsIOwn}">
                            <a href="/group/show/${group.id}" style="color: black;">
                                <div class="col l3 s6 m3 offset-s3">
                                    <div style="padding-bottom: 8.0em;" class="card white hoverable">
                                        <div style="top: 3.2em; position: relative;" class="card-content">
                                            <span class="truncate">${group.name}</span>
                                        </div>

                                    </div>
                                </div>
                            </a>
                        </g:each>
                    </g:if>
                    <g:if test="${!groupsIAdmin.empty}">
                        <g:each var="group" in="${groupsIAdmin}">
                            <a href="/group/show/${group.id}" style="color: black;">
                                <div class="col l3 s6 m3 offset-s3">
                                    <div style="padding-bottom: 8.0em;" class="card white hoverable">
                                        <div style="top: 3.2em; position: relative;" class="card-content">
                                            <span class="truncate">${group.name}</span>
                                        </div>

                                    </div>
                                </div>
                            </a>
                        </g:each>
                    </g:if>

                </g:else>
                <a style="color: black;" class="" href="/group/new">
                    <div class="col l3 s6 m3 offset-s3">
                        <div style="padding-bottom: 4.5em;" data-tooltip="Novo grupo" class="card hoverable grey lighten-2 tooltipped">
                            <div class="card-content grey lighten-2">

                                <div class="row">
                                    <div class="center">
                                        <i style="font-size: 3.2em; position: relative; top: 0.8em;" class="material-icons">add_circle</i>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </a>
        </div>
    </div>
    
    <g:javascript src="jquery/jquery.validate.js"/>
    <g:javascript src="manage-user-group.js"/>
    <script>
        $(document).ready(function(){
            $('ul.tabs').tabs();
        });
    </script>
    </body>
</html>
