<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.QuizCassiano" %>



<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizCassiano.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" maxlength="200" required="" value="${quizCassianoInstance.question}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'answers1', 'error')} required">
	<label for="answers1">
		<g:message code="quizCassiano.answers1.label" default="Answers 1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers1" type="text" value="${quizCassianoInstance.answers[0]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'answers2', 'error')} required">
	<label for="answers2">
		<g:message code="quizCassiano.answers2.label" default="Answers 2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers2" type="text" value="${quizCassianoInstance.answers[1]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'answers3', 'error')} required">
	<label for="answers3">
		<g:message code="quizCassiano.answers3.label" default="Answers 3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers3" type="text" value="${quizCassianoInstance.answers[2]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'answers4', 'error')} required">
	<label for="answers4">
		<g:message code="quizCassiano.answers4.label" default="Answers 4" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers4" type="text" value="${quizCassianoInstance.answers[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="quizCassiano.correctAnswer.label" default="Correct Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${quizCassianoInstance.correctAnswer}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="quizCassiano.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${quizCassianoInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: quizCassianoInstance, field: 'taskId', 'error')} required">
	<label for="taskId">
		<g:message code="quizCassiano.taskId.label" default="Task Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taskId" required="" value="${quizCassianoInstance?.taskId}"/>

</div>

