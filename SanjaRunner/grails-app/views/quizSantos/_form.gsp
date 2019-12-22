<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizSantos" %>



<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizSantos.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" maxlength="200" required="" value="${quizSantosInstance.question}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'answers1', 'error')} required">
	<label for="answers1">
		<g:message code="quizSantos.answers1.label" default="Answers 1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers1" type="text" value="${quizSantosInstance.answers[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'answers2', 'error')} required">
	<label for="answers2">
		<g:message code="quizSantos.answers2.label" default="Answers 2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers2" type="text" value="${quizSantosInstance.answers[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'answers3', 'error')} required">
	<label for="answers3">
		<g:message code="quizSantos.answers3.label" default="Answers 3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers3" type="text" value="${quizSantosInstance.answers[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'answers4', 'error')} required">
	<label for="answers4">
		<g:message code="quizSantos.answers4.label" default="Answers 4" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers4" type="text" value="${quizSantosInstance.answers[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="quizSantos.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${quizSantosInstance.correctAnswer}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="quizSantos.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${quizSantosInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizSantosInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="quizSantos.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${quizSantosInstance?.taskId}"/>

</div>

