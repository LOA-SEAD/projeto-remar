<%@ page import="br.ufscar.sead.loa.santograuinclusivo.remar.QuestionFaseBiblioteca" %>



<div class="fieldcontain ${hasErrors(bean: questionFaseBibliotecaInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="questionFaseBiblioteca.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="answer" required="" value="${questionFaseBibliotecaInstance?.answer}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionFaseBibliotecaInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="questionFaseBiblioteca.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${questionFaseBibliotecaInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionFaseBibliotecaInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="questionFaseBiblioteca.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${questionFaseBibliotecaInstance?.taskId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionFaseBibliotecaInstance, field: 'tips', 'error')} required">
	<label for="tips">
		<g:message code="questionFaseBiblioteca.tips.label" default="Tips" />
		<span class="required-indicator">*</span>
	</label>
	

</div>


