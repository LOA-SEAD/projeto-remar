<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizBanhado" %>



<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizBanhado.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" maxlength="200" required="" value="${quizBanhadoInstance?.question}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'answers', 'error')} required">
	<label for="answers">
		<g:message code="quizBanhado.answers.label" default="Answers" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="quizBanhado.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${quizBanhadoInstance.correctAnswer}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="quizBanhado.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${quizBanhadoInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="quizBanhado.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${quizBanhadoInstance?.taskId}"/>

</div>

