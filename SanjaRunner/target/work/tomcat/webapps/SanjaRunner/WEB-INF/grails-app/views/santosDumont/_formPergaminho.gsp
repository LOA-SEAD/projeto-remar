<%@ page import="sanjarunner_1.Pergaminho" %>



<div class="fieldcontain ${hasErrors(bean: pergaminhoInstance, field: 'texto', 'error')} required">
	<label for="texto">
		<g:message code="pergaminho.texto.label" default="Texto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" maxlength="40" required="" value="${pergaminhoInstance?.title}"/>

</div>


