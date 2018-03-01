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

        <li class="waves-effect waves-block waves-light">
            <a href="/my-profile"><i class="medium material-icons">account_circle</i>Meu perfil</a>
        </li>

        <div class="divider"></div>
    </div>

    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class="medium mdi-action-dashboard"></i>Início</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos disponíveis para jogar." data-step="1">
        <a href="/exportedResource/publicGames" class=""><i class="medium material-icons">videogame_asset</i>Banco de Jogos</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os modelos de jogos que são customizáveis." data-step="2">
        <a href="/resource/customizableGames" class=""><i class="medium material-icons">create</i>Customizar</a>
    </li>


    <div class="divider"></div>

    <li class="no-padding"
        data-intro="Aqui você encontra todos os seus jogos (customizados ou em processo de customização)."
        data-step="3">
        <ul class="collapsible collapsible-accordion">
            <li>
            <a class="collapsible-header waves-effect waves-block waves-light"><i class="medium material-icons">recent_actors</i>Meus Jogos</a>
            <div class="collapsible-body no-padding">
                <ul class="no-margin">
                <li class="no-margin">
                    <a href="/exportedResource/myGames" class="waves-effect waves-block waves-light"><i class="medium material-icons">format_paint</i>Customizando</a>
                </li>
                <li class="no-margin">
                    <a href="/exportedResource/myGames" class="waves-effect waves-block waves-light"><i class="medium material-icons">public</i>Publicados</a>
                </li>
                </ul>
            </div>
            </li>
        </ul>
    </li>
    <li data-intro="Aqui você encontra todos os seus grupos criados."
        data-step="4">
        <ul class="collapsible collapsible-accordion">
            <li>
            <a class="collapsible-header waves-effect waves-block waves-light"><i class="material-icons">people</i>Meus Grupos</a>
            <div class="collapsible-body no-padding">
                <ul class="no-margin">
                <li class="no-margin">
                    <a href="/group/list" class="waves-effect waves-block waves-light"><i class="medium material-icons">accessibility</i>Sou Membro</a>
                </li>
                <li class="no-margin">
                    <a  href="/group/list" class="waves-effect waves-block waves-light"><i class="medium material-icons">build</i>Administro</a>
                </li>
                </ul>
            </div>
            </li>
        </ul>
    </li>
    <g:if test="${grailsApplication.config.dspace.restUrl}">
        <li class="waves-effect waves-block waves-light"
            data-intro="Aqui você encontra recursos abertos  que podem ser reutilizados na customização de seus jogos."
            data-step="5">
            <a href="/dspace/repository" class=""><i class="material-icons">cloud</i>Repositório</a>
        </li>
    </g:if>
    <sec:ifAllGranted roles="ROLE_DEV">
        <li class="waves-effect waves-block waves-light"
            data-intro="No espaço do desenvolvedor você pode submeter um novo jogo para o REMAR."
            data-step="6">
            <a href="/resource/index" class=""><i class="medium material-icons">code</i>Desenvolvedor</a>
        </li>
    </sec:ifAllGranted>

    <sec:ifAllGranted roles="ROLE_ADMIN">
        <li class="waves-effect waves-block waves-light"
            data-intro="No espaço do administrador, você encontra ferramentas para gerenciar todos os recursos do REMAR."
            data-step="7">
            <a href="/admin/dashboard" class="">
                <i class="material-icons">verified_user</i>
                Administrador
            </a>
        </li>
    </sec:ifAllGranted>

    <div class="divider"></div>


    <li class="waves-effect waves-block waves-light"
        data-intro="Aqui você encontra orientações para o uso da plataforma e customização de cada modelo de jogo"
        data-step="8">
        <a href="https://remar.readme.io/docs" target="_blank">
            <i class="medium material-icons">description</i>
            Documentação
        </a>
    </li>

    <li class="waves-effect waves-block waves-light"
        data-intro="Aqui você pode relatar qualquer tipo de problema na plataforma, como um bug ou um abuso, para que nós possamos analisar."
        data-step="9">
        <a id="report-modal-trigger" href="#report-modal" class="modal-trigger">
            <i class="medium material-icons">error</i>
            Relatar um problema
        </a>
        %{-- modal is in base.gsp --}%
    </li>

    <li class="waves-effect waves-block waves-light"
        data-intro="Para ver este wizard novamente basta clicar aqui."
        data-step="10">
        <a onclick="startWizard()" class="">
            <i class="medium material-icons">help</i>
            Ajuda na navegação
        </a>
    </li>

</ul>

<input id="userFirstAccessLabel" type="hidden" value="${session.user.firstAccess}" > <label for="userFirstAccessLabel"></label>



<g:javascript src="remar/layouts/menu.js"/>