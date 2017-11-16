<%@ page import="br.ufscar.sead.loa.demo.remar.Theme" %>



<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="theme.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${themeInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'processId', 'error')} required">
	<label for="processId">
		<g:message code="theme.processId.label" default="Process Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="processId" type="number" value="${themeInstance.processId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="theme.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="taskId" type="number" value="${themeInstance.taskId}" required=""/>

</div>

