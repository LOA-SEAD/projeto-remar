<%@ page import="projetoremar.Jogo" %>

<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'nome', 'error')} required">
	<label for="nome">
		<g:message code="jogo.nome.label" default="Nome" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField cam-variable-name="nome" cam-variable-type="String" name="nome" required="" value="${jogoInstance?.nome}"/>

</div>


<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'categoria', 'error')} required">
	<label for="categoria">
		<g:message code="jogo.categoria.label" default="Categoria" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="categoria" required="" value="${jogoInstance?.categoria}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'contribuicao', 'error')} required">
	<label for="contribuicao">
		<g:message code="jogo.contribuicao.label" default="Contribuicao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="contribuicao" required="" value="${jogoInstance?.contribuicao}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'palavra', 'error')} required">
	<label for="palavra">
		<g:message code="jogo.palavra.label" default="Palavra" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="palavra" required="" value="${jogoInstance?.palavra}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'dica', 'error')} required">
	<label for="dica">
		<g:message code="jogo.dica.label" default="Dica" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dica" required="" value="${jogoInstance?.dica}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'tela_inicial', 'error')} required">
	<label for="tela_inicial">
		<g:message code="jogo.tela_inicial.label" default="Telainicial" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tela_inicial" required="" value="${jogoInstance?.tela_inicial}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'tela_jogo', 'error')} required">
	<label for="tela_jogo">
		<g:message code="jogo.tela_jogo.label" default="Telajogo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tela_jogo" required="" value="${jogoInstance?.tela_jogo}"/>

</div>


<div class="fieldcontain ${hasErrors(bean: jogoInstance, field: 'icone', 'error')} required">
	<label for="icone">
		<g:message code="jogo.icone.label" default="Icone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="icone" required="" value="${jogoInstance?.icone}"/>

</div>








