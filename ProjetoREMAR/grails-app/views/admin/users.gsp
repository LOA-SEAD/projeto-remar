<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<%@ page import="br.ufscar.sead.loa.remar.UserRole" %>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>
        <g:message code="admin.users.title"/>
    </title>

    <g:javascript>
        GMS = {};
        GMS.REMOVE_USER_URL = ${createLink(controller: 'admin', action: 'deleteUser')};
        GMS.EXPORT_USERS_LINK = ${createLink(controller: "admin", action: "exportUsers")}
        GMS.DISABLE_USER_BATCH_LINK = ${createLink(controller: "admin", action: "deleteUserBatch")}
        GMS.TOGGLE_DEVELOPMENT_ROLE_LINK = ${createLink(controller: 'admin', action: 'toggleUserDeveloperStatus')};
        GMS.DISABLED_USER_MSG = ${message(code:'admin.users.removed')};
        GMS.DEVELOPMENT_ROLE_ON_MSG = ${message(code: 'admin.users.developer.on')};
        GMS.DISABLED_USER_BATCH_MSG = ${message(code: 'admin.users.removed.batch')};
        GMS.DISABLE_USER_WARNING_MSG = ${message(code:"admin.users.warning")};
        GMS.DEVELOPMENT_ROLE_OFF_MSG = ${message(code: 'admin.users.developer.off')};
        GMS.DEVELOPMENT_ROLE_GRANTED_MSG = ${message(code: 'admin.users.developer.new')};
        GMS.DEVELOPMENT_ROLE_REVOKED_MSG = ${message(code: 'admin.users.developer.del')};
        GMS.DISABLE_USER_BATCH_WARNING_MSG = ${message(code: "admin.users.warning.batch")};
    </g:javascript>

</head>

