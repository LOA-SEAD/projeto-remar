<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 26/11/15
  Time: 10:32
--%>
<ul id="side-nav" class="side-nav">
    <sec:ifLoggedIn>
    <div class="hide-on-large-only">

        <div class="row no-margin-bottom valign-wrapper">
            <div class="col s4">
                <img src="/data/users/${session.user.username}/profile-picture"
                     alt="${session.user.firstName}" class="circle responsive-img"
                     data-beloworigin="true">
            </div>
            <div class="col s8">
                <p class="no-margin-bottom">${session.user.firstName} ${session.user.lastName}</p>
                <p style="margin-top: 0px; margin-left: 20px;">(<u><a class="no-padding" href="/logout" style="display: inline;">${message (code: 'menu.button.logout.label')}</a></u>)</p>
            </div>
        </div>

        <div class="divider"></div>

        <li>
            <a class="waves-effect waves-block waves-light" href="/my-profile"><i class="medium material-icons">account_circle</i>${message (code: 'menu.button.profile.label')}</a>
        </li>

        <div class="divider"></div>
    </div>
    </sec:ifLoggedIn>

    <li>
        <a class="waves-effect waves-block waves-light" href="/" class=""><i class="medium mdi-action-dashboard"></i>${message (code: 'default.home.label')}</a>
    </li>

    <sec:ifLoggedIn>

    <li data-intro="${message(code:'tutorial.step.one')}" data-step="1">
        <a class="waves-effect waves-block waves-light" href="/exportedResource/publicGames" class=""><i class="medium material-icons">videogame_asset</i>${message (code: 'menu.button.game.database.label')}</a>
    </li>

    <li data-intro="${message(code:'tutorial.step.two')}" data-step="2">
        <a class="waves-effect waves-block waves-light" href="/resource/customizableGames" class=""><i class="medium material-icons">create</i>${message (code: 'menu.button.customize.label')}</a>
    </li>

    <div class="divider"></div>

    </sec:ifLoggedIn>


    <sec:ifLoggedIn>
    <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
            <li class="no-margin" data-intro="${message(code:'tutorial.step.three')}"
        data-step="3">
                <a class="collapsible-header waves-effect waves-block waves-light"><i class="medium material-icons">recent_actors</i>${message (code: 'menu.button.my.games.label')}</a>
                <div class="collapsible-body no-padding">
                    <ul>
                        <li class="no-margin">
                            <a href="/exportedResource/myProcesses"><i class="medium material-icons">format_paint</i>${message (code: 'menu.button.my.games.customization.label')}</a>
                        </li>
                        <li class="no-margin">
                            <a href="/exportedResource/myGames"><i class="medium material-icons">public</i>${message (code: 'menu.button.my.published.games.label')}</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="no-margin" data-intro="${message(code:'tutorial.step.four')}"
                data-step="4">
                <a class="collapsible-header waves-effect waves-block waves-light"><i class="material-icons">people</i>${message (code: 'menu.button.my.groups.label')}</a>
                <div class="collapsible-body no-padding">
                    <ul class="no-margin">
                        <li class="no-margin">
                            <a href="/group/list"><i class="medium material-icons">accessibility</i>${message (code: 'menu.button.my.groups.member.label')}</a>
                        </li>
                        <li class="no-margin">
                            <a  href="/group/admin"><i class="medium material-icons">build</i>${message (code: 'menu.button.my.groups.admin.label')}</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </li>
    </sec:ifLoggedIn>
    <g:if test="${grailsApplication.config.dspace.restUrl}">
        <li data-intro="${message(code:'tutorial.step.five')}"
            data-step="5">
            <a class="waves-effect waves-block waves-light" href="/dspace/repository" class=""><i class="material-icons">cloud</i>${message (code: 'menu.button.repository.label')}</a>
        </li>
    </g:if>
    <sec:ifAllGranted roles="ROLE_DEV">
        <li data-intro="${message(code:'tutorial.step.six')}"
            data-step="6">
            <a class="waves-effect waves-block waves-light" href="/resource/index" class=""><i class="medium material-icons">code</i>${message (code: 'menu.button.developer.label')}</a>
        </li>
    </sec:ifAllGranted>

    <sec:ifAllGranted roles="ROLE_ADMIN">
        <li data-intro="${message(code:'tutorial.step.seven')}"
            data-step="7">
            <a class="waves-effect waves-block waves-light" href="/admin/dashboard" class="">
                <i class="material-icons">verified_user</i>
                ${message (code: 'menu.button.admin.label')}
            </a>
        </li>
    </sec:ifAllGranted>

    <div class="divider"></div>


    <li data-intro="${message(code:'tutorial.step.eight')}"
        data-step="8">
        <a class="waves-effect waves-block waves-light" href="https://remar.readme.io/docs" target="_blank">
            <i class="medium material-icons">description</i>
            ${message (code: 'menu.button.documentation.label')}
        </a>
    </li>

    <li data-intro="${message(code:'tutorial.step.nine')}"
        data-step="9">
        <a class="modal-trigger waves-effect waves-block waves-light" id="report-modal-trigger" href="#report-modal">
            <i class="medium material-icons">error</i>
            ${message (code: 'menu.button.report.label')}
        </a>
        %{-- modal is in base.gsp --}%
    </li>

    <sec:ifLoggedIn>
    <li data-intro="${message(code:'tutorial.step.ten')}"
        data-step="10">
        <a onclick="startWizard()" class="waves-effect waves-block waves-light">
            <i class="medium material-icons">help</i>
            ${message (code: 'menu.button.help.label')}
        </a>
    </li>
    </sec:ifLoggedIn>
</ul>

<sec:ifLoggedIn>
<input id="userFirstAccessLabel" type="hidden" value="${session.user.firstAccess}" > <label for="userFirstAccessLabel"></label>
</sec:ifLoggedIn>


<g:javascript src="remar/layouts/menu.js"/>
