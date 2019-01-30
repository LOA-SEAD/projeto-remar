<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.Group" %>
<%@ page import="br.ufscar.sead.loa.remar.UserGroup" %>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>
        <g:message code="admin.groups.title"/>
    </title>
    <g:javascript>
        GMS = {};
        GMS.REMOVE_GROUP_LINK = "${createLink(controller: 'admin', action: 'deleteGroup')}";
        GMS.REMOVE_GROUP_BATCH_LINK = '${createLink(controller: "admin", action: "deleteGroupBatch")}';

        GMS.REMOVED_GROUP_MSG = "${message(code :'admin.groups.removed')}";
        GMS.REMOVED_GROUP_BATCH_MSG = "${message(code: 'admin.groups.removed.batch')}";
        GMS.REMOVE_GROUP_WARNING = "${message(code: 'admin.groups.warning')}";
        GMS.REMOVE_GROUP_BATCH_WARNING = '${message(code: "admin.groups.warning.batch")}';
    </g:javascript>
</head>

<body>
<div class="row cluster">
    <div class="row cluster-header">
        <h4><g:message code="admin.groups.title"/></h4>

        <div class="divider"></div>
    </div>

%{-- Erros e Avisos --}%
    <g:if test="${flash.message}">
        <div class="error-box row">
            <i class="material-icons tiny">error</i>
            ${flash.message}
        </div>
    </g:if>

    <div class="warning-box row show hidden">
        <div class="col s1">
            <i class="material-icons tiny no-margin">warning</i>
        </div>

        <div id="warning-box-message" class="col s7">
            <g:message code="admin.groups.warning"/> <span id="warning-group"></span> ?
        </div>

        <div class="col s4 right-align">
            <button class="btn-flat">${message(code: 'default.button.yes.label')}</button>
            <button class="btn-flat">${message(code: 'default.button.no.label')}</button>
        </div>
    </div>
%{--------------------}%

    <div class="row show">
        <div class="row no-margin">
            <div class="input-field col s3 left-align">
                <select class="pager-select">
                    %{-- Preenchido programaticamente por jquery.tablePagination.js --}%
                </select>
                <label><g:message code="admin.pager.select"/></label>
            </div>

            <div class="input-field col s8 offset-s1">
                <input type="text" id="search-group" class="remar-input" placeholder=" "/>
                <label class="active" for="search-group" id="search-group-label">
                    <g:message code="admin.groups.search"/>
                </label>
            </div>
        </div>

        <div class="row no-margin table-container">
            <div class="col s12">
                <table class="highlight">
                    <thead>
                    <tr>
                        <th class="center-align">
                            <p class="no-margin">
                                <input id="select-all-checkbox" class="filled-in" type="checkbox"/>
                                <label class="no-padding" for="select-all-checkbox"></label>
                            </p>
                        </th>

                        <th><g:message code="admin.table.header.name"/></th>
                        <th><g:message code="admin.groups.table.header.number"/></th>
                        <th class="center-align"><g:message code="admin.table.header.actions"/></th>
                    </tr>
                    </thead>

                    <tbody id="groups-table">
                    <g:each in="${groups}" status="i" var="groupInstance">
                        <tr data-group-id="${groupInstance.id}">
                            <td class="valign-wrapper">
                                <input id="group-${groupInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                <label class="no-padding" for="group-${groupInstance.id}-checkbox"></label>
                            </td>

                            <td class="group-name">${groupInstance.getName()}</td>
                            <td>${UserGroup.countByGroup(groupInstance)}</td>
                            <td class="valign-wrapper">
                                <a id="remove-group-${groupInstance.id}"
                                   class="tooltipped valign-wrapper"
                                   data-tooltip="${message(code: 'default.button.delete.label')}">
                                    <i class="material-icons">delete_forever</i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </table>
            </div>
        </div>

        <div class="row valign-wrapper">
            <div id="groups-table-buttons" class="col s3 center-align">
                <a id="batch-remove-button"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.groups.buttons.remove')}">
                    <i class="material-icons">delete</i>
                </a>
            </div>

            <div class="col s3 offset-s6">
                <ul class="pagination pager no-margin" id="groups-table-pager"></ul>
            </div>
        </div>
    </div>
</div>

<g:external dir="css" file="admin.css"/>

<g:javascript src="libs/jquery/jquery.tablePagination.js"/>
<g:javascript src="remar/admin/admin.groups.js"/>
</body>
</html>