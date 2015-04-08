<%@ page import="escolamagica.Questoes" %>



<div class="fieldcontain ${hasErrors(bean: questoesInstance, field: 'alternativas', 'error')} required">
	<label for="alternativas">
		<g:message code="questoes.alternativas.label" default="Alternativa 1" />
        <span class="required-indicator">*</span>
	</label>
    <g:textField name="alternativas[0]" required=""  />

    <div>
    <br>
    <label for="alternativas">
        <g:message code="questoes.alternativas.label" default="Alternativa 2" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="alternativas[1]" required="" />
</div>

    <div>
        <br>
        <label for="alternativas">
            <g:message code="questoes.alternativas.label" default="Alternativa 3" />
            <span class="required-indicator">*</span>
        </label>
        <g:textField name="alternativas[2]" required="" />
    </div>

    <div>
        <br>
        <label for="alternativas">
            <g:message code="questoes.alternativas.label" default="Alternativa 4" />
            <span class="required-indicator">*</span>
        </label>
        <g:textField name="alternativas[3]" required="" />
    </div>
</div>

<div class="fieldcontain ${hasErrors(bean: questoesInstance, field: 'pergunta', 'error')} required">
	<label for="pergunta">
		<g:message code="questoes.pergunta.label" default="Pergunta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="pergunta" required="" value="${questoesInstance?.pergunta}"/>

</div>

