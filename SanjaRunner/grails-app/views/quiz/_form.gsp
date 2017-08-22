<%@ page import="sanjarunner_1.Quiz" %>



<div class="fieldcontain ${hasErrors(bean: quizInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="quiz.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" maxlength="40" required="" value="${quizInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizInstance, field: 'answers', 'error')} required">
	<label for="answers">
		<g:message code="quiz.answers.label" default="Answers" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: quizInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="quiz.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${quizInstance.correctAnswer}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="quiz.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${quizInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="quiz.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${quizInstance?.taskId}"/>

</div>

