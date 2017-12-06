<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.Category" %>

<html>
<head>
    <meta name="layout" content="materialize-layout">

    <title>
        <g:message code="admin.categories.title"/>
    </title>
</head>

<body>
<div class="row cluster">
    <div class="row cluster-header">
        <h4><g:message code="admin.categories.title"/></h4>

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
            <g:message code="admin.categories.warning"/> <span id="warning-category"></span> ?
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
                <input type="text" id="search-category" class="remar-input" placeholder=" "/>
                <label class="active" for="search-category" id="search-category-label">
                    <g:message code="admin.categories.search"/>
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
                        <th class="center-align"><g:message code="admin.table.header.actions"/></th>
                    </tr>
                    </thead>

                    <tbody id="categories-table">
                    <g:each in="${categories}" status="i" var="categoryInstance">
                        <tr data-category-id="${categoryInstance.id}">
                            <td class="valign-wrapper">
                                <input id="category-${categoryInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                <label class="no-padding" for="category-${categoryInstance.id}-checkbox"></label>
                            </td>

                            <td class="category-name">${categoryInstance.getName()}</td>
                            <td class="valign-wrapper">
                                <a href="#editCategory" id="edit-category-${categoryInstance.id}"
                                   class="tooltipped valign-wrapper modal-trigger"
                                   data-tooltip="${message(code: 'default.button.edit.label')}">
                                    <i class="material-icons">mode_edit</i>
                                </a>
                                <a href="#!" id="remove-category-${categoryInstance.id}"
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
            <div id="categories-table-buttons" class="col s3 center-align">

                <a href="#addCategory" id="batch-add-button"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped modal-trigger"
                   data-tooltip="${message(code: 'admin.categories.buttons.add')}">
                    <i class="material-icons">add</i>
                </a>

                <a id="batch-remove-button"
                   class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                   data-tooltip="${message(code: 'admin.categories.buttons.remove')}">
                    <i class="material-icons">delete</i>
                </a>

            </div>

            <div class="col s3 offset-s6">
                <ul class="pagination pager no-margin" id="categories-table-pager"></ul>
            </div>
        </div>
    </div>
</div>

<div class="modal-wrapper-40">
    <div id="addCategory" class="modal remar-modal">
        <div class="modal-content">
            <h4>${message(code: 'admin.categories.create.title')}</h4>
            <div class="row">
                <div class="required input-field col s12">
                    <input id="name-category" class="remar-input validate" type="text">
                    <label for="name-category">
                        ${message(code: 'admin.categories.create.nameinput')}
                        <span class="required-indicator">*</span>
                    </label>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a id="saveCategory" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">${message(code: 'admin.categories.create.button')}</a>
        </div>
    </div>
</div>

<div class="modal-wrapper-40">
    <div id="editCategory" modal-category-id="0" class="modal remar-modal">
        <div class="modal-content">
            <h4>${message(code: 'admin.categories.edit.title')}</h4>
            <div class="row">
                <div class="required input-field col s12">
                    <input id="edit-name-category" class="remar-input validate" type="text">
                    <label for="edit-name-category">
                        ${message(code: 'admin.categories.edit.nameinput')}
                        <span class="required-indicator">*</span>
                    </label>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a id="saveEditCategory" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">${message(code: 'admin.categories.edit.button')}</a>
        </div>
    </div>
</div>

<g:external dir="css" file="admin.css"/>

<g:javascript src="libs/jquery/jquery.tablePagination.js"/>
<g:javascript src="remar/admin/admin.categories.js"/>

<g:javascript>
%{--
Este trecho de código precisa estar no .gsp por causa das mensagens de I18N
que são decodificadas pelo próprio servidor antes de renderizar a página,
enquanto que arquivos .js são interpretados pelo cliente.
--}%
    $('a[id^="remove-category"]').click(function () {
        var $row = $(this).closest('tr');
        var name = $row.children('.category-name').text();
        var id = $row.data('category-id');
        $('#warning-box-message').html(
        '${message(code: "admin.categories.warning")} <span id="warning-category">' + name + '</span> ?');
            $('.warning-box .btn-flat:first-child').unbind().click(function () {
                $.ajax({
                    url: "${createLink(controller: 'admin', action: 'deleteCategory')}",
                    type: 'post',
                    data: {id: id},
                    success: function (resp) {
                        $row.remove();
                        $('#categories-table').reloadMe();
                        Materialize.toast('${message(code :'admin.categories.removed')}', 2000);
                        $('.warning-box').slideUp(500);
                    },
                    error: function(req, res, err) {
                        Materialize.toast('${message(code :'admin.categories.notremoved')}', 2000);
                        $('.warning-box').slideUp(500);
                    }
                });
            });
            $('.warning-box').slideDown(500);
        });

        $('a#batch-remove-button').click(function() {
            $('#warning-box-message').html('${message(code: "admin.categories.warning.batch")}');
            $('.warning-box .btn-flat:first-child').unbind().click(function () {

                var categoryIdList = [];

                $('#categories-table input:checkbox:checked').closest('tr').each(function() {
                    categoryIdList.push($(this).data('category-id'));
                });


                $.ajax({
                    url: '${createLink(controller: "admin", action: "deleteCategoryBatch")}',
                    type: 'get',
                    data: {categoryIdList: JSON.stringify(categoryIdList)},
                    success: function (resp) {

                        if(resp.length > 0){
                            $('#categories-table input:checkbox:checked').closest('tr').each(function() {
                                for(i = 0; i < resp.length; i++){
                                    if($(this).data('category-id') == resp[i])
                                        $(this).remove();
                                }
                            });
                            if(resp.length == categoryIdList.length)
                                Materialize.toast('${message(code: 'admin.categories.removed.batch')}', 2000);
                            else{
                                Materialize.toast('${message(code: 'admin.categories.removed.partialBatch')}', 2000);
                            }
                        }else{
                            Materialize.toast('${message(code :'admin.categories.notremoved.batch')}', 2000);
                        }

                        $('#categories-table').reloadMe();

                        $('.warning-box').slideUp(500);
                    },
                    error: function(req, res, err) {

                        Materialize.toast('${message(code :'admin.categories.notremoved.batch')}', 2000);
                        $('.warning-box').slideUp(500);
                    }
                });
            });
            $('.warning-box').slideDown(500);
        });

        // Abrir modal para edição já com o nome da categoria
        $('a[id^="edit-category"]').click(function () {
            var $row = $(this).closest('tr');
            var id = $row.data('category-id');

            $("#edit-name-category").addClass("valid");
            $("label[for='"+$("#edit-name-category").attr('id')+"']").addClass("active");

            $("#edit-name-category").val($row.find('td').eq(1).text());
            $("#editCategory").attr("modal-category-id", id);
        });

</g:javascript>
</body>
</html>