<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 26/11/15
  Time: 10:32
--%>
    <div class="hide-on-large-only">
        <li>
            <div class="user-view no-margin">
                <div class="background remar-brown"></div>
                <a href="#!user">
                    <img class="circle"
                         src="/data/users/${session.user.username}/profile-picture"
                         alt="${session.user.firstName}">
                </a>
                <a href="#!name"><span class="white-text name">${session.user.firstName} ${session.user.lastName}</span></a>
                <a href="#!email"><span class="white-text email">${session.user.email}</span></a>
            </div>
        </li>

        <div class="divider no-margin hide-on-large-only"></div>

        <li class="waves-effect waves-block waves-light">
            <a href="/my-profile">
                <i class="material-icons">account_circle</i>
                <g:message code="sidenav.button.myProfile"/>
            </a>
        </li>

        <li class="waves-effect waves-block waves-light">
            <a href="/logout">
                <i class="fa fa-sign-out center"></i>
                <g:message code="default.button.logout.label"/>
            </a>
        </li>

        <div class="divider"></div>
    </div>

    <li class="waves-effect waves-block waves-light">
        <a href="/" class="valign-wrapper">
            <i class="material-icons">dashboard</i>
            <g:message code="sidenav.buttons.home"/>
        </a>
    </li>

    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos disponíveis para jogar." data-step="1">
        <a href="/exportedResource/publicGames" class="valign-wrapper">
            <i class="material-icons">videogame_asset</i>
            <g:message code="sidenav.buttons.gamehub"/>
        </a>
    </li>

    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os modelos de jogos que são customizáveis." data-step="2">
        <a href="/resource/customizableGames" class="valign-wrapper">
            <i class="material-icons">create</i>
            <g:message code="sidenav.buttons.customize"/>
        </a>
    </li>

    <div class="divider"></div>

    <li class="waves-effect waves-block waves-light"
        data-intro="Aqui você encontra todos os seus jogos (customizados ou em processo de customização)."
        data-step="3">
        <a href="/exportedResource/myGames" class="valign-wrapper">
            <i class="material-icons">recent_actors</i>
            <g:message code="sidenav.buttons.myGames"/>
        </a>
    </li>

    <li class="waves-effect waves-block waves-light"
        data-intro="Aqui você encontra todos os seus grupos criados."
        data-step="4">
        <a href="/group/list" class="valign-wrapper">
            <i class="material-icons">people</i>
            <g:message code="sidenav.buttons.myGroups"/>
        </a>
    </li>

    <g:if test="${grailsApplication.config.dspace.restUrl}">
        <li class="waves-effect waves-block waves-light"
            data-intro="Aqui você encontra recursos abertos  que podem ser reutilizados na customização de seus jogos."
            data-step="5">
            <a href="/dspace/repository" class="valign-wrapper">
                <i class="material-icons">cloud</i>
                <g:message code="sidenav.buttons.dspace"/>
            </a>
        </li>
    </g:if>

    <sec:ifAllGranted roles="ROLE_DEV">
        <li class="waves-effect waves-block waves-light"
            data-intro="No espaço do desenvolvedor você pode submeter um novo jogo para o REMAR."
            data-step="6">
            <a href="/resource/index" class="valign-wrapper">
                <i class="material-icons">code</i>
                <g:message code="sidenav.buttons.developer"/>
            </a>
        </li>
    </sec:ifAllGranted>

    <sec:ifAllGranted roles="ROLE_ADMIN">
        <li class="waves-effect waves-block waves-light"
            data-intro="No espaço do administrador, você encontra ferramentas para gerenciar todos os recursos do REMAR."
            data-step="7">
            <a href="/admin/dashboard" class="valign-wrapper">
                <i class="material-icons">verified_user</i>
                <g:message code="sidenav.buttons.admin"/>
            </a>
        </li>
    </sec:ifAllGranted>

    <div class="divider"></div>

    <li class="waves-effect waves-block waves-light"
        data-intro="Aqui você encontra orientações para o uso da plataforma e customização de cada modelo de jogo"
        data-step="8">
        <a href="https://remar.readme.io/docs" class="valign-wrapper" target="_blank">
            <i class="material-icons">description</i>
            <g:message code="sidenav.buttons.documentation"/>
        </a>
    </li>

    <li class="waves-effect waves-block waves-light"
        data-intro="Aqui você pode relatar qualquer tipo de problema na plataforma, como um bug ou um abuso, para que nós possamos analisar."
        data-step="9">
        <a id="report-modal-trigger" href="#report-modal" class="modal-trigger valign-wrapper">
            <i class="material-icons">error</i>
            <g:message code="sidenav.buttons.report"/>
        </a>
        %{-- modal is in base.gsp --}%
    </li>

    <li class="waves-effect waves-block waves-light"
        data-intro="Para ver este wizard novamente basta clicar aqui."
        data-step="10">
        <a onclick="startWizard()" class="valign-wrapper">
            <i class="material-icons">help</i>
            <g:message code="sidenav.buttons.navigation"/>
        </a>
    </li>


<input id="userFirstAccessLabel" type="hidden" value="${session.user.firstAccess}" > <label for="userFirstAccessLabel"></label>



<g:javascript src="remar/layouts/menu.js"/>