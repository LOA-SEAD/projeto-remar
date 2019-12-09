<%@ page import="br.ufscar.sead.loa.santograuacessivel.remar.QuestionFaseBlocoGelo" %>



<div class="fieldcontain ${hasErrors(bean: faseBlocoGeloInstance, field: 'answers', 'error')} required">
	<label for="answers">
		<g:message code="faseBlocoGelo.answers.label" default="Answers" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: faseBlocoGeloInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="faseBlocoGelo.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${faseBlocoGeloInstance.correctAnswer}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseBlocoGeloInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="faseBlocoGelo.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${faseBlocoGeloInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseBlocoGeloInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="faseBlocoGelo.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${faseBlocoGeloInstance?.taskId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseBlocoGeloInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="faseBlocoGelo.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${faseBlocoGeloInstance?.title}"/>

</div>

