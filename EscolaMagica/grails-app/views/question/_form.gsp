<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="question.title.label" default="Pergunta" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${questionInstance?.title}"/>

</div>


<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'answers', 'error')} required">
	<label for="answers">
		<g:message code="question.answers.label" default="Alternativa 1" />
		<span class="required-indicator">*</span>
	</label>
    <g:textField name="answers[0]" required=""/> <input type="radio" value="0" name="correctAnswer" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'answers', 'error')} required">
    <label for="answers">
        <g:message code="question.answers.label" default="Alternativa 2" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="answers[1]" required=""/> <input type="radio" value="1" name="correctAnswer" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'answers', 'error')} required">
    <label for="answers">
        <g:message code="question.answers.label" default="Alternativa 3" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="answers[2]" required=""/> <input type="radio" value="2" name="correctAnswer" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'answers', 'error')} required">
    <label for="answers">
        <g:message code="question.answers.label" default="Alternativa 4" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="answers[3]" required=""/> <input type="radio" value="3" name="correctAnswer" />


</div>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'level', 'error')} required">
    <label for="level">
        <g:message code="question.level.label" default="Classe" />
        <span class="required-indicator">*</span>
    </label>
    <g:select name="level" from="${questionInstance.constraints.level.inList}" required="" value="${questionInstance?.level}" valueMessagePrefix="question.level"/>

</div>

