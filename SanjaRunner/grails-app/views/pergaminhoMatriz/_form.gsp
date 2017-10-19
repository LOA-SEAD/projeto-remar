<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoMatriz" %>


<div class="fieldcontain ${hasErrors(bean: pergaminhoMatrizInstance, field: 'information1', 'error')} required">
	<label for="information1">
		<g:message code="pergaminhoMatriz.information1.label" default="Information 1: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information1" type="text" value="${pergaminhoMatrizInstance.information[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoMatrizInstance, field: 'information2', 'error')} required">
	<label for="information2">
		<g:message code="pergaminhoMatriz.information2.label" default="Information 2: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information2" type="text" value="${pergaminhoMatrizInstance.information[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoMatrizInstance, field: 'information3', 'error')} required">
	<label for="information3">
		<g:message code="pergaminhoMatriz.information3.label" default="Information 3: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information3" type="text" value="${pergaminhoMatrizInstance.information[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoMatrizInstance, field: 'information4', 'error')} required">
	<label for="information4">
		<g:message code="pergaminhoMatriz.information4.label" default="Information 4: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information4" type="text" value="${pergaminhoMatrizInstance.information[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoMatrizInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="pergaminhoMatriz.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${pergaminhoMatrizInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoMatrizInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="pergaminhoMatriz.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${pergaminhoMatrizInstance?.taskId}"/>

</div>

