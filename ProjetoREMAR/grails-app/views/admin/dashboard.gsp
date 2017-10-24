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

        <div class="row show no-margin center-align">
            %{-- Users card --}%
            <div class="col s4 l2">
                <div class="row">
                    <div class="col s12">
                        <div class="card no-margin hoverable">
                            <a href="/admin/users" class="card-image waves-effect waves-block waves-light">
                                <i class="material-icons">person</i>
                            </a>

                            <div class="card-content">
                                <span class="card-title grey-text text-darken-4">
                                    <g:message code="admin.dashboard.users"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            %{----------------}%

            %{-- Groups card --}%
            <div class="col s4 l2">
                <div class="row">
                    <div class="col s12">
                        <div class="card no-margin hoverable">
                            <a href="/admin/groups" class="card-image waves-effect waves-block waves-light">
                                <i class="material-icons">group</i>
                            </a>

                            <div class="card-content">
                                <span class="card-title grey-text text-darken-4">
                                    <g:message code="admin.dashboard.groups"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            %{-----------------}%

            %{-- Games card --}%
            <div class="col s4 l2">
                <div class="row">
                    <div class="col s12">
                        <div class="card no-margin hoverable">
                            <a href="/admin/games" class="card-image waves-effect waves-block waves-light">
                                <i class="material-icons">games</i>
                            </a>

                            <div class="card-content">
                                <span class="card-title grey-text text-darken-4">
                                    <g:message code="admin.dashboard.games"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            %{----------------}%

            %{-- Categories card --}%
            <div class="col s4 l2">
                <div class="row">
                    <div class="col s12">
                        <div class="card no-margin hoverable">
                            <a href="/admin/categories" class="card-image waves-effect waves-block waves-light">
                                <i class="material-icons">list</i>
                            </a>

                            <div class="card-content">
                                <span class="card-title grey-text text-darken-4">
                                    <g:message code="admin.dashboard.categories"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            %{---------------------}%

            %{-- Reports card --}%
            <div class="col s4 l2">
                <div class="row">
                    <div class="col s12">
                        <div class="card no-margin hoverable">
                            <a href="/admin/reports" class="card-image waves-effect waves-block waves-light">
                                <i class="material-icons">report</i>
                            </a>

                            <div class="card-content">
                                <span class="card-title grey-text text-darken-4">
                                    <g:message code="admin.dashboard.reports"/>
                                </span>
                            </div>
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