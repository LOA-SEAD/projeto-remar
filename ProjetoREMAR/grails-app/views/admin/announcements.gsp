<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.ufscar.sead.loa.remar.Announcement" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <g:set var="entityName" value="${message(code: 'announcement.label', default: 'Anúncio')}" />
    <title><g:message code="admin.table.title" args="[entityName]"/></title>
</head>

<body>
    <g:javascript>
        GMS = {};
        GMS.SAVE_URL                        = "${createLink(controller: 'admin', action: 'saveAnnouncement')}";
        GMS.EDIT_URL                        = "${createLink(controller: 'admin', action: 'editAnnouncement')}";
        GMS.DELETE_URL                      = "${createLink(controller: 'admin', action: 'deleteAnnouncement')}";
        GMS.DELETE_BATCH_URL                = "${createLink(controller: 'admin', action: 'deleteAnnouncementBatch')}";

        GMS.SAVED_MESSAGE                   = "${message(code: 'admin.announcements.created')}";
        GMS.REMOVED_MESSAGE                 = "${message(code: 'admin.announcements.removed')}";
        GMS.NOT_REMOVED_MESSAGE             = "${message(code: 'admin.announcements.notremoved')}";
        GMS.BATCH_REMOVED_MESSAGE           = "${message(code: 'admin.announcements.removed.batch')}";
        GMS.NOT_REMOVED_BATCH_MESSAGE       = "${message(code: 'admin.announcements.notremoved.batch')}";
        GMS.PARTIALLY_REMOVED_BATCH_MESSAGE = "${message(code: 'admin.announcements.removed.partialBatch')}";
    </g:javascript>

    <div class="row cluster">
        <div class="row cluster-header">
            <h4><g:message code="admin.table.title" args="[entityName]"/></h4>

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
                <g:message code="admin.announcements.warning"/> <span id="warning-announcements"></span> ?
            </div>

            <div class="col s4 right-align">
                <button class="btn-flat"><g:message code="default.boolean.true"/></button>
                <button class="btn-flat"><g:message code="default.boolean.false"/></button>
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
                    <input type="text" id="search-announcement" class="remar-input" placeholder=" "/>
                    <label class="active" for="search-announcement" id="search-announcement-label">
                        <g:message code="admin.search.label" args="[entityName]"/>
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
                                <g:message code="admin.table.header.title"/>
                            </th>
                            <th>
                                <g:message code="admin.table.header.type"/>
                            </th>
                            <th class="center-align">
                                <g:message code="admin.table.header.actions"/>
                            </th>
                        </tr>
                        </thead>

                        <tbody id="announcements-table">
                        <g:each in="${announcements}" status="i" var="announcementInstance">
                            <tr data-announcement-id="${announcementInstance.id}">
                                <td class="valign-wrapper">
                                    <input id="announcement-${announcementInstance.id}-checkbox" class="filled-in" type="checkbox"/>
                                    <label class="no-padding" for="announcement-${announcementInstance.id}-checkbox"></label>
                                </td>

                                <td class="announcement-name">
                                    ${announcementInstance.getTitle()}
                                </td>
                                <td class="announcement-name">
                                    ${announcementInstance.getType()}
                                </td>
                                <td class="valign-wrapper">
                                    <a href="#editAnnouncement" id="edit-announcement-${announcementInstance.id}"
                                       class="tooltipped valign-wrapper modal-trigger"
                                       data-tooltip="${message(code: 'default.button.edit.label')}">
                                        <i class="material-icons">mode_edit</i>
                                    </a>
                                    <a href="#!" id="remove-announcement-${announcementInstance.id}"
                                       class="tooltipped valign-wrapper"
                                       data-tooltip="${message(code: 'default.button.delete.label')}">
                                        <i class="material-icons">delete_forever</i>
                                    </a>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row valign-wrapper">
                <div id="announcements-table-buttons" class="col s3 center-align">

                    <a href="#addAnnouncement" id="batch-add-button"
                       class="btn-floating waves-effect waves-light remar-orange tooltipped modal-trigger"
                       data-tooltip="${message(code:'default.create.label', args: [entityName])}">
                        <i class="material-icons">add</i>
                    </a>

                    <a id="batch-remove-button"
                       class="btn-floating waves-effect waves-light remar-orange tooltipped toggleable"
                       data-tooltip="${message(code: 'admin.announcements.buttons.remove')}">
                        <i class="material-icons">delete</i>
                    </a>

                </div>

                <div class="col s3 offset-s6">
                    <ul class="pagination pager no-margin" id="announcements-table-pager"></ul>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-wrapper-40">
        <div id="addAnnouncement" class="modal remar-modal">
            <div class="modal-content">
                <h4>
                    <g:message code="default.create.label" args="[entityName]"/>
                </h4>
                <div class="row">
                    <div class="required input-field col s12">
                        <g:textField id="title-announcement" name="title" required="" value="${announcement?.title}" class="remar-input validate"/>
                        <label for="title-announcement">
                            <g:message code="announcement.title.label" default="Título" />
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="required input-field col s12">
                        <g:textField id="body-announcement" name="body" required="" value="${announcement?.body}" class="remar-input validate"/>
                        <label for="body-announcement">
                            <g:message code="announcement.body.label" default="Corpo" />
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="required input-field col s12">
                        <g:select id="type-announcement" name="type" from="${Announcement.constraints.type.inList}" required="" value="${announcement?.type}" class="remar-input validate" valueMessagePrefix="announcement.type"/>
                        <label for="type-announcement">
                            <g:message code="announcement.type.label" default="Tipo" />
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="saveAnnouncement" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">
                    <g:message code='default.create.label' args="[entityName]"/>
                </a>
            </div>
        </div>
    </div>

    <div class="modal-wrapper-40">
        <div id="editAnnouncement" modal-announcement-id="0" class="modal remar-modal">
            <div class="modal-content">
                <h4>${message(code: 'default.edit.label', args: [entityName])}</h4>
                <div class="row">
                    <div class="required input-field col s12">
                        <input id="edit-title-announcement" class="remar-input validate" type="text">
                        <label for="edit-title-announcement">
                            <g:message code='admin.announcements.edit.nameinput'/>
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="required input-field col s12">
                        <g:textField id="edit-body-announcement" name="body" required="" value="${announcement?.body}" class="remar-input validate"/>
                        <label for="edit-body-announcement">
                            <g:message code="announcement.body.label" default="Corpo" />
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="saveEditAnnouncement" href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">
                    <g:message code='default.edit.label' args="[entityName]"/>
                </a>
            </div>
        </div>
    </div>

<g:javascript src="libs/jquery/jquery.tablePagination.js"/>
<g:javascript src="remar/admin/admin.announcements.js"/>

</body>
</html>
