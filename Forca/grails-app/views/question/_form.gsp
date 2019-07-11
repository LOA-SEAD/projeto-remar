<%@ page import="br.ufscar.sead.loa.forca.remar.Question" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'question.resume.button.label')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'question.pause.button.label')}";
</g:javascript>
<link rel="stylesheet" type="text/css" href="/forca/css/question.css">
<!-- Formulário usado no modal de criação  -->

<!-- Pergunta -->
<div class="input-field col s12">
    <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150">
    <label for="statement">Pergunta</label>

<!-- Inserção de áudios para cada pergunta -->
<!-- CAMPO EM DESENVOLVIMENTO!!! -->
    <!-- Se for usar áudio gerado (text to speech)
    <div class="row">
        <p style="text-align: left; font-weight: bold">Áudio da Pergunta</p>

        <div class="input-field col s12"
            <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="75">
            <label for="statement">Usar áudio gerado</label>
        </div>
    </div>
    -->

    <div class="input-field col s6"

    <!-- copiado do memoria -->
        <div style="text-align: left">
            <h5><g:message code="question.audioA.label"/></h5>
            <div id="controlsA">
                <a class="btn waves-effect waves-light remar-orange" id="recordButton"><g:message code="question.record.button.label"/></a>
                <a class="btn waves-effect waves-light remar-orange" id="pauseButton" disabled=""><g:message code="question.pause.button.label"/></a>
                <a class="btn waves-effect waves-light remar-orange" id="stopButton" disabled=""><g:message code="question.stop.button.label"/></a>
            </div>
        </div>

        <br>
        <div style="text-align: left">
            <h6 style="font-weight: bold"><g:message code="question.recordings.list.header"/></h6>
            <div id="recordingsListA"></div>
        </div>
    </div>


    <div class="input-field col s6"
        <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="75">
        <label for="statement">Fazer upload de áudio</label>
    </div>
</div>


<br>
<!-- Resposta -->
<div class="input-field col s12">
    <input id="answer" name="answer" required="" value="${questionInstance?.answer}" type="text" class="validate remar-input"  onkeypress="validate(event)" maxlength="48">
    <label for="answer">Resposta</label>
</div>

<!-- INSERIR AQUI -->
<!-- Campos para inserção de áudio para a resposta -->

<!-- Tema -->
<div class="input-field col s12">
    <input id="category" name="category" required="" value="${questionInstance?.category}" type="text" class="validate remar-input">
    <label for="category">Tema</label>
</div>

<!-- Autor também é passado como informação mas pega o nome do usuário da sessão como autor -->
<div class="input-field col s12" style="display: none;">
    <input id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}" type="text" class="validate remar-input">
    <label for="author">Autor</label>
</div>