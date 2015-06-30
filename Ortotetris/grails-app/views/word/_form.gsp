<%@ page import="br.ufscar.sead.loa.quiforca.remar.Word" %>



<div class="fieldcontain ${hasErrors(bean: wordInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="word.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="answer" pattern="${wordInstance.constraints.answer.matches}" required="" value="${wordInstance?.answer}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: wordInstance, field: 'word', 'error')} required">
	<label for="word">
		<g:message code="word.word.label" default="Word" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="word" required="" value="${wordInstance?.word}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: wordInstance, field: 'initial_position', 'error')} required">
	<label for="initial_position">
		<g:message code="word.initial_position.label" default="Initialposition" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="initial_position" type="number" value="${wordInstance.initial_position}" required=""/>

</div>

