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
                <img src="../data/users/${session.user.username}/profile-picture"
                     alt="${session.user.firstName}" class="circle responsive-img"
                     data-beloworigin="true">
            </div>
            <div class="col s8">
                <p class="no-margin-bottom">${session.user.firstName} ${session.user.lastName}</p>
                <p style="margin-top: 0px; margin-left: 20px;">(<u><a class="no-padding" href="/logout" style="display: inline;">Sair</a></u>)</p>
            </div>
        </div>

        <div class="divider"></div>
    </div>

    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class=" medium mdi-action-dashboard"></i>Início</a>
    </li>
    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class="medium material-icons">create</i>Criar novo R.E.A</a>
    </li>
    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class="medium material-icons">recent_actors</i>Meus R.E.As</a>
    </li>
    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class="medium material-icons">public</i>R.E.As públicos</a>
    </li>
    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class="medium material-icons">live_help</i>Ajuda na navegação</a>
    </li>

    <div class="hide-on-large-only">
        <div class="divider"></div>

        <li class="waves-effect waves-block waves-light">
            <a href="/developer/new" class=""><i class=" medium material-icons">code</i>Desenvolvedor</a>
        </li>
        <g:if test="${session.user.moodleUsername == null}">
            <li class="waves-effect waves-block waves-light">
                <a href="/moodle" class=""><i class=" medium material-icons">school</i>Vincular ao Moodle</a>
            </li>
        </g:if>

    </div>
</ul>