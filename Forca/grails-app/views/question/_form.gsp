<%@ page import="br.ufscar.sead.loa.forca.remar.Question" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'question.resume.button.label')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'question.pause.button.label')}";
</g:javascript>
<link rel="stylesheet" type="text/css" href="/forca-acessivel/css/question.css">

<!-- Formulário de criação e edição -->
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


    <!-- Pergunta -->
    <div class="row">
        <div class="input-field col s12" style="margin-top:5em;">
            <input id="statement" name="statement" required value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="statement">Pergunta</label>
            <br>
        </div>
    </div>

    <div class="row">
        <!-- Botões de áudio pergunta -->
        <div class="input-field col s4" style="text-align: center;">
            <span>
                <input type="radio" id="audioPergunta1" name="audioPergunta" value="gravarAudio">
                <label for="audioPergunta1">
                    <a data-target="gravarModal" class="btn waves-effect waves-light remar-orange modal-trigger tooltipped" data-tooltip="Gravar um áudio novo para a pergunta">
                        Gravar Áudio
                    </a>
                </label>
            </span>
        </div>

        <div class="input-field col s4" style="text-align: center;">
            <span>
                <input type="radio" id="audioPergunta2" name="audioPergunta" value="carregarAudio">
                <label for="audioPergunta2">
                    <a data-target="carregarModal" class="btn waves-effect waves-light remar-orange modal-trigger tooltipped" data-tooltip="Carregar um áudio novo para a pergunta">
                        Carregar Áudio
                    </a>
                </label>
            </span>
        </div>

        <div class="input-field col s4" style="text-align: center;">
            <span>
                <input type="radio" id="audioPergunta3" name="audioPergunta" value="gerarAudio">
                <label for="audioPergunta3">
                    <a data-target="gerarModal" class="btn waves-effect waves-light remar-orange modal-trigger tooltipped" data-tooltip="Gerar um áudio novo para a pergunta a partir do texto escrito">
                        Gerar Áudio
                    </a>
                </label>
            </span>
        </div>
    </div>


    <!-- Resposta -->
    <div class="row">
        <div class="input-field col s12" style="margin-top:5em;">
            <input id="answer" name="answer" required value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="answer">Pergunta</label>
            <br>
        </div>
    </div>

    <div class="row">
        <!-- Botões de áudio pergunta -->
        <div class="input-field col s4" style="text-align: center;">
            <span>
                <input type="radio" id="audioResposta1" name="audioResposta" value="gravarAudio">
                <label for="audioResposta1">
                    <a data-target="gravarModal" class="btn waves-effect waves-light remar-orange modal-trigger tooltipped" data-tooltip="Gravar um áudio novo para a resposta">
                        Gravar Áudio
                    </a>
                </label>
            </span>
        </div>

        <div class="input-field col s4" style="text-align: center;">
            <span>
                <input type="radio" id="audioResposta2" name="audioResposta" value="carregarAudio">
                <label for="audioResposta2">
                    <a data-target="carregarModal" class="btn waves-effect waves-light remar-orange modal-trigger tooltipped" data-tooltip="Carregar um áudio novo para a resposta">
                        Carregar Áudio
                    </a>
                </label>
            </span>
        </div>

        <div class="input-field col s4" style="text-align: center;">
            <span>
                <input type="radio" id="audioResposta3" name="audioResposta" value="gerarAudio">
                <label for="audioResposta3">
                    <a data-target="gerarModal" class="btn waves-effect waves-light remar-orange modal-trigger tooltipped" data-tooltip="Gerar um áudio novo para a resposta a partir do texto escrito">
                        Gerar Áudio
                    </a>
                </label>
            </span>
        </div>
    </div>




    <br><br><br><br><br><br><br><br>
    <span>
        <input type="radio" id="audioPergunta1" name="audioPergunta" value="recording">
        <label for="audioPergunta1" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
            <g:message code="question.audioA.label"/>
        </label>
    </span>

    <div style="text-align: left">
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

    <!-- Upload de áudio pergunta -->
    <div class="input-field col s6" style="margin-top: -0.2em">
        <div class="form" style="">
            <div class="cluster-header">
                <span>
                    <input type="radio" id="audioPergunta2" name="audioPergunta" value="upload">
                    <label for="audioPergunta2" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Pergunta
                    </label>
                </span>
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


<!-- Resposta -->
<div class="input-field col s12" style="margin-top:5em;">
    <input id="answer" name="answer" required value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150"/>
    <label for="answer">Resposta</label>

    <br>

    <!-- Gravação de áudio resposta -->
    <div class="input-field col s6" style="text-align: center">
            <span>
                <input type="radio" id="audioResposta1" name="audioResposta" value="recording">
                <label for="audioResposta1" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                    <g:message code="question.audioB.label"/>
                </label>
            </span>
    <div style="text-align: left">

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
                <span>
                    <input type="radio" id="audioResposta2" name="audioResposta" value="upload">
                    <label for="audioResposta2" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Resposta
                    </label>
                </span>
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

    <input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">


    <input type="button" id="submit" type="submit" class="btn waves-effect waves-light remar-orange" name="Criar">
    Criar




</div>




















<!-- Modal Structure -->
<!-- Modal para quando clica "Gravar" -->
<div id="gravarModal" class="modal remar-modal">
    <div class="modal-content">
            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                <g:message code="question.audioA.label"/>
            </div>

            <div style="text-align: left">
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

    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Selecionar</button>
    </div>
</div>




<!-- Modal Structure -->
<!-- Modal para quando clica "Carregar" -->
<div id="carregarModal" class="modal remar-modal">
    <div class="modal-content">
        <div class="form" style="">
            <div class="cluster-header">
                <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Pergunta
                </div>
            </div>

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

    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Selecionar</button>
    </div>
</div>




<!-- Modal Structure -->
<!-- Modal para quando clica "Gerar" -->
<div id="gerarModal" class="modal remar-modal">
    <div class="modal-content">
        <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
            Gerar Áudio da Pergunta
        </div>



        <!-- Conteúdo da geração de áudio vai aqui -->



    </div>

    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Selecionar</button>
    </div>
</div>