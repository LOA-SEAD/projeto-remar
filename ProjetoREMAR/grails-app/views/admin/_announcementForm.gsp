<%@ page import="br.ufscar.sead.loa.remar.Announcement" %>
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