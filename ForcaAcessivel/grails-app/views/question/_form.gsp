<%@ page import="br.ufscar.sead.loa.forcaacessivel.remar.Question" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'question.resume.button.label', default:'Continuar gravando')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'question.pause.button.label', default:'Pausar gravação')}";
    GMS.RECORDINGS_RECORD_BUTTON_LABEL = "${message(code: 'question.record.button.label', default:'Gravar')}";
    GMS.RECORDINGS_RECORDING_BUTTON_LABEL = "${message(code: 'question.recording.button.label', default:'Gravando...')}";
</g:javascript>
<link rel="stylesheet" type="text/css" href="/forca_acessivel/css/question.css">

<!-- Formulário de criação e edição -->
<div class="input-field col s12">
    <div class="col s12">
        <ul class="collapsible" data-collapsible="accordion">
            <li>
                <div class="collapsible-header active"><i class="material-icons">info</i>Informação sobre as transcrições do texto</div>
                <div class="collapsible-body">
                    <p class="justify-text">
                        As transcrições de texto tanto da pergunta quanto da resposta podem ser gravadas durante a customização ou feito o upload (carregamento) de um áudio.
                        Caso contrário, os áudios podem também serem gerados automaticamente.
                    <br>Deve ser escolhida uma dessas opções para cada texto.
                    </p>
                </div>
            </li>
        </ul>
    </div>



    <!-- Pergunta -->
    <div class="row" style="margin-top:5em;">
        <div class="input-field col s9">
            <input id="statement" name="statement" required value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="statement">
                <span class="required-indicator">*</span>
                Pergunta
            </label>
            <br>
        </div>


        <!-- select box dos audios -->
        <div class="input-field col s3">
             <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectPergunta">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarA">Gravar áudio (microfone)</option>
                    <option value="carregarA">Carregar arquivo (.wav, etc)</option>
                </select>
             </div>
        </div>
    </div>




    <!-- Resposta -->
    <div class="row">
        <div class="input-field col s9">
            <input id="answer" name="answer" required value="${questionInstance?.answer}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="answer">
                <span class="required-indicator">*</span>
                Resposta
            </label>
            <br>
        </div>

        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectResposta">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarB">Gravar áudio (microfone)</option>
                    <option value="carregarB">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>



    <!-- Tema -->
    <div class="row">
        <div class="input-field col s12">
            <input id="category" name="category" required="" value="${questionInstance?.category}" type="text" class="validate remar-input">
            <label for="category">
                <span class="required-indicator">*</span>
                Tema
            </label>
        </div>
    </div>



    <!-- Autor também é passado como informação mas pega o nome do usuário da sessão como autor -->
    <div class="input-field col s12" style="display: none;">
        <input type="hidden" id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}" type="text" class="validate remar-input">
        <label for="author">Autor</label>
        <input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">
        <input type="hidden" id="questionID" name="questionID" required="" readonly="readonly" value="${questionInstance?.id}" type="text" class="validate remar-input">
    </div>


</div>




<!--
    <button id="ocultar">Ocultar o conteúdo</button>
    <p id="exemplo1">Conteúdo que vai ser ocultado</p>

-->



<!-------------------------------------------------------------->
<!--                     Modal Structures                     -->
<div id="gravarModalA" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                ${message(code: 'question.audioA.label', default: 'Gravação de Áudio da Pergunta')}
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsA"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonA">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonA" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonA" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListA" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close my-orange">Selecionar</button>
    </div>
</div>


<div id="gravarModalB" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                ${message(code: 'question.audioB.label', default: 'Gravação de Áudio da Resposta')}
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsB"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonB">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonB" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonB" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListB" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close my-orange">Selecionar</button>
    </div>
</div>


<div id="carregarModalA" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
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
                                            <span>Arquivo</span>
                                            <input data-image="true" type="file" name="audio-1" id="audio-1" class="audio-input" accept="audio/mpeg">
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

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close my-orange">Enviar</button>
    </div>
</div>


<div id="carregarModalB" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
            <div class="form" style="">
                <div class="cluster-header">
                    <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Resposta
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
                                            <span>Arquivo</span>
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

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close my-orange">Enviar</button>
    </div>
</div>


<div id="gerarModal" class="modal remar-modal">
    <div class="modal-content">
        O áudio referente ao texto será gerado automaticamente após a submissão do formulário.
        <br>
        O resultado poderá ser checado na tela de Questões.
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close my-orange">Ok</button>
    </div>
</div>



