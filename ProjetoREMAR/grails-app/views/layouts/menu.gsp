<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 26/11/15
  Time: 10:32
--%>
<ul id="side-nav" class="side-nav">
    <div class="hide-on-large-only">
        <div class="row no-margin-bottom valign-wrapper">
            <div class="col s4">
                <img src="/data/users/${session.user.username}/profile-picture"
                     alt="${session.user.firstName}" class="circle responsive-img"
                     data-beloworigin="true">
            </div>
            <div class="col s8">
                <p class="no-margin-bottom">${session.user.firstName} ${session.user.lastName}</p>
                <p style="margin-top: 0px; margin-left: 20px;">(<u><a class="no-padding" href="/logout" style="display: inline;">Sair</a></u>)</p>
            </div>
        </div>

        <div class="divider"></div>

        <li>
            <a class="waves-effect waves-block waves-light" href="/my-profile"><i class="medium material-icons">account_circle</i>Meu perfil</a>
        </li>

        <div class="divider"></div>
    </div>

    <li>
        <a class="waves-effect waves-block waves-light" href="/" class=""><i class="medium mdi-action-dashboard"></i>Início</a>
    </li>
    <li data-intro="${message(code:'tutorial.step.one')}" data-step="1">
        <a class="waves-effect waves-block waves-light" href="/exportedResource/publicGames" class=""><i class="medium material-icons">videogame_asset</i>${message (code: 'menu.button.game.database.label')}</a>
    </li>

    <li data-intro="${message(code:'tutorial.step.two')}" data-step="2">
        <a class="waves-effect waves-block waves-light" href="/resource/customizableGames" class=""><i class="medium material-icons">create</i>${message (code: 'menu.button.customize.label')}</a>
    </li>

    <div class="divider"></div>

    <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
            <li class="no-margin" data-intro="${message(code:'tutorial.step.three')}"
        data-step="3">
                <a class="collapsible-header waves-effect waves-block waves-light"><i class="medium material-icons">recent_actors</i>Meus Jogos</a>
                <div class="collapsible-body no-padding">
                    <ul>
                        <li class="no-margin">
                            <a href="/exportedResource/myGames"><i class="medium material-icons">format_paint</i>Customizando</a>
                        </li>
                        <li class="no-margin">
                            <a href="/exportedResource/myGames"><i class="medium material-icons">public</i>Publicados</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="no-margin" data-intro="${message(code:'tutorial.step.four')}"
                data-step="4">
                <a class="collapsible-header waves-effect waves-block waves-light"><i class="material-icons">people</i>Meus Grupos</a>
                <div class="collapsible-body no-padding">
                    <ul class="no-margin">
                        <li class="no-margin">
                            <a href="/group/list"><i class="medium material-icons">accessibility</i>Sou Membro</a>
                        </li>
                        <li class="no-margin">
                            <a  href="/group/list"><i class="medium material-icons">build</i>Administro</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </li>
    <g:if test="${grailsApplication.config.dspace.restUrl}">
        <li data-intro="${message(code:'tutorial.step.five')}"
            data-step="5">
            <a class="waves-effect waves-block waves-light" href="/dspace/repository" class=""><i class="material-icons">cloud</i>Repositório</a>
        </li>
    </g:if>
    <sec:ifAllGranted roles="ROLE_DEV">
        <li data-intro="${message(code:'tutorial.step.six')}"
            data-step="6">
            <a class="waves-effect waves-block waves-light" href="/resource/index" class=""><i class="medium material-icons">code</i>Desenvolvedor</a>
        </li>
    </sec:ifAllGranted>

    <sec:ifAllGranted roles="ROLE_ADMIN">
        <li data-intro="${message(code:'tutorial.step.seven')}"
            data-step="7">
            <a class="waves-effect waves-block waves-light" href="/admin/dashboard" class="">
                <i class="material-icons">verified_user</i>
                Administrador
            </a>
        </li>
    </sec:ifAllGranted>

    <div class="divider"></div>


    <li data-intro="${message(code:'tutorial.step.eight')}"
        data-step="8">
        <a class="waves-effect waves-block waves-light" href="https://remar.readme.io/docs" target="_blank">
            <i class="medium material-icons">description</i>
            Documentação
        </a>
    </li>

    <li data-intro="${message(code:'tutorial.step.nine')}"
        data-step="9">
        <a class="waves-effect waves-block waves-light" id="report-modal-trigger" href="#report-modal" class="modal-trigger">
            <i class="medium material-icons">error</i>
            Relatar um problema
        </a>
        %{-- modal is in base.gsp --}%
    </li>

    <li data-intro="${message(code:'tutorial.step.ten')}"
        data-step="10">
        <a onclick="startWizard()" class="waves-effect waves-block waves-light">
            <i class="medium material-icons">help</i>
            Ajuda na navegação
        </a>
    </li>

</ul>

<input id="userFirstAccessLabel" type="hidden" value="${session.user.firstAccess}" > <label for="userFirstAccessLabel"></label>



<g:javascript src="remar/layouts/menu.js"/>