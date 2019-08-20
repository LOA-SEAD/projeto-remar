<%@ page import="br.ufscar.sead.loa.forca.remar.Question" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'question.resume.button.label')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'question.pause.button.label')}";
</g:javascript>
<link rel="stylesheet" type="text/css" href="/forca/css/question.css">
<!-- Formulário usado no modal de criação  -->
<div class="input-field col s12">

    <div class="col s12">
        <ul class="collapsible" data-collapsible="accordion">
            <li>
                <div class="collapsible-header active"><i class="material-icons">info</i>Informação sobre as transcrições do texto</div>
                <div class="collapsible-body">
                    <p class="justify-text">
                        As transcrições de texto tanto da pergunta quanto da resposta podem ser gravadas durante a customização ou feito o upload (carregamento) de um áudio.
                        Caso contrário, os áudios podem também serem sintetizados automaticamente.
                    <br>Deve ser escolhida uma dessas opções para cada texto.
                    </p>
                </div>
            </li>
        </ul>
    </div>
</div>


<!-- Pergunta -->
<div class="input-field col s12">
    <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150">
    <label for="statement">Pergunta</label>

    <br>
    <!-- Gravação de áudio pergunta -->
    <div class="input-field col s6">
        <div style="text-align: left">
            <h5 style="text-align: center; margin-bottom: 0.8em"><g:message code="question.audioA.label"/></h5>
            <div id="controlsA"  style="text-align: center">
                <button class="btn waves-effect waves-light remar-orange" id="recordButtonA">
                    <g:message code="question.record.button.label"/></button>
                <button class="btn waves-effect waves-light remar-orange" id="pauseButtonA" disabled="true">
                    <g:message code="question.pause.button.label"/></button>
                <button  class="btn waves-effect waves-light remar-orange" id="stopButtonA" disabled="true">
                    <g:message code="question.stop.button.label"/></button>
            </div>
        </div>

        <br>
        <div style="text-align: left">
            <h6 style="font-weight: bold"><g:message code="question.recordings.list.header"/></h6>
            <div id="recordingsListA"></div>
        </div>
    </div>

    <!-- Upload de áudio pergunta -->
    <div class="input-field col s6">
        <div class="form" style="">
            <div class="cluster-header">
                <h5>Upload de Áudio Pergunta</h5>
            </div>

            <g:uploadForm  method="POST" controller="design" action="newQuestion">
            <input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">
            <div class="row">
                <div class="col s12">
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">file_upload</i>Selecione o arquivo referente ao áudio</div>
                            <div class="collapsible-body">

                                <table style="overflow: scroll;" class="centered" id="tableNewTheme">
                                    <tr>
                                        <td id="file-input-1">
                                            <div class="file-field input-field">
                                                <div class="btn right remar-orange waves-effect waves-light">
                                                    <span>File</span>
                                                    <input data-image="true" type="file" name="audio-1" id="audio-1" class="image-input" accept="image/jpeg">
                                                </div>
                                                <div class="file-path-wrapper">
                                                    <input class="file-path validate" type="text" placeholder="Áudio (.wav, .mp3, etc.)">
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            </g:uploadForm>

        </div>
    </div>
</div>



<!-- Resposta -->
<div class="input-field col s12" style="margin-top:3.5em;">
    <input id="answer" name="answer" required="" value="${questionInstance?.answer}" type="text" class="validate remar-input" maxlength="150">
    <label for="answer">Resposta</label>

    <br>
    <!-- Gravação de áudio resposta -->
    <div class="input-field col s6">
        <div style="text-align: left">
            <h5><g:message code="question.audioB.label"/></h5>
            <div id="controlsB">
                <button class="btn waves-effect waves-light remar-orange" id="recordButtonB">
                    <g:message code="question.record.button.label"/></button>
                <button class="btn waves-effect waves-light remar-orange" id="pauseButtonB" disabled="true">
                    <g:message code="question.pause.button.label"/></button>
                <button  class="btn waves-effect waves-light remar-orange" id="stopButtonB" disabled="true">
                    <g:message code="question.stop.button.label"/></button>
            </div>
        </div>

        <br>
        <div style="text-align: left">
            <h6 style="font-weight: bold"><g:message code="question.recordings.list.header"/></h6>
            <div id="recordingsListB"></div>
        </div>
    </div>

    <!-- Upload de audio resposta -->
    <div class="input-field col s6">
        <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="75">
        <label for="statement">Fazer upload de áudio</label>
    </div>
</div>


<!-- Tema -->
<div class="input-field col s12" style="margin-top:3.5em;">
    <input id="category" name="category" required="" value="${questionInstance?.category}" type="text" class="validate remar-input">
    <label for="category">Tema</label>
</div>


<!-- Autor também é passado como informação mas pega o nome do usuário da sessão como autor -->
<div class="input-field col s12" style="display: none;">
    <input id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}" type="text" class="validate remar-input">
    <label for="author">Autor</label>
</div>

<input id="upload" type="submit" name="upload" class="btn btn-success my-orange" value="Criar"/>
