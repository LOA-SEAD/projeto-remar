<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.ExportedResource" %>

<html>
<head>
    <meta name="layout" content="materialize-layout">

    <title>
        <g:message code="admin.games.title"/>
    </title>
</head>

<body>
<div class="row cluster">
    <div class="row cluster-header">
        <h4><g:message code="admin.games.title"/></h4>

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
            <g:message code="admin.games.warning"/> <span id="warning-game"></span> ?
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

            <div class="input-field col s2 offset-s1">
                <select id="search-select" class="material-select">
                    <option value="game"><g:message code="admin.games.search.game"/></option>
                    <option value="author"><g:message code="admin.games.search.author"/></option>
                    <option value="resource"><g:message code="admin.games.search.resource"/></option>
                </select>
                <label><g:message code="admin.games.search.type"/></label>
            </div>

            <div class="input-field col s5">
                <input type="text" id="search-game" class="remar-input" placeholder=" "/>
                <label class="active" for="search-game" id="search-game-label">
                    <g:message code="admin.games.search"/>
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
                        <th><g:message code="admin.table.header.resource"/></th>
                        <th><g:message code="admin.table.header.author"/></th>
                        <th class="center-align"><g:message code="admin.table.header.actions"/></th>
                    </tr>
                    </thead>

                    <tbody id="games-table">
                    <g:each in="${games}" status="i" var="gameInstance">
                        <tr data-game-id="${gameInstance.id}">
                            <td class="valign-wrapper">
                                <input id="game-${gameInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                <label class="no-padding" for="game-${gameInstance.id}-checkbox"></label>
                            </td>
                            <td class="game-name">${gameInstance.getName()}</td>
                            <td class="resource-name">${gameInstance.resource.getName()}</td>
                            <td class="author-name">${gameInstance.owner.getName()}</td>
                            <td class="valign-wrapper">
                                <a href="#!" id="remove-game-${gameInstance.id}"
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
            <div id="games-table-buttons" class="col s6 center-align">

                <a id="batch-remove-button"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.games.buttons.remove')}">
                    <i class="material-icons">delete</i>
                </a>

            </div>

            <div class="col s3 offset-s6">
                <ul class="pagination pager no-margin" id="games-table-pager"></ul>
            </div>
        </div>
    </div>
</div>

<g:external dir="css" file="admin.css"/>

<g:javascript src="libs/jquery/jquery.tablePagination.js"/>
<g:javascript src="remar/admin/admin.games.js"/>

<g:javascript>
%{--
Este trecho de código precisa estar no .gsp por causa das mensagens de I18N
que são decodificadas pelo próprio servidor antes de renderizar a página,
enquanto que arquivos .js são interpretados pelo cliente.
--}%
    $('a[id^="remove-game"]').click(function () {
        var $row = $(this).closest('tr');
        var name = $row.children('.game-name').text();
        var id = $row.data('game-id');
        $('#warning-box-message').html(
        '${message(code: "admin.games.warning")} <span id="warning-game">' + name + '</span> ?');
            $('.warning-box .btn-flat:first-child').unbind().click(function () {
                $.ajax({
                    url: "${createLink(controller: 'admin', action: 'deleteGame')}",
                    type: 'post',
                    data: {id: id},
                    success: function (resp) {
                        $row.remove();
                        $('#games-table').reloadMe();
                        Materialize.toast('${message(code :'admin.games.removed')}', 2000);
                        $('.warning-box').slideUp(500);
                    }
                });
            });
            $('.warning-box').slideDown(500);
        });

        $('a#batch-remove-button').click(function() {
            $('#warning-box-message').html('${message(code: "admin.games.warning.batch")}');
            $('.warning-box .btn-flat:first-child').unbind().click(function () {
                var gameIdList = [];

                $('#games-table input:checkbox:checked').closest('tr').each(function() {
                    $(this).remove();
                    gameIdList.push($(this).data('game-id'));
                });

                $.ajax({
                    url: '${createLink(controller: "admin", action: "deleteGameBatch")}',
                    type: 'get',
                    data: {gameIdList: JSON.stringify(gameIdList)},
                    success: function (resp) {
                        $('#games-table').reloadMe();
                        Materialize.toast('${message(code: 'admin.games.removed.batch')}', 2000);
                        $('.warning-box').slideUp(500);
                    }
                });
            });
            $('.warning-box').slideDown(500);
        });

</g:javascript>
</body>
</html>