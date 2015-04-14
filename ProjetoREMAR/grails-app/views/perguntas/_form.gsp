<%@ page import="escolamagica.Perguntas" %>


<fieldset id="alternativas">
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
    <g:textField name="resp[0]" required="" /> <input type="radio" name="respCorreta" value="0" />

</div>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 2" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[1]" required="" /> <input type="radio" name="respCorreta" value="1" />

</div>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 3" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[2]" required="" /> <input type="radio" name="respCorreta" value="2"  />

</div>

<div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'resp', 'error')} required">
    <label for="resp">
        <g:message code="perguntas.resp.label" default="Alternativa 4" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="resp[3]" required="" /> <input type="radio" name="respCorreta" value="3" />

</div>

    <div class="fieldcontain ${hasErrors(bean: perguntasInstance, field: 'classe', 'error')} required">
        <label for="classe">
            <g:message code="perguntas.classe.label" default="Classe da Turma" />
            <span class="required-indicator">*</span>
        </label>
        <g:select name="classe" from="${perguntasInstance.constraints.classe.inList}" required="" value="${perguntasInstance?.classe}" valueMessagePrefix="perguntas.classe"/>

    </div>


</div>
</fieldset>
