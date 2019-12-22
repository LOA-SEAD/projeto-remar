<%@ page import="br.ufscar.sead.loa.remar.Announcement" %>

<div class="fieldcontain ${hasErrors(bean: announcement, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="announcement.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${announcement?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: announcement, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="announcement.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${announcement.constraints.type.inList}" required="" value="${announcement?.type}" valueMessagePrefix="announcement.type"/>

</div>

<div class="fieldcontain ${hasErrors(bean: announcement, field: 'body', 'error')} required">
	<label for="body">
		<g:message code="announcement.body.label" default="Body" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="body" required="" value="${announcement?.body}"/>

</div>

