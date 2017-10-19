<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoCassiano" %>


<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'information1', 'error')} required">
	<label for="information1">
		<g:message code="pergaminhoCassiano.information1.label" default="Information 1: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information1" type="text" value="${pergaminhoCassianoInstance.information[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'information2', 'error')} required">
	<label for="information2">
		<g:message code="pergaminhoCassiano.information2.label" default="Information 2: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information2" type="text" value="${pergaminhoCassianoInstance.information[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'information3', 'error')} required">
	<label for="information3">
		<g:message code="pergaminhoCassiano.information3.label" default="Information 3: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information3" type="text" value="${pergaminhoCassianoInstance.information[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'information4', 'error')} required">
	<label for="information4">
		<g:message code="pergaminhoCassiano.information4.label" default="Information 4: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information4" type="text" value="${pergaminhoCassianoInstance.information[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'information5', 'error')} required">
	<label for="information5">
		<g:message code="pergaminhoCassiano.information5.label" default="Information 5: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="information5" type="text" value="${pergaminhoCassianoInstance.information[4]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="pergaminhoCassiano.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${pergaminhoCassianoInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pergaminhoCassianoInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="pergaminhoCassiano.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${pergaminhoCassianoInstance?.taskId}"/>

</div>

