    <%--
  Created by IntelliJ IDEA.
  User: garciaph
  Date: 06/09/17
  Time: 17:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>
        <g:message code="admin.dashboard.title"/>
    </title>
</head>

<body>
<div class="row cluster">
    <div class="row cluster-header">
        <h4><g:message code="admin.dashboard.title"/></h4>

        <div class="divider"></div>
    </div>

    %{-- Display for medium and large screens --}%
    <div class="row hide-on-small-only">
        %{-- Users card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/users" class="waves-effect waves-block waves-light center-align">
                    <div class="card-image">
                        <i class="material-icons">person</i>
                    </div>

                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.users"/>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        %{----------------}%

        %{-- Groups card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/groups" class=" waves-effect waves-block waves-light center-align">
                    <div class="card-image">
                        <i class="material-icons">group</i>
                    </div>


                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.groups"/>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        %{-----------------}%

        %{-- Games card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/games" class="waves-effect waves-block waves-light center-align">
                    <div class="card-image">
                        <i class="material-icons">games</i>
                    </div>


                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.games"/>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        %{----------------}%

        %{-- Categories card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/categories" class="waves-effect waves-block waves-light center-align">
                    <div class="card-image">
                        <i class="material-icons">list</i>
                    </div>


                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.categories"/>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        %{---------------------}%

        %{-- Announcements card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/announcements" class="waves-effect waves-block waves-light center-align">
                    <div class="card-image">
                        <i class="material-icons">message</i>
                    </div>


                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.announcements"/>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        %{---------------------}%

        %{-- Reports card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/reports" class="waves-effect waves-block waves-light center-align">
                    <div class="card-image">
                        <i class="material-icons">report</i>
                    </div>


                    <div class="card-content collection no-margin no-border">
                        <p class="card-title grey-text text-darken-4 collection-item">
                            <span class="new badge remar-orange">${unseenReports}</span>
                            <g:message code="admin.dashboard.reports"/>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        %{---------------------}%
    </div>

    %{-- Display for small screens only --}%
    <div class="row hide-on-med-and-up">
        %{-- Users card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/users" class="waves-effect waves-block waves-light center-align">
                        <div class="card-content">
                            <i class="material-icons">person</i>
                            <p class="card-title grey-text text-darken-4">
                                <g:message code="admin.dashboard.users"/>
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        %{----------------}%

        %{-- Groups card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/groups" class="waves-effect waves-block waves-light center-align">
                        <div class="card-content">
                            <i class="material-icons">group</i>
                            <p class="card-title grey-text text-darken-4">
                                <g:message code="admin.dashboard.groups"/>
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        %{-----------------}%

        %{-- Games card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/games" class="waves-effect waves-block waves-light center-align">
                        <div class="card-content">
                            <i class="material-icons">games</i>
                            <p class="card-title grey-text text-darken-4">
                                <g:message code="admin.dashboard.games"/>
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        %{----------------}%

        %{-- Categories card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/categories" class="waves-effect waves-block waves-light center-align">
                        <div class="card-content">
                            <i class="material-icons">list</i>
                            <p class="card-title grey-text text-darken-4">
                                <g:message code="admin.dashboard.categories"/>
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        %{---------------------}%

        %{-- Reports card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/reports" class="waves-effect waves-block waves-light center-align">
                        <div class="card-content">
                            <i class="material-icons">report</i>
                            <p class="card-title grey-text text-darken-4">
                                <span class="new badge remar-orange">${unseenReports}</span>
                                <g:message code="admin.dashboard.reports"/>
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        %{---------------------}%
    </div>
</div>

<g:external dir="css" file="admin.css"/>
</body>
</html>