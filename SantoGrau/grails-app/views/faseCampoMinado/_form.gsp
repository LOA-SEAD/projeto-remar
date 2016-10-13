<%@ page import="br.ufscar.sead.loa.santograu.remar.QuestionFaseCampoMinado" %>


<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="faseCampoMinado.title.label" default="Pergunta: " />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${faseCampoMinadoInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'answers1', 'error')} required">
	<label for="answers1">
		<g:message code="faseCampoMinado.answers1.label" default="Answer 1: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers1" type="text" value="${faseCampoMinadoInstance.answers[0]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'answers2', 'error')} required">
	<label for="answers2">
		<g:message code="faseCampoMinado.answers2.label" default="Answer 2: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers2" type="text" value="${faseCampoMinadoInstance.answers[1]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'answers3', 'error')} required">
	<label for="answers3">
		<g:message code="faseCampoMinado.answers3.label" default="Answer 3: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers3" type="text" value="${faseCampoMinadoInstance.answers[2]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'answers4', 'error')} required">
	<label for="answers4">
		<g:message code="faseCampoMinado.answers4.label" default="Answer 4: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers4" type="text" value="${faseCampoMinadoInstance.answers[3]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'answers5', 'error')} required">
	<label for="answers5">
		<g:message code="faseCampoMinado.answers5.label" default="Answer 5: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="answers5" type="text" value="${faseCampoMinadoInstance.answers[4]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseCampoMinadoInstance, field: 'correctAnswer', 'error')} required">
	<label for="correctAnswer">
		<g:message code="faseCampoMinado.correctAnswer.label" default="Resposta correta: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctAnswer" type="number" value="${faseCampoMinadoInstance.correctAnswer}" required=""/>

</div>



