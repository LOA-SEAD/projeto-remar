<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.Report" %>
<%@ page import="br.ufscar.sead.loa.remar.User" %>

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
        <h4><g:message code="admin.reports.title"/></h4>

        <div class="divider"></div>
    </div>

    %{-- Erros e Avisos --}%
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
    %{--------------------}%

    <div class="row show">
        <div class="row no-margin">
            <div class="input-field col s4 left-align">
                <select class="pager-select">
                    %{-- Preenchido programaticamente por jquery.tablePagination.js --}%
                </select>
                <label><g:message code="admin.pager.select"/></label>
            </div>

            <div class="input-field col s6 offset-s1 hide-on-small-only">
                <select name="sort-reports" class="material-select">
                    <option value="1" selected><g:message code="admin.reports.date"/></option>
                    <option value="2"><g:message code="admin.reports.user"/></option>
                    <option value="3"><g:message code="admin.reports.browser"/></option>
                    <option value="4"><g:message code="admin.reports.type"/></option>
                    <option value="5"><g:message code="admin.reports.seen"/></option>
                    <option value="6"><g:message code="admin.reports.notseen"/></option>
                    <option value="7"><g:message code="admin.reports.solved"/>s</option>
                    <option value="8"><g:message code="admin.reports.notsolved"/></option>
                </select>
                <label><g:message code="admin.reports.sort"/></label>
            </div>

            <div class="input-field col s6 offset-s1 hide-on-med-and-up">
                <select name="sort-reports" class="material-select">
                    <option value="1" selected><g:message code="admin.reports.date"/></option>
                    <option value="2"><g:message code="admin.reports.user"/></option>
                    <option value="5"><g:message code="admin.reports.seen"/></option>
                    <option value="6"><g:message code="admin.reports.notseen"/></option>
                </select>
                <label><g:message code="admin.reports.sort"/></label>
            </div>
        </div>

        <div class="row table-container">
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
                        <tr class="${reportInstance.seen ? 'grey-text text-darken-1' : ''}" data-report-id="${reportInstance.id}">
                            <td class="valign-wrapper">
                                <input id="report-${reportInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                <label class="no-padding" for="report-${reportInstance.id}-checkbox"></label>
                            </td>
                            <td class="id-field"><a href="#!" class="hover-underlined">${reportInstance.id}</a></td>
                            <td>${reportInstance.who.getName()}</td>
                            <td><g:formatDate format="dd-MM-yyyy HH:mm" date="${reportInstance.date}"/></td>
                            <td class="hide-on-small-only"><g:message code="report.type.${reportInstance.type}"/></td>
                            <td class="hide-on-small-only">${reportInstance.browser}</td>
                            <td class="solved-status-field hide-on-small-only">
                                <g:if test="${reportInstance.solved}">
                                    <i class="material-icons remar-green-text">check</i>
                                </g:if>
                                <g:else>
                                    <i class="material-icons remar-red-text">close</i>
                                </g:else>
                            </td>

                            <td class="valign-wrapper">
                                <a href="#!" class="tooltipped valign-wrapper seen-toggle ${reportInstance.seen ? 'active' : ''}"
                                   data-tooltip="${message(code: reportInstance.seen ? 'admin.reports.markAsUnseenButton.label' : 'admin.reports.markAsSeenButton.label')}">
                                    <i class="fa fa-eye fa-lg"></i>
                                </a>

                                <a href="#!" class="tooltipped valign-wrapper solved-toggle ${reportInstance.solved ? 'active' : ''}"
                                   data-tooltip="${message(code: reportInstance.solved ? 'admin.reports.markAsUnsolvedButton.label' : 'admin.reports.markAsSolvedButton.label')}">
                                    <i class="material-icons">check</i>
                                </a>

                                <a href="#!" id="remove-report-${reportInstance.id}"
                                   class="tooltipped valign-wrapper"
                                   data-tooltip="${message(code: 'default.button.delete.label')}">
                                    <i class="material-icons">delete_forever</i>
                                </a>

                                <g:if test="${reportInstance.screenshot}">
                                    <a id="screenshot-report-${reportInstance.id}" class="tooltipped valign-wrapper"
                                       href="/data/report-screenshots/${reportInstance.id}.png" download="screenshot-entrada-${reportInstance.id}.png"
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
            <div id="reports-table-buttons" class="col s3 center-align">
                <a id="batch-remove-button" disabled="disabled"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.reports.buttons.remove')}">
                    <i class="material-icons">delete</i>
                </a>

                <a id="batch-markAsSeen-button" disabled="disabled"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.reports.buttons.markAsSeen')}">
                    <i class="fa fa-eye fa-2x"></i>
                </a>

                <a id="batch-markAsUnseen-button" disabled="disabled"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.reports.buttons.markAsUnseen')}">
                    <i class="fa fa-eye-slash fa-2x"></i>
                </a>

                <a id="batch-markAsSolved-button" disabled="disabled"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.reports.buttons.markAsSolved')}">
                    <i class="material-icons">check</i>
                </a>

                <a id="batch-markAsUnsolved-button" disabled="disabled"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.reports.buttons.markAsUnsolved')}">
                    <i class="material-icons">close</i>
                </a>
            </div>

            <div class="col s3 offset-s6">
                <ul class="pagination pager no-margin" id="reports-table-pager"></ul>
            </div>
        </div>
    </div>
