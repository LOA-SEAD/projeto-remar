<%@ page import="br.ufscar.sead.loa.santograu.remar.QuestionFaseTCC" %>



<div class="fieldcontain ${hasErrors(bean: faseTCCInstance, field: 'answers', 'error')} required">
	<label for="answers">
		<g:message code="faseTCC.answers.label" default="Answers" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: faseTCCInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="faseTCC.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${faseTCCInstance.correctAnswer}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseTCCInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="faseTCC.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${faseTCCInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseTCCInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="faseTCC.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${faseTCCInstance?.taskId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseTCCInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="faseTCC.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${faseTCCInstance?.title}"/>

</div>

