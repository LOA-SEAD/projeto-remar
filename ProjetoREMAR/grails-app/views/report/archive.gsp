<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.Report" %>
<%@ page import="br.ufscar.sead.loa.remar.User" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>
        <g:message code="admin.reports.title"/>
    </title>
</head>

<body>
    <div class="row cluster">
        <div class="row cluster-header">
            <h4><g:message code="admin.reports.archived.title"/></h4>

            <div class="divider"></div>
        </div>

        <div class="warning-box row show hidden">
            <div class="col s1">
                <i class="material-icons tiny no-margin">warning</i>
            </div>

            <div id="warning-box-message" class="col s7">
                <g:message code="admin.reports.warning"/>?
            </div>

            <div class="col s4 right-align">
                <button class="btn-flat">Sim</button>
                <button class="btn-flat">Não</button>
            </div>
        </div>

        <div class="row show">
            <div class="row no-margin">
                <div class="input-field col s4 left-align">
                    <select class="pager-select">
                        %{-- Preenchido programaticamente por jquery.tablePagination.js --}%
                    </select>
                    <label><g:message code="admin.pager.select"/></label>
                </div>

                <div class="input-field col s6 offset-s1">
                    <select name="sort-reports" class="material-select">
                        <option value="0" selected><g:message code="admin.reports.date"/></option>
                        <option value="1"><g:message code="admin.reports.id"/></option>
                        <option value="2"><g:message code="admin.reports.user"/></option>
                        <option value="3"><g:message code="admin.reports.browser"/></option>
                        <option value="4"><g:message code="admin.reports.type"/></option>
                    </select>
                    <label><g:message code="admin.reports.sort"/></label>
                </div>
            </div>

            <div class="row table-container no-margin">
                <div class="col s12 no-padding">
                    <table class="highlight">
                        <thead>
                        <tr>
                            <th class="center-align">
                                <p class="no-margin">
                                    <input id="select-all-checkbox" class="filled-in" type="checkbox"/>
                                    <label class="no-padding" for="select-all-checkbox"></label>
                                </p>
                            </th>
                            <th>Id</th>
                            <th><g:message code="admin.reports.user"/></th>
                            <th><g:message code="admin.reports.date"/></th>
                            <th class="hide-on-small-only"><g:message code="admin.reports.type"/></th>
                            <th class="hide-on-small-only"><g:message code="admin.reports.browser"/></th>
                            <th class="hide-on-small-only"><g:message code="admin.reports.solved"/></th>
                            <th><g:message code="admin.table.header.actions"/></th>
                        </tr>
                        </thead>

                        <tbody id="reports-table">
                        <g:each in="${reports}" status="i" var="reportInstance">
                            <tr class="${reportInstance.seen ? 'grey-text text-darken-1' : ''}"
                                data-report-id="${reportInstance.id}">
                                <td class="center">
                                    <input id="report-${reportInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                    <label class="no-padding" for="report-${reportInstance.id}-checkbox"></label>
                                </td>
                                <td class="id-field">
                                    <a href="#!" class="hover-underlined" data-id="${reportInstance.id}">
                                        ${reportInstance.id}
                                    </a>
                                </td>
                                <td class="name-field">${reportInstance.who.getName()}</td>
                                <td class="date-field"><g:formatDate format="dd-MM-yyyy HH:mm"
                                                                     date="${reportInstance.date}"/></td>
                                <td class="type-field hide-on-small-only"><g:message
                                        code="report.type.${reportInstance.type}"/></td>
                                <td class="browser-field hide-on-small-only">${reportInstance.browser}</td>
                                <td class="solved-field hide-on-small-only" data-solved="${reportInstance.solved}">
                                    <g:if test="${reportInstance.solved}">
                                        <i class="material-icons remar-green-text">check</i>
                                    </g:if>
                                    <g:else>
                                        <i class="material-icons remar-red-text">close</i>
                                    </g:else>
                                </td>

                                <td class="action-field valign-wrapper" data-seen="${reportInstance.seen}">
                                    <a href="#!" id="remove-report-${reportInstance.id}"
                                       class="tooltipped valign-wrapper"
                                       data-tooltip="${message(code: 'default.button.delete.label')}">
                                        <i class="material-icons">delete_forever</i>
                                    </a>

                                    <a href="#!" class="tooltipped valign-wrapper unarchive-button"
                                       data-tooltip="${message(code: 'default.button.unarchive.label')}">
                                        <i class="material-icons">unarchive</i>
                                    </a>

                                    <g:if test="${reportInstance.screenshot}">
                                        <a id="screenshot-report-${reportInstance.id}" class="tooltipped valign-wrapper"
                                           href="/data/report-screenshots/${reportInstance.id}.png"
                                           download="screenshot-${message(code: 'br.ufscar.sead.loa.remar.Report')}-${reportInstance.id}.png"
                                           data-tooltip="${message(code: 'admin.reports.screenshotButton.label')}">
                                            <i class="material-icons">photo</i>
                                        </a>
                                    </g:if>
                                </td>
                            </tr>
                        </g:each>
                    </table>
                </div>
            </div>

            <div class="row valign-wrapper">
                <div id="reports-table-buttons" class="col s6 m6 l3 center-align">
                    <a id="batch-remove-button" disabled="disabled"
                       class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                       data-tooltip="${message(code: 'admin.reports.buttons.remove')}">
                        <i class="material-icons">delete</i>
                    </a>

                    <a id="batch-unarchive-button" disabled="disabled"
                       class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                       data-tooltip="${message(code: 'default.button.unarchive.label')}">
                        <i class="material-icons">unarchive</i>
                    </a>
                </div>

                <div class="col s6 m6 l3 offset-l6">
                    <ul class="pagination pager no-margin" id="reports-table-pager"></ul>
                </div>
            </div>
        </div>
    </div>

    <div id="report-information-modal" class="modal remar-modal">
        <div class="modal-content">
            <h4><g:message code="br.ufscar.sead.loa.remar.Report"/> #<strong id="modal-report-id"></strong></h4>

            <div class="row no-margin valign-wrapper">
                <div class="col s12 m6 l6 left-align">
                    <div class="row">
                        <p class="no-margin"><strong><g:message code="admin.reports.modal.sentBy"/></strong></p>

                        <p id="modal-report-user" class="no-margin-top"></p>

                        <div class="divider"></div>
                    </div>

                    <div class="row">
                        <p class="no-margin"><strong><g:message code="admin.reports.date"/></strong></p>

                        <p id="modal-report-date" class="no-margin-top"></p>

                        <div class="divider"></div>
                    </div>

                    <div class="row">
                        <p class="no-margin"><strong><g:message code="admin.reports.browser"/></strong></p>

                        <p id="modal-report-browser" class="no-margin-top"></p>

                        <div class="divider"></div>
                    </div>

                    <div class="row">
                        <p class="no-margin"><strong>URL</strong></p>

                        <p id="modal-report-url" class="no-margin-top"></p>

                        <div class="divider"></div>
                    </div>

                    <div class="row">
                        <p class="no-margin"><strong><g:message code="admin.reports.type"/></strong></p>

                        <p id="modal-report-type" class="no-margin-top"></p>

                        <div class="divider"></div>
                    </div>

                    <div class="row">
                        <p class="no-margin"><strong><g:message code="admin.reports.description"/></strong></p>

                        <p id="modal-report-description" class="no-margin-top"></p>

                        <div class="divider hide-on-med-and-up"></div>
                    </div>
                </div>

                <div id="modal-report-ss-container" class="col s12 m6 l6 center">
                    <a class="tooltipped"
                       data-tooltip="${message(code: 'admin.reports.screenshotButton.label')}">
                        <img id="modal-report-ss" class="responsive-img"/>
                    </a>

                    <a class="btn waves-effect waves-light remar-orange tooltipped hide-on-med-and-up"
                       data-tooltip="${message(code: 'admin.reports.screenshotButton.label')}">
                        Download
                    </a>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <a class="modal-action modal-close btn waves-effect waves-light remar-orange">
                <g:message code="default.button.close.label"/>
            </a>
        </div>
    </div>

    <g:external dir="css" file="admin.css"/>

    <g:javascript src="libs/jquery/jquery.tablePagination.js"/>
    <g:javascript src="libs/jquery/jquery.tableSort.js"/>
    <g:javascript src="remar/admin/admin.reports.js"/>
    <g:javascript>
        var m_adminReportsUnarchived = '${message(code: 'admin.reports.unarchived')}';
        var m_adminReportsToggleArchivedFailToast = '${message(code: 'admin.reports.toggleArchivedFail.toast')}';
        var m_adminReportsUnarchiveBatch = '${message(code: 'admin.reports.unarchive.batch')}';
    </g:javascript>
</body>
</html>