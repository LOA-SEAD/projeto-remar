<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.Group" %>
<%@ page import="br.ufscar.sead.loa.remar.UserGroup" %>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>
        <g:message code="admin.groups.title"/>
    </title>
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
                                <a href="#!" id="remove-group-${groupInstance.id}"
                                   class="tooltipped valign-wrapper modal-trigger"
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
            <div id="groups-table-buttons" class="col s6 left-align">
                <a id="batch-remove-button"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.groups.buttons.remove')}">
                    <i class="material-icons">delete</i>
                </a>
            </div>

            <div class="col s6">
                <ul class="pagination pager no-margin" id="groups-table-pager"></ul>
            </div>
        </div>
    </div>
</div>

<g:external dir="css" file="admin.css"/>

<g:javascript src="libs/jquery/jquery.tablePagination.js"/>
<g:javascript src="remar/admin/admin.groups.js"/>

<g:javascript>
%{--
    Este trecho de código precisa estar no .gsp por causa das mensagens de I18N
    que são decodificadas pelo próprio servidor antes de renderizar a página,
    enquanto que arquivos .js são interpretados pelo cliente.
--}%
    $('a[id^="remove-group"]').click(function () {
        var $row = $(this).closest('tr');
        var name = $row.children('.group-name').text();
        var id = $row.data('group-id');
        $('#warning-box-message').html(
        '${message(code: "admin.groups.warning")} <span id="warning-group">' + name + '</span> ?');
            $('.warning-box .btn-flat:first-child').unbind().click(function () {
                $.ajax({
                    url: "${createLink(controller: 'admin', action: 'deleteGroup')}",
                    type: 'post',
                    data: {id: id},
                    success: function (resp) {
                        $row.remove();
                        $('#groups-table').reloadMe();
                        Materialize.toast('${message(code :'admin.groups.removed')}', 2000);
                        $('.warning-box').slideUp(500);
                    }
                });
            });
            $('.warning-box').slideDown(500);
        });

        $('a#batch-remove-button').click(function() {
            $('#warning-box-message').html('${message(code: "admin.groups.warning.batch")}');
            $('.warning-box .btn-flat:first-child').unbind().click(function () {
                var groupIdList = [];

                $('#groups-table input:checkbox:checked').closest('tr').each(function() {
                    $(this).remove();
                    groupIdList.push($(this).data('group-id'));
                });

                $.ajax({
                    url: '${createLink(controller: "admin", action: "deleteGroupBatch")}',
                    type: 'get',
                    data: {groupIdList: JSON.stringify(groupIdList)},
                    success: function (resp) {
                        $('#groups-table').reloadMe();
                        Materialize.toast('${message(code: 'admin.groups.removed.batch')}', 2000);
                        $('.warning-box').slideUp(500);
                    }
                });
            });
            $('.warning-box').slideDown(500);
        });
</g:javascript>
</body>
</html>