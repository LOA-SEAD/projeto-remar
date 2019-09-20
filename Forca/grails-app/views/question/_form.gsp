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
<div class="input-field col s12" style="margin-top:5em;">
    <input id="statement" name="statement" required value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150"/>
    <label for="statement">Pergunta</label>

    <br>

    <!-- Gravação de áudio pergunta -->
    <div class="input-field col s6">
        <div style="text-align: left">
            <input type="radio" name="pergunta-record" value="oioioi"/>
            <h5 style="text-align: center; margin-bottom: 0.8em"><g:message code="question.audioA.label"/></h5>

            <!-- Botões da gravação -->
            <div id="controlsA"  style="text-align: center">
                <button class="btn waves-effect waves-light remar-orange" id="recordButtonA">
                    <g:message code="question.record.button.label"/></button>
                <button class="btn waves-effect waves-light remar-orange" id="pauseButtonA" disabled="true">
                    <g:message code="question.pause.button.label"/></button>
                <button  class="btn waves-effect waves-light remar-orange" id="stopButtonA" disabled="true">
                    <g:message code="question.stop.button.label"/></button>
            </div>

            <!-- Listagem das gravações feitas -->
            <br>
            <h6 style="font-weight: bold"><g:message code="question.recordings.list.header"/></h6>
            <div id="recordingsListA" style="margin-bottom: 3em;"></div>
        </div>
    </div>

    <!-- Upload de áudio pergunta -->
    <div class="input-field col s6">
        <div class="form" style="">
            <div class="cluster-header">
                <h5>Upload de Áudio Pergunta</h5>
            </div>

            <input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">

            <div class="row">
                <div class="col s12">
                    <ul class="collapsible" data-collapsible="accordion">
                    <li>
                        <div class="collapsible-header active"><i class="material-icons">file_upload</i>Selecione o arquivo referente ao áudio</div>
                        <div class="collapsible-body">
                            <div class="file-field input-field">
                                <div class="btn right remar-orange waves-effect waves-light">
                                    <span>File</span>
                                    <input data-image="true" type="file" name="audio-1" id="audio-1" class="audio-input" accept="audio/*">
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate" type="text" placeholder="Áudio (.wav, .mp3, etc.)">
                                </div>
                            </div>
                        </div>
                    </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Resposta -->
<div class="input-field col s12" style="margin-top:5em;">
    <input id="answer" name="answer" required value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150"/>
    <label for="answer">Resposta</label>

    <br>

    <!-- Gravação de áudio resposta -->
    <div class="input-field col s6">
        <div style="text-align: left">
            <h5 style="text-align: center; margin-bottom: 0.8em"><g:message code="question.audioB.label"/></h5>

            <!-- Botões da gravação -->
            <div id="controlsA"  style="text-align: center">
                <button class="btn waves-effect waves-light remar-orange" id="recordButtonB">
                    <g:message code="question.record.button.label"/></button>
                <button class="btn waves-effect waves-light remar-orange" id="pauseButtonB" disabled="true">
                    <g:message code="question.pause.button.label"/></button>
                <button  class="btn waves-effect waves-light remar-orange" id="stopButtonB" disabled="true">
                    <g:message code="question.stop.button.label"/></button>
            </div>

            <!-- Listagem das gravações feitas -->
            <br>
            <h6 style="font-weight: bold"><g:message code="question.recordings.list.header"/></h6>
            <div id="recordingsListB" style="margin-bottom: 3em"></div>
        </div>
    </div>

    <!-- Upload de áudio resposta -->
    <div class="input-field col s6">
        <div class="form" style="">
            <div class="cluster-header">
                <h5>Upload de Áudio Resposta</h5>
            </div>

            <input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">

            <div class="row">
                <div class="col s12">
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">file_upload</i>Selecione o arquivo referente ao áudio</div>
                            <div class="collapsible-body">
                                <div class="file-field input-field">
                                    <div class="btn right remar-orange waves-effect waves-light">
                                        <span>File</span>
                                        <input data-image="true" type="file" name="audio-2" id="audio-2" class="audio-input" accept="audio/*">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text" placeholder="Áudio (.wav, .mp3, etc.)">
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Tema -->
<div class="input-field col s12" style="margin-top:3em;">
    <input id="category" name="category" required="" value="${questionInstance?.category}" type="text" class="validate remar-input">
    <label for="category">Tema</label>
</div>


<!-- Autor também é passado como informação mas pega o nome do usuário da sessão como autor -->
<div class="input-field col s12" style="display: none;">
    <input id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}" type="text" class="validate remar-input">
    <label for="author">Autor</label>
</div>




<!-- <input id="upload" type="submit" name="upload" class="btn btn-success my-orange upload" value="Criar"/> -->
