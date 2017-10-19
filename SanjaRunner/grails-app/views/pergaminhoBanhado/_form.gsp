<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoBanhado" %>


<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'information1', 'error')} required">
	<label for="information1">
		<g:message code="pergaminhoBanhado.information1.label" default="Information 1: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information1" type="text" value="${pergaminhoBanhadoInstance.information[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'information2', 'error')} required">
	<label for="information2">
		<g:message code="pergaminhoBanhado.information2.label" default="Information 2: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information2" type="text" value="${pergaminhoBanhadoInstance.information[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'information3', 'error')} required">
	<label for="information3">
		<g:message code="pergaminhoBanhado.information3.label" default="Information 3: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information3" type="text" value="${pergaminhoBanhadoInstance.information[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoBanhadoInstance, field: 'information4', 'error')} required">
	<label for="information4">
		<g:message code="pergaminhoBanhado.information4.label" default="Information 4: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information4" type="text" value="${pergaminhoBanhadoInstance.information[3]}" required=""/>

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

