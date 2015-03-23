<%@ page import="projetoremar.Palavras" %>

<style type="text/css" media="screen">
input.error {
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px red;
    -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px red;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px red;
    outline: thin auto red;
}

input {
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px #7ab5d3;
    -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px #7ab5d3;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px #7ab5d3;
    outline: rgb(91, 157, 217) auto 5px;
    outline-offset: 0px;
    border: none;
}
<g:javascript src="scriptTable.js"/>
</style>

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

