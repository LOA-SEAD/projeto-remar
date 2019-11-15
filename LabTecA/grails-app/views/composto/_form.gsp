<%@ page import="br.ufscar.sead.loa.labteca.remar.Composto" %>



<div class="fieldcontain ${hasErrors(bean: compostoInstance, field: 'formula', 'error')} required">
	<label for="formula">
		<g:message code="composto.formula.label" default="Formula" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="formula" required="" value="${compostoInstance?.formula}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: compostoInstance, field: 'tipo', 'error')} required">
	<label for="tipo">
		<g:message code="composto.tipo.label" default="Tipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="tipo" from="${compostoInstance.constraints.tipo.inList}" required="" value="${compostoInstance?.tipo}" valueMessagePrefix="composto.tipo"/>

</div>

<div class="fieldcontain ${hasErrors(bean: compostoInstance, field: 'nome', 'error')} required">
	<label for="nome">
		<g:message code="composto.nome.label" default="Nome" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nome" required="" value="${compostoInstance?.nome}"/>

</div>

