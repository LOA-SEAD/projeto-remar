<%@ page import="escolamagica.Perguntas" %>



<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'titulo', 'error')} required">
    <label for="titulo">
        <g:message code="perguntas.titulo.label" default="Titulo" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="titulo" required="" value="${perguntasInstance?.titulo}"/>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 1" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[0]" required="" /> <g:checkBox name="alt0" value="${false}" />

</div>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 2" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[1]" required="" /> <g:checkBox name="alt1" value="${false}" />

</div>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 3" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[2]" required="" /> <g:checkBox name="alt2" value="${false}" />

</div>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 4" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[3]" required="" /> <g:checkBox name="alt3" value="${false}" />

</div>

    <div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'classe', 'error')} required">
        <label for="classe">
            <g:message code="perguntas.classe.label" default="Classe da Turma" />
            <span class="required-indicator">*</span>
        </label>
        <g:select name="classe" from="${perguntasInstance.constraints.classe.inList}" required="" value="${perguntasInstance?.classe}" valueMessagePrefix="perguntas.classe"/>

    </div>


</div>

