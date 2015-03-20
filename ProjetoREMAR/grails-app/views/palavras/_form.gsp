<%@ page import="projetoremar.Palavras" %>



<div class="fieldcontain ${hasErrors(bean: palavrasInstance, field: 'resposta', 'error')} required">
	<label for="resposta">
		<g:message code="palavras.resposta.label" default="Resposta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="resposta" required="" value="${palavrasInstance?.resposta}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: palavrasInstance, field: 'dica', 'error')} required">
	<label for="dica">
		<g:message code="palavras.dica.label" default="Dica" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dica" required="" value="${palavrasInstance?.dica}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: palavrasInstance, field: 'contribuicao', 'error')} required">
	<label for="contribuicao">
		<g:message code="palavras.contribuicao.label" default="Contribuicao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="contribuicao" required="" value="${palavrasInstance?.contribuicao}"/>

</div>

