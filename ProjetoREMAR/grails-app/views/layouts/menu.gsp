<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 26/11/15
  Time: 10:32
--%>

<ul id="side-nav">

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
        <sec:ifNotGranted roles="ROLE_DEV">
            <li class="waves-effect waves-block waves-light">
                <a href="/developer/new" class=""><i class=" medium material-icons">code</i>Desenvolvedor</a>
            </li>
        </sec:ifNotGranted>
        <g:if test="${session.user.moodleUsername == null}">
            <li class="waves-effect waves-block waves-light">
                <a href="/moodle" class=""><i class=" medium material-icons">school</i>Vincular ao Moodle</a>
            </li>
        </g:if>

        <div class="divider"></div>
    </div>

    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class=" medium mdi-action-dashboard"></i>Início</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos que são customizáveis." data-step="1">
        <a href="/resource/customizableGames" class=""><i class="medium material-icons">create</i>Jogos customizáveis</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos públicos que já foram publicados." data-step="2">
        <a href="/exportedResource/publicGames" class=""><i class="medium material-icons">public</i>Jogos públicos</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos que você publicou." data-step="3">
        <a href="/exportedResource/myGames" class=""><i class="medium material-icons">recent_actors</i>Meus Jogos</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra os seus jogos em processo de customização." data-step="3">
        <a href="/process/list" class=""><i class="medium material-icons">list</i>Meus processos</a>
    </li>
    <sec:ifAllGranted roles="ROLE_DEV">
        <li class="waves-effect waves-block waves-light" data-intro="No espaço do desenvolvedor você pode submeter um novo jogo para o REMAR." data-step="4">
            <a href="/resource/index" class=""><i class="medium material-icons">code</i>Desenvolvedor</a>
        </li>
    </sec:ifAllGranted>

    <li class="waves-effect waves-block waves-light" data-intro="Para ver este wizard novamente basta clicar aqui." data-step="5">
        <a  onclick="startWizard()" class=""><i class="medium material-icons">live_help</i>Ajuda na navegação</a>
    </li>
</ul>

<input id="userFirstAccessLabel" type="hidden" value="${session.user.firstAccess}" > <label for="userFirstAccessLabel"></label>
