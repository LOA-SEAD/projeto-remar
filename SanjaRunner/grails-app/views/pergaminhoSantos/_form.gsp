<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoSantos" %>


<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'information1', 'error')} required">
	<label for="information1">
		<g:message code="pergaminhoSantos.information1.label" default="Information 1: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information1" type="text" value="${pergaminhoSantosInstance.information[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'information2', 'error')} required">
	<label for="information2">
		<g:message code="pergaminhoSantos.information2.label" default="Information 2: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information2" type="text" value="${pergaminhoSantosInstance.information[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'information3', 'error')} required">
	<label for="information3">
		<g:message code="pergaminhoSantos.information3.label" default="Information 3: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information3" type="text" value="${pergaminhoSantosInstance.information[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'information4', 'error')} required">
	<label for="information4">
		<g:message code="pergaminhoSantos.information4.label" default="Information 4: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information4" type="text" value="${pergaminhoSantosInstance.information[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'information5', 'error')} required">
	<label for="information5">
		<g:message code="pergaminhoSantos.information5.label" default="Information 5: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information5" type="text" value="${pergaminhoSantosInstance.information[4]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="pergaminhoSantos.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${pergaminhoSantosInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoSantosInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="pergaminhoSantos.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${pergaminhoSantosInstance?.taskId}"/>

</div>

