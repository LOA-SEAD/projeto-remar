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

    <g:if test="${unseenReports > 0}">
        <div class="row no-margin">
            <div class="col s12">
                <div class="warning-box row valign-wrapper">
                    <div class="col s1 center-align">
                        <i class="material-icons tiny no-margin">warning</i>
                    </div>

                    <div id="warning-box-message" class="col s8">
                        <g:message code="admin.dashboard.reports.unseen" args="[unseenReports]"/>
                    </div>

                    <div class="col s3 right-align">
                        <button class="btn-flat close-warning">Fechar</button>
                    </div>
                </div>
            </div>
        </div>
    </g:if>


%{-- Display for medium and large screens --}%
    <div class="row hide-on-small-only">
        %{-- Users card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/users" class="card-image waves-effect waves-block waves-light center-align">
                    <i class="material-icons">person</i>
                </a>

                <div class="card-content">
                    <p class="card-title grey-text text-darken-4">
                        <g:message code="admin.dashboard.users"/>
                    </p>
                </div>
            </div>
        </div>
        %{----------------}%

        %{-- Groups card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/groups" class="card-image waves-effect waves-block waves-light center-align">
                    <i class="material-icons">group</i>
                </a>

                <div class="card-content">
                    <p class="card-title grey-text text-darken-4">
                        <g:message code="admin.dashboard.groups"/>
                    </p>
                </div>
            </div>
        </div>
        %{-----------------}%

        %{-- Games card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/games" class="card-image waves-effect waves-block waves-light center-align">
                    <i class="material-icons">games</i>
                </a>

                <div class="card-content">
                    <p class="card-title grey-text text-darken-4">
                        <g:message code="admin.dashboard.games"/>
                    </p>
                </div>
            </div>
        </div>
        %{----------------}%

        %{-- Categories card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/categories" class="card-image waves-effect waves-block waves-light center-align">
                    <i class="material-icons">list</i>
                </a>

                <div class="card-content">
                    <p class="card-title grey-text text-darken-4">
                        <g:message code="admin.dashboard.categories"/>
                    </p>
                </div>
            </div>
        </div>
        %{---------------------}%

        %{-- Reports card --}%
        <div class="col m2">
            <div class="card no-margin hoverable">
                <a href="/admin/reports" class="card-image waves-effect waves-block waves-light center-align">
                    <i class="material-icons">report</i>
                </a>

                <div class="card-content">
                    <p class="card-title grey-text text-darken-4">
                        <g:message code="admin.dashboard.reports"/>
                    </p>
                </div>
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
                    <a href="/admin/users" class="card-image waves-effect waves-block waves-light center-align">
                        <i class="material-icons">person</i>
                    </a>

                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.users"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        %{----------------}%

        %{-- Groups card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/groups" class="card-image waves-effect waves-block waves-light center-align">
                        <i class="material-icons">group</i>
                    </a>

                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.groups"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        %{-----------------}%

        %{-- Games card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/games" class="card-image waves-effect waves-block waves-light center-align">
                        <i class="material-icons">games</i>
                    </a>

                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.games"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        %{----------------}%

        %{-- Categories card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/categories" class="card-image waves-effect waves-block waves-light center-align">
                        <i class="material-icons">list</i>
                    </a>

                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.categories"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        %{---------------------}%

        %{-- Reports card --}%
        <div class="row">
            <div class="col s12 no-padding">
                <div class="card no-margin hoverable">
                    <a href="/admin/reports" class="card-image waves-effect waves-block waves-light center-align">
                        <i class="material-icons">report</i>
                    </a>

                    <div class="card-content">
                        <p class="card-title grey-text text-darken-4">
                            <g:message code="admin.dashboard.reports"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        %{---------------------}%
    </div>
</div>

<g:external dir="css" file="admin.css"/>
</body>
</html>