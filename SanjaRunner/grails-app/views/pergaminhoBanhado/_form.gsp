<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoBanhado" %>



<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'information', 'error')} required">
	<label for="information">
		<g:message code="pergaminhoBanhado.information.label" default="Information" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="pergaminhoBanhado.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${pergaminhoBanhadoInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="pergaminhoBanhado.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${pergaminhoBanhadoInstance?.taskId}"/>

</div>

