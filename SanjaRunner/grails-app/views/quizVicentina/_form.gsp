<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizVicentina" %>



<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizVicentina.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" maxlength="200" required="" value="${quizVicentinaInstance.question}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'answers1', 'error')} required">
	<label for="answers1">
		<g:message code="quizVicentina.answers1.label" default="Answers 1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers1" type="text" value="${quizVicentinaInstance.answers[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'answers2', 'error')} required">
	<label for="answers2">
		<g:message code="quizVicentina.answers2.label" default="Answers 2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers2" type="text" value="${quizVicentinaInstance.answers[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'answers3', 'error')} required">
	<label for="answers3">
		<g:message code="quizVicentina.answers3.label" default="Answers 3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers3" type="text" value="${quizVicentinaInstance.answers[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'answers4', 'error')} required">
	<label for="answers4">
		<g:message code="quizVicentina.answers4.label" default="Answers 4" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers4" type="text" value="${quizVicentinaInstance.answers[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="quizVicentina.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${quizVicentinaInstance.correctAnswer}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="quizVicentina.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${quizVicentinaInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizVicentinaInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="quizVicentina.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${quizVicentinaInstance?.taskId}"/>

</div>

