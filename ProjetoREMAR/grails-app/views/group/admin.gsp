<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>
<body>
    <div class="row cluster">
      <div class="row cluster-header">
        <div class="col s12" style="font-size: 1.6em;">
          <a href="#!" class="first-breadcrumb black-text"><g:message code='group.label.myGroups' default="Meus Grupos"/></a>
          <a href="#!" class="breadcrumb black-text"><g:message code='menu.button.my.groups.admin.label' default="Sou Admin"/></a>
        </div>
        <div class="divider"></div>
      </div>
    </div>
    <div class="row" id="belong">
    <div style="position: relative; left: 1em" class="row">
        <g:if test="${groupsIOwn.empty && groupsIAdmin.empty}">
            <div class="warning-box">
                <i class="material-icons tiny">warning</i>
                <g:message code='group.message.noGroupAdmin' default="Você ainda não possui ou administra nenhum grupo."/>
            </div>
        </g:if>
            <a style="color: black;" class="" href="/group/new">
                <div class="col l3 s6 m3 offset-s3">
                    <div style="padding-bottom: 4.5em;" data-tooltip="Novo grupo" class="card hoverable grey lighten-2 tooltipped">
                        <div class="card-content grey lighten-2">

                            <div class="row">
                                <div class="center">
                                    <i style="font-size: 3.2em; position: relative; top: 0.8em;" class="material-icons">add_circle</i>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </a>
            <g:if test="${!groupsIOwn.empty}">
                <g:each var="group" in="${groupsIOwn}">
                    <a href="/group/show/${group.id}">
                        <div class="col l3 s6 m3 offset-s3">
                            <div style="padding-bottom: 8.0em;" class="card white hoverable">
                                <div style="top: 3.2em; position: relative;" class="card-content">
                                    <p class="truncate center-align remar-black-text">${group.name}</p>
                                </div>

                            </div>
                        </div>
                    </a>
                </g:each>
            </g:if>
            <g:if test="${!groupsIAdmin.empty}">
                <g:each var="group" in="${groupsIAdmin}">
                    <a href="/group/show/${group.id}">
                        <div class="col l3 s6 m3 offset-s3">
                            <div style="padding-bottom: 8.0em;" class="card white hoverable">
                                <div style="top: 3.2em; position: relative;" class="card-content">
                                    <p class="truncate center-align remar-black-text">${group.name}</p>
                                </div>

                            </div>
                        </div>
                    </a>
                </g:each>
            </g:if>
        </div>
    </div>
    <g:javascript src="libs/jquery/jquery.validate.js"/>
</body>
</html>