</div>

<div id="report-information" class="modal">
    <div class="modal-content">
        <h4>Header</h4>
        <p>Content</p>
    </div>
    <div class="modal-footer">
        <a class="modal-action modal-close btn waves-effect waves-light remar-orange">
            <g:message code="default.button.close.label"/>
        </a>
    </div>
</div>

<g:external dir="css" file="admin.css"/>

<g:javascript src="libs/jquery/jquery.tablePagination.js"/>
<g:javascript src="remar/admin/admin.reports.js"/>

<g:javascript>
%{--
    Este trecho de código precisa estar no .gsp por causa das mensagens de I18N
    que são decodificadas pelo próprio servidor antes de renderizar a página,
    enquanto que arquivos .js são interpretados pelo cliente.
--}%
    $('a[id^="remove-report"]').click(function () {
        var $row = $(this).closest('tr');
        var id = $row.data('report-id');
        var warningMessage = '${message(code: "admin.reports.warning")}&nbsp;<strong>' + id + '</strong>?' ;

        $('#warning-box-message').html(warningMessage);
        $('.warning-box .btn-flat:first-child').unbind().click(function () {
            $.ajax({
                url: "${createLink(controller: 'admin', action: 'deleteReport')}",
                type: 'post',
                data: {id: id},
                success: function (resp) {
                    $row.remove();
                    $('#reports-table').reloadMe();
                    Materialize.toast('${message(code: 'admin.reports.removed')}', 2000);
                    $('.warning-box').slideUp(500);
                }
            });
        });
        $('.warning-box').slideDown(500);
    });

    $('a#batch-remove-button').click(function() {
        $('#warning-box-message').html('${message(code: "admin.reports.warning.batch")}');
        $('.warning-box .btn-flat:first-child').unbind().click(function () {
            var reportIdList = [];

            $('#reports-table input:checkbox:checked').closest('tr').each(function() {
                $(this).remove();
                reportIdList.push($(this).data('report-id'));
            });

            $.ajax({
                url: '${createLink(controller: "admin", action: "deleteReportBatch")}',
                type: 'get',
                data: {reportIdList: JSON.stringify(reportIdList)},
                success: function (resp) {
                    $('#reports-table').reloadMe();
                    Materialize.toast('${message(code: 'admin.reports.removed.batch')}', 2000);
                    $('.warning-box').slideUp(500);
                }
            });
        });
        $('.warning-box').slideDown(500);
    });

    $('.seen-toggle', '#reports-table').click(function() {
        var $button = $(this);
        var $row = $(this).closest('tr');
        var id = $row.data('report-id');

        $.ajax({
            url: "${createLink(controller: 'report', action: 'toggleSeenStatus')}",
            type: 'post',
            data: {id: id},
            success: function (resp) {
                if (resp == 'seen') {
                    $row.addClass('grey-text text-darken-1');
                    $button.addClass('active');
                    Materialize.toast('${message(code: 'admin.reports.markedAsSeen.toast')}', 2000);
                } else if (resp == 'unseen') {
                    $row.removeClass('grey-text text-darken-1');
                    $button.removeClass('active');
                    Materialize.toast('${message(code: 'admin.reports.markedAsUnseen.toast')}', 2000);
                }
            },
            error: function (xhr, text, error) {
                if (xhr.status == 422)
                    Materialize.toast('${message(code: 'admin.reports.toggleSeenFail.toast')}', 2000);
            }
        });
    });

    $('.solved-toggle', '#reports-table').click(function() {
        var $button = $(this);
        var $row = $(this).closest('tr');
        var $statusField = $row.find('.solved-status-field');
        var id = $row.data('report-id');

        $.ajax({
            url: "${createLink(controller: 'report', action: 'toggleSolvedStatus')}",
            type: 'post',
            data: {id: id},
            success: function (resp) {
                if (resp == 'solved') {
                    $row.addClass('grey-text text-darken-1');
                    $button.addClass('active');
                    $statusField.fadeOut(function() {
                        $statusField.html('<i class="material-icons remar-green-text">check</i>');
                        $statusField.fadeIn();
                    });
                    Materialize.toast('${message(code: 'admin.reports.markedAsSolved.toast')}', 2000);
                } else if (resp == 'unsolved') {
                    $button.removeClass('active');
                    $statusField.fadeOut(function() {
                        $statusField.html('<i class="material-icons remar-red-text">close</i>');
                        $statusField.fadeIn();
                    });
                    Materialize.toast('${message(code: 'admin.reports.markedAsUnsolved.toast')}', 2000);
                }
            },
            error: function (xhr, text, error) {
                if (xhr.status == 422)
                    Materialize.toast('${message(code: 'admin.reports.toggleSolvedFail.toast')}', 2000);
            }
        });
    });
</g:javascript>
</body>
</html>