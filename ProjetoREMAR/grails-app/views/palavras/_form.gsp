<%@ page import="projetoremar.Palavras" %>

<g:javascript src="scriptTable.js"/>
<div class="fieldcontain ${hasErrors(bean: palavrasInstance, field: 'resposta', 'error')} required">
	<label for="resposta">
		<g:message code="palavras.resposta.label" default="Resposta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="error" placeholder="Resposta da pergunta" name="resposta" required="" value="${palavrasInstance?.resposta}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: palavrasInstance, field: 'dica', 'error')} required">
	<label for="dica">
		<g:message code="palavras.dica.label" default="Dica" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="" placeholder="Dica da pergunta" name="dica" required="" value="${palavrasInstance?.dica}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: palavrasInstance, field: 'contribuicao', 'error')} required">
	<label for="contribuicao">
		<g:message code="palavras.contribuicao.label" default="Contribuicao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="" placeholder="Nome do contribuidor" name="contribuicao" required="" value="${palavrasInstance?.contribuicao}"/>

</div>

