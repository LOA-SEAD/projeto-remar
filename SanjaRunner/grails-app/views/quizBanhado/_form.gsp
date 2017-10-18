<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizBanhado" %>



<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizBanhado.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" maxlength="200" required="" value="${quizBanhadoInstance.question}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'answers1', 'error')} required">
	<label for="answers1">
		<g:message code="quizBanhado.answers1.label" default="Answers 1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers1" type="text" value="${quizBanhadoInstance.answers[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'answers2', 'error')} required">
	<label for="answers2">
		<g:message code="quizBanhado.answers2.label" default="Answers 2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers2" type="text" value="${quizBanhadoInstance.answers[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'answers3', 'error')} required">
	<label for="answers3">
		<g:message code="quizBanhado.answers3.label" default="Answers 3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers3" type="text" value="${quizBanhadoInstance.answers[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizBanhadoInstance, field: 'answers4', 'error')} required">
	<label for="answers4">
		<g:message code="quizBanhado.answers4.label" default="Answers 4" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers4" type="text" value="${quizBanhadoInstance.answers[3]}" required=""/>

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

