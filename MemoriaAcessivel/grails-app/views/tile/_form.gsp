<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'tile.sound.resume.button.label')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'tile.sound.pause.button.label')}";
</g:javascript>
<g:if test="${edit}">
    <g:hiddenField name="id" value="${tileInstance.id}"/>
</g:if>
<!-- Inserção de áudio das cartas -->
<!-- Gravação -->
<div id="image-preview-table" class="row">
    <div class="row no-margin">
        <div class="col s6">
            <div  style="text-align: center">
                <span>
                    <input type="radio" id="audioPrimeiraCarta1" name="audioPrimeiraCarta" value="recording">
                    <label for="audioPrimeiraCarta1" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Gravação de Áudio Primeira Carta
                    </label>
                </span>

                <div id="controlsA">
                    <a class="btn waves-effect waves-light remar-orange" id="recordButtonA"><g:message code="tile.sound.record.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="pauseButtonA" disabled=""><g:message code="tile.sound.pause.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="stopButtonA" disabled=""><g:message code="tile.sound.stop.button.label"/></a>
                </div>
            </div>
            <div>
                <h6><g:message code="tile.recordings.list.header"/></h6>
                <div id="recordingsListA"></div>
            </div>
        </div>

        <div class="col s6">
            <div  style="text-align: center">
                <span>
                    <input type="radio" id="audioSegundaCarta1" name="audioSegundaCarta" value="recording">
                    <label for="audioSegundaCarta1" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Gravação de Áudio Segunda Carta
                    </label>
                </span>

                <div id="controlsB">
                    <a class="btn waves-effect waves-light remar-orange" id="recordButtonB"><g:message code="tile.sound.record.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="pauseButtonB" disabled=""><g:message code="tile.sound.pause.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="stopButtonB" disabled=""><g:message code="tile.sound.stop.button.label"/></a>
                </div>
            </div>
            <div>
                <h6><g:message code="tile.recordings.list.header"/></h6>
                <div id="recordingsListB"></div>
            </div>
        </div>
    </div>
</div>



<br>
<!-- Upload -->
<!-- não tem upload ainda pq ainda nao fiz mas ele vai ficar aqui -->
<div class="row"  style="text-align: center">
    <!-- Upload de áudio primeira carta -->
    <div class="input-field col s6">
        <div class="form" style="">
            <div class="cluster-header">
                <span>
                    <input type="radio" id="audioPrimeiraCarta2" name="audioPrimeiraCarta" value="upload">
                    <label for="audioPrimeiraCarta2" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio da Primeira Carta
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

    <!-- Upload de áudio segunda carta -->
    <div class="input-field col s6">
        <div class="form" style="">
            <div class="cluster-header">
                <span>
                    <input type="radio" id="audioSegundaCarta2" name="audioSegundaCarta" value="upload">
                    <label for="audioSegundaCarta2" style="text-align: center; font-weight: bold; font-size: large; color: black; margin-bottom: 1.2em">
                        Upload de Áudio da Segunda Carta
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


<!-- Inserção de texto das cartas -->
<div class="row">
    <div class="input-field col s6 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
        <g:textField id="textA" name="textA" class="remar-input" maxlength="50" required="" value="${tileInstance?.textA}"/>
        <label for="textA">
            <g:message code="tile.textA.label" default="Texto Primeira Carta" />
            <span class="required-indicator">*</span>
        </label>
    </div>

    <div class="input-field col s6 fieldcontain ${hasErrors(bean: tileInstance, field: 'difficulty', 'error')} required">
        <g:textField id="textB" name="textB" class="remar-input" maxlength="50" required="" value="${tileInstance?.textB}"/>
        <label for="textB">
            <g:message code="tile.textB.label" default="Texto Segunda Carta" />
            <span class="required-indicator">*</span>
        </label>
    </div>
</div>

<div class="row right-align">
    <a id="back" name="back" class="btn btn-success remar-orange">${message(code:'tile.create.backButton')}</a>

    <input id="submit" type="button" name="submit" class="btn btn-success remar-orange" value="${message(code:'tile.create.sendButton')}"/>
</div>


<g:javascript src="form.js"/>
<script src="https://cdn.rawgit.com/mattdiamond/Recorderjs/08e7abd9/dist/recorder.js"></script>