<body>
    <div class="row cluster">
        <div class="row cluster-header">
            <h4><g:message code="admin.users.title"/></h4>

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
                <g:message code="admin.users.warning"/> <span id="warning-user"></span> ?
            </div>
            <div class="col s4 right-align">
                <button class="btn-flat">Sim</button>
                <button class="btn-flat">Não</button>
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
                    <input type="text" id="search-user" class="remar-input" placeholder=" "/>
                    <label class="active" for="search-user" id="search-user-label">
                        <g:message code="admin.users.search"/>
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

                                <th>
                                    <g:message code="admin.table.header.name"/>
                                </th>
                                <th>
					<g:message code="admin.users.table.header.username"/>
				</th>
				<th>
                                    <g:message code="admin.table.header.status"/>
                                </th>
                                <th class="center-align"><g:message code="admin.table.header.actions"/></th>
                            </tr>
                        </thead>

                        <tbody id="users-table">
                            <g:each in="${users}" status="i" var="userInstance">
                                <g:if test="${!userInstance.authorities.any {it.authority == 'ROLE_ADMIN'}}">
                                    <tr data-user-id="${userInstance.id}">
                                        <td class="valign-wrapper">
                                            <input id="user-${userInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                            <label class="no-padding" for="user-${userInstance.id}-checkbox"></label>
                                        </td>

                                        <td class="user-name">
                                            <a href="#!" class="user-profile" id="user-id-${userInstance.id}">
                                                ${userInstance.getName()}
                                            </a>
                                        </td>
                                        <td class="user-username"> ${userInstance.username} </td>

                                        <g:if test="${userInstance.enabled}">
                                            <td class="user-username"> <g:message code="admin.table.active"/> </td>
                                        </g:if>
                                        <g:else>
                                            <td class="user-username"> <g:message code="admin.table.inactive"/> </td>
                                        </g:else>

                                        <td class="valign-wrapper">
                                            <g:if test="${userInstance.authorities.any {it.authority == 'ROLE_DEV'}}">
                                                <a href="#!" class="tooltipped dev-toggle valign-wrapper active" data-tooltip="${message(code:'admin.users.developer.off')}">
                                                    <i class="material-icons">code</i>
                                                </a>
                                            </g:if>
                                            <g:else>
                                                <a href="#!" class="tooltipped dev-toggle valign-wrapper" data-tooltip="${message(code: 'admin.users.developer.on')}">
                                                    <i class="material-icons">code</i>
                                                </a>
                                            </g:else>
					    <g:if test="${userInstance.enabled}">
                                            	<a href="#!" id="remove-user-${userInstance.id}" class="tooltipped valign-wrapper modal-trigger"
                                               		data-tooltip="${message(code: 'default.button.block.label')}">
                                                    <i class="material-icons">lock_outline</i>
                                            	</a>
                                            </g:if>
                                            <g:else>
                                            	<a href="#!" id="remove-user-${userInstance.id}" class="tooltipped valign-wrapper modal-trigger"
                                               		data-tooltip="${message(code: 'default.button.reactivate.label')}">
                                                    <i class="material-icons">lock_open</i>
                                            	</a>
                                            </g:else>
                                        </td>
                                    </tr>
                                </g:if>
                            </g:each>
                    </table>
                </div>
            </div>
            <div class="row valign-wrapper">
                <div id="users-table-buttons" class="col s3 center-align">
                    <a id="import-button" class="btn-floating waves-effect waves-light remar-orange tooltipped"
                       data-tooltip="${message(code: 'admin.users.buttons.import')}">
                        <i class="material-icons">file_upload</i>
                    </a>

                    <a id="export-button" class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                       data-tooltip="${message(code: 'admin.users.buttons.export')}">
                        <i class="material-icons">file_download</i>
                    </a>

                    <a id="batch-remove-button" class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                       data-tooltip="${message(code: 'admin.users.buttons.remove')}">
                        <i class="material-icons">delete</i>
                    </a>
                </div>
                <div class="col s3 offset-s6">
                    <ul class="pagination pager no-margin center-align" id="users-table-pager"></ul>
                </div>
            </div>

            <div id="user-export" class="row no-margin-bottom">
                <div class="row no-margin valign-wrapper input-field center-align">
                    <div class="col s12">
                        <select id="format-select">
                            <option value="csv">Comma-separated values (.csv)</option>
                            <option value="xls">XML do Microsoft Excel 97/2000/XP/2003 (.xls)</option>
                            <option value="xlsx">XML do Microsoft Excel 2007/2010/2013 (.xlsx)</option>
                        </select>
                        <label>
                            <g:message code="admin.users.export.label"/>
                        </label>
                    </div>
                </div>

                <div class="row no-margin right">
                    <div class="col s12">
                        <a id="cancel-export" class="btn"><g:message code="default.button.cancel.label"/></a>
                        <a id="submit-export" class="btn"><g:message code="default.button.submit.label"/></a>
                    </div>
                </div>
            </div>

            <div id="user-import" class="row no-margin">
                <div class="row no-margin">
                    <div class="col s12">
                        <p class="left-align">
                            <g:message code="admin.users.import.formats"/>:
                            <strong>.csv</strong>,
                            <strong>.xls</strong>,
                            <strong>.xlsx</strong>
                        </p>
                        <p class="left-align">
                            <g:message code="admin.users.import.instructions"/>
                        </p>
                    </div>
                </div>
                <g:form action="importUsers" enctype="multipart/form-data" useToken="true">
                    <div class="row no-margin valign-wrapper">
                        <div class="col s12">
                            <div class="file-field input-field">
                                <div class="btn">
                                    <span><g:message code="default.button.file.label"/></span>
                                    <input type="file" name="spreadsheet-file">
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate" type="text">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row no-margin right">
                        <div class="col s12">
                            <a id="cancel-import" class="btn"><g:message code="default.button.cancel.label"/></a>
                            <g:submitButton name="submit" value="${message(code: 'default.button.submit.label')}" class="btn"/>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>

    <div id="userDetailsModal" class="modal" style="width:40%">
        %{-- Preenchido pelo Javascript --}%
    </div>

    <g:external dir="css" file="admin.css"/>

    <g:javascript src="libs/jquery/jquery.tablePagination.js"/>
    <g:javascript src="remar/admin/admin.users.js"/>

</body>
</html>
