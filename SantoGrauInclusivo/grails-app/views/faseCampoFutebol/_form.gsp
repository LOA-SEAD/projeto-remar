<%@ page import="br.ufscar.sead.loa.santograuinclusivo.remar.QuestionFaseCampoFutebol" %>


<div class="fieldcontain ${hasErrors(bean: questionFaseCampoFutebolInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="questionFaseCampoFutebol.title.label" default="Pergunta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${questionFaseCampoFutebolInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionFaseCampoFutebolInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="questionFaseCampoFutebol.answer.label" default="Resposta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="answer" required="" value="${questionFaseCampoFutebolInstance?.answer}"/>

</div>

