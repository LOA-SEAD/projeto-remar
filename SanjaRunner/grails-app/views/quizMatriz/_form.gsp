<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizMatriz" %>



<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizMatriz.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" maxlength="200" required="" value="${quizMatrizInstance.question}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'answers1', 'error')} required">
	<label for="answers1">
		<g:message code="quizMatriz.answers1.label" default="Answers 1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers1" type="text" value="${quizMatrizInstance.answers[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'answers2', 'error')} required">
	<label for="answers2">
		<g:message code="quizMatriz.answers2.label" default="Answers 2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers2" type="text" value="${quizMatrizInstance.answers[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'answers3', 'error')} required">
	<label for="answers3">
		<g:message code="quizMatriz.answers3.label" default="Answers 3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers3" type="text" value="${quizMatrizInstance.answers[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'answers4', 'error')} required">
	<label for="answers4">
		<g:message code="quizMatriz.answers4.label" default="Answers 4" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers4" type="text" value="${quizMatrizInstance.answers[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="quizMatriz.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${quizMatrizInstance.correctAnswer}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="quizMatriz.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${quizMatrizInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizMatrizInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="quizMatriz.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${quizMatrizInstance?.taskId}"/>

</div>

