<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'tile.resume.button.label', default:'Continuar gravando')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'tile.pause.button.label', default:'Pausar gravação')}";
    GMS.RECORDINGS_RECORD_BUTTON_LABEL = "${message(code: 'tile.record.button.label', default:'Gravar')}";
    GMS.RECORDINGS_RECORDING_BUTTON_LABEL = "${message(code: 'tile.recording.button.label', default:'Gravando...')}";
</g:javascript>
<g:if test="${edit}">
    <g:hiddenField name="id" value="${tileInstance.id}"/>
</g:if>

<!-- Formulário de criação e edição de peças -->
<div class="input-field col s12">
    <div class="col s12">
        <ul class="collapsible" data-collapsible="accordion">
            <li>
                <div class="collapsible-header active"><i class="material-icons">info</i>Informação sobre as transcrições do texto</div>
                <div class="collapsible-body">
                    <p class="justify-text">
                        As transcrições de texto podem ser gravadas durante a customização ou feito o upload (carregamento) de um áudio.
                        Caso contrário, os áudios podem também serem gerados automaticamente.
                        <br>Deve ser escolhida uma dessas opções para cada texto.
                    </p>
                </div>
            </li>
        </ul>
    </div>





    <!-- Primeira Carta -->
    <div class="row" style="margin-top:5em;">

        <!-- texto da primeira carta -->
        <div class="input-field col s9 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
            <input id="textA" name="textA" required value="${tileInstance?.textA}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="textA"><g:message code="tile.textA.label" default="Texto Primeira Carta"/>
                <span class="required-indicator">*</span>
            </label>
            <br>
        </div>

        <!-- select box dos audios da primeira carta -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectCartaA">
                    <g:if test="${tileInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarA">Gravar áudio (microfone)</option>
                    <option value="carregarA">Carregar arquivo (.wav)</option>
                </select>
            </div>
        </div>

    </div>

    <!-- Segunda Carta -->
    <div class="row">

        <!-- texto da segunda carta -->
        <div class="input-field col s9 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
            <input id="textB" name="textB" required value="${tileInstance?.textB}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="textB"><g:message code="tile.textB.label" default="Texto Segunda Carta"/>
                <span class="required-indicator">*</span>
            </label>
            <br>
        </div>

        <!-- select box dos audios da segunda carta -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectCartaB">
                    <g:if test="${tileInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarB">Gravar áudio (microfone)</option>
                    <option value="carregarB">Carregar arquivo (.wav)</option>
                </select>
            </div>
        </div>

    </div>

    <input type="hidden" id="tileID" name="tileID" required="" readonly="readonly" value="${tileInstance?.id}" type="text" class="validate remar-input">
</div>

<!-------------------------------------------------------------->
<!--                     Modal Structures                     -->
<div id="gravarModalA" class="modal remar-modal">
    <div class="modal-content">
        <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
            ${message(code: 'tile.audioA.label', default: 'Gravação de Áudio da Primeira Carta')}
        </div>
        <div style="text-align: left">

            <!-- Botões da gravação -->
            <div id="controlsA"  style="text-align: center">
                <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonA">
                    ${message(code: 'tile.record.button.label', default: 'Gravar')}</button>
                <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonA" disabled="true">
                    ${message(code: 'tile.pause.button.label', default: 'Pausar gravação')}</button>
                <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonA" disabled="true">
                    ${message(code: 'tile.stop.button.label', default: 'Encerrar gravação')}</button>
            </div>

            <!-- Listagem das gravações feitas -->
            <br>
            <h6 style="font-weight: bold">${message(code: 'tile.recordings.list.header', default: 'Gravações')}</h6>
            <div id="recordingsListA" style="margin-bottom: 3em"></div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>


<div id="gravarModalB" class="modal remar-modal">
    <div class="modal-content">
        <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
            ${message(code: 'tile.audioB.label', default: 'Gravação de Áudio da Segunda Carta')}</div>
        <div style="text-align: left">

            <!-- Botões da gravação -->
            <div id="controlsB"  style="text-align: center">
                <button type="button" class="btn waves-effect waves-light remar-orange" id="recordButtonB">
                    ${message(code: 'tile.record.button.label', default: 'Gravar')}</button>
            <button type="button" class="btn waves-effect waves-light remar-orange" id="pauseButtonB" disabled="true">
                ${message(code: 'tile.pause.button.label', default: 'Pausar gravação')}</button>
            <button type="button" class="btn waves-effect waves-light remar-orange" id="stopButtonB" disabled="true">
                ${message(code: 'tile.stop.button.label', default: 'Encerrar gravação')}</button>
        </div>

            <!-- Listagem das gravações feitas -->
            <br>
            <h6 style="font-weight: bold">${message(code: 'tile.recordings.list.header', default: 'Gravações')}</h6>
            <div id="recordingsListB" style="margin-bottom: 3em"></div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Selecionar</button>
    </div>
</div>


<div id="carregarModalA" class="modal remar-modal">
    <div class="modal-content">
        <div class="form" style="">
            <div class="cluster-header">
                <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                    Upload de Áudio Primeira Carta
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
                                        <input data-image="true" type="file" name="audio-1" id="audio-1" class="audio-input" accept="audio/*">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text" placeholder="Áudio (.wav)">
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
        <button type="button" class="btn waves-effect waves-light modal-close remar-orange">Enviar</button>
    </div>
</div>


<div id="carregarModalB" class="modal remar-modal">
    <div class="modal-content">
        <div class="form" style="">
            <div class="cluster-header">
                <div style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                    Upload de Áudio Segunda Carta
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
                                        <input class="file-path validate" type="text" placeholder="Áudio (.wav)">
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

