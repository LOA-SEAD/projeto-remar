<%@ page import="br.ufscar.sead.loa.respondasepuderacessivel.remar.Question" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'question.resume.button.label', default:'Continuar gravando')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'question.pause.button.label', default:'Pausar gravação')}";
    GMS.RECORDINGS_RECORD_BUTTON_LABEL = "${message(code: 'question.record.button.label', default:'Gravar')}";
    GMS.RECORDINGS_RECORDING_BUTTON_LABEL = "${message(code: 'question.recording.button.label', default:'Gravando...')}";
</g:javascript>


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
            <input id="title" name="title" required value="${questionInstance?.title}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="title">
                <span class="required-indicator">*</span>
                Pergunta
            </label>
            <br>
        </div>


        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectTitle">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarTitle">Gravar áudio (microfone)</option>
                    <option value="carregarTitle">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Alternativa 1 -->
    <div class="row">
        <div class="input-field col s9">
            <input id="answer1" name="answer1" required value="${questionInstance?.answers[0]}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="answer1">
                <span class="required-indicator">*</span>
                Texto da Alternativa 1
            </label>
            <br>
        </div>

        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectAlt1">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarAlt1">Gravar áudio (microfone)</option>
                    <option value="carregarAlt1">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Alternativa 2 -->
    <div class="row">
        <div class="input-field col s9">
            <input id="answer2" name="answer2" required value="${questionInstance?.answers[1]}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="answer2">
                <span class="required-indicator">*</span>
                Texto da Alternativa 2
            </label>
            <br>
        </div>


        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectAlt2">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarAlt2">Gravar áudio (microfone)</option>
                    <option value="carregarAlt2">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Alternativa 3 -->
    <div class="row">
        <div class="input-field col s9">
            <input id="answer3" name="answer3" required value="${questionInstance?.answers[2]}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="answer3">
                <span class="required-indicator">*</span>
                Texto da Alternativa 3
            </label>
            <br>
        </div>


        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectAlt3">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarAlt3">Gravar áudio (microfone)</option>
                    <option value="carregarAlt3">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Alternativa 4 -->
    <div class="row">
        <div class="input-field col s9">
            <input id="answer4" name="answer4" required value="${questionInstance?.answers[3]}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="answer4">
                <span class="required-indicator">*</span>
                Texto da Alternativa 4
            </label>
            <br>
        </div>

        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectAlt4">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarAlt4">Gravar áudio (microfone)</option>
                    <option value="carregarAlt4">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>


    <!-- Alternativa Correta -->
    <div class="row" style="vertical-align: middle;">
        <div class="input-field col s3" style="text-align: right;">
            Selecione a alternativa correta:
        </div>
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectRespCorreta">
                    <option value="selecione">Clique para a alterar a alternativa</option>
                    <option value="1">Alternativa 1</option>
                    <option value="2">Alternativa 2</option>
                    <option value="3">Alternativa 3</option>
                    <option value="4">Alternativa 4</option>
                </select>
            </div>
        </div>
    </div>





    <!-- Dica (hint) -->
    <div class="row">
        <div class="input-field col s9">
            <input id="hint" name="hint" required="" value="${questionInstance?.hint}" type="text" class="validate remar-input">
            <label for="hint">
                <span class="required-indicator">*</span>
                Dica
            </label>
        </div>

        <!-- select box dos audios -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectHint">
                    <g:if test="${questionInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarHint">Gravar áudio (microfone)</option>
                    <option value="carregarHint">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- ownerId e taskId -->
    <div class="input-field col s12" style="display: none;">
        <input type="hidden" id="ownerId" name="ownerId" required="" readonly="readonly" value="${questionInstance?.ownerId}" type="text" class="validate remar-input">
        <input type="hidden" id="taskId" name="taskId" required="" readonly="readonly" value="${questionInstance?.taskId}" type="text" class="validate remar-input">
        <input type="hidden" id="questionID" name="questionID" required="" readonly="readonly" value="${questionInstance?.id}" type="text" class="validate remar-input">
    </div>
</div>




<!-------------------------------------------------------------->
<!--                     Modal Structures                     -->
<div>
<div id="gravarModalTitle" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                Gravação de Áudio da Pergunta
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsTitle"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonTitle">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonTitle" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonTitle" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListTitle" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>

<div id="gravarModalAlt1" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                Gravação de Áudio do Texto da Alternativa 1
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsB"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonAlt1">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonAlt1" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonAlt1" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListAlt1" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>

<div id="gravarModalAlt2" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                Gravação de Áudio do Texto da Alternativa 2
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsB"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonAlt2">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonAlt2" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonAlt2" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListAlt2" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>

<div id="gravarModalAlt3" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                Gravação de Áudio do Texto da Alternativa 3
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsB"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonAlt3">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonAlt3" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonAlt3" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListAlt3" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>

<div id="gravarModalAlt4" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                Gravação de Áudio do Texto da Alternativa 4
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsB"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonAlt4">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonAlt4" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonAlt4" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListAlt4" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>

<div id="gravarModalHint" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6" style="text-align: center">

            <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                Gravação de Áudio da Dica
            </div>
            <div style="text-align: left">

                <!-- Botões da gravação -->
                <div id="controlsB"  style="text-align: center">
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonHint">
                        ${message(code: 'question.record.button.label', default: 'Gravar')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonHint" disabled="true">
                        ${message(code: 'question.pause.button.label', default: 'Pausar gravação')}</button>
                    <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonHint" disabled="true">
                        ${message(code: 'question.stop.button.label', default: 'Encerrar gravação')}</button>
                </div>

                <!-- Listagem das gravações feitas -->
                <br>
                <h6 style="font-weight: bold">${message(code: 'question.recordings.list.header', default: 'Gravações')}</h6>
                <div id="recordingsListHint" style="margin-bottom: 3em"></div>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>



<div id="carregarModalTitle" class="modal remar-modal">
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>

<div id="carregarModalAlt1" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
            <div class="form" style="">
                <div class="cluster-header">
                    <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Alternativa 1
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>

<div id="carregarModalAlt2" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
            <div class="form" style="">
                <div class="cluster-header">
                    <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Alternativa 2
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
                                            <input data-image="true" type="file" name="audio-3" id="audio-3" class="audio-input" accept="audio/*">
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>

<div id="carregarModalAlt3" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
            <div class="form" style="">
                <div class="cluster-header">
                    <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Alternativa 3
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
                                            <input data-image="true" type="file" name="audio-4" id="audio-4" class="audio-input" accept="audio/*">
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>

<div id="carregarModalAlt4" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
            <div class="form" style="">
                <div class="cluster-header">
                    <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio Alternativa 4
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
                                            <input data-image="true" type="file" name="audio-5" id="audio-5" class="audio-input" accept="audio/*">
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>

<div id="carregarModalHint" class="modal remar-modal">
    <div class="modal-content">
        <div class="input-field col s6">
            <div class="form" style="">
                <div class="cluster-header">
                    <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio da Dica
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
                                            <input data-image="true" type="file" name="audio-6" id="audio-6" class="audio-input" accept="audio/*">
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>


<div id="gerarModal" class="modal remar-modal">
    <div class="modal-content">
        O áudio referente ao texto será gerado automaticamente após a submissão do formulário.
        <br>
        O resultado poderá ser checado na tela de Questões.
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Ok</button>
    </div>
</div>
</div>


