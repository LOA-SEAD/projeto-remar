<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
    <div class="row cluster">
        <div class="cluster-header">
            <h4>Meus Grupos</h4>
            <div class="divider"></div>
        </div>
    <div class="row" id="belong">
    <g:if test="${groupsIBelong.empty}">
        <div class="warning-box">
            <i class="material-icons tiny">warning</i>
            Você ainda não pertence a nenhum grupo.
        </div>
    </g:if>
    <g:else>
        <g:each var="group" in="${groupsIBelong}">
            <a href="/group/show/${group.id}">
                <div class="col l3 s6 m3 offset-s3">
                    <div style="padding-bottom: 8.0em; position: relative; left: 0.6em;;" class="card white hoverable">
                        <div style="top: 3.2em; position: relative;" class="card-content">
                            <p class="truncate center-align remar-black-text">${group.name}</p>
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
        <g:if test="${groupsIBelong.empty}">
            <div class="collapsible-header active">
        </g:if>
        <g:else>
            <div class="collapsible-header">
        </g:else>
           Código de Acesso
        </div>

            <div id="info" class="collapsible-body">
            <div class="row">
                <g:if test="${flash.message}">
                    ${flash.message}
                </g:if>
                <g:form action="addUserByToken" method="post">
                <div class="col offset-l4 offset-s2 offset-m3">
                    <!--form id="add-user-form"-->
                        <div class="input-field col l6 s6">
                            <input class="user-input" name="membertoken" id="member-token" type="text" placeholder="Código de acesso" required>
                            <label for="member-token"></label>
                        </div>
                        <div id="input-bottom" class="col l6 s4 m6">
                            <button type="submit" title="Entre com o código de acesso" style="font-size: 0.8em; top: 1.4em; position:relative;"  class="btn waves-effect waves-light remar-orange">Entrar

                            </button>
                        </div>
                    <!--/form-->
                </div>
                </g:form>
            </div>
        </div>
    </li>
</ul>

    <g:javascript src="libs/jquery/jquery.validate.js"/>
    </body>
</html>
