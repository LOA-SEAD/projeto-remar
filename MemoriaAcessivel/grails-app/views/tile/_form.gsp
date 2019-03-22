<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'tile.sound.resume.button.label')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'tile.sound.pause.button.label')}";
</g:javascript>
<g:if test="${edit}">
    <g:hiddenField name="id" value="${tileInstance.id}"/>
</g:if>
<div id="image-preview-table" class="row">

    <div class="row no-margin">
        <div class="col s6">
            <div>
                <h3><g:message code="tile.audioA.label"/></h3>
                <div id="controlsA">
                    <a class="btn waves-effect waves-light remar-orange" id="recordButtonA"><g:message code="tile.sound.record.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="pauseButtonA" disabled=""><g:message code="tile.sound.pause.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="stopButtonA" disabled=""><g:message code="tile.sound.stop.button.label"/></a>
                </div>
            </div>
            <div>
                <h3><g:message code="tile.recordings.list.header"/></h3>
                <div id="recordingsListA"></div>
            </div>
        </div>
        <div class="col s6">
            <div>
                <h3><g:message code="tile.audioB.label"/></h3>
                <div id="controlsB">
                    <a class="btn waves-effect waves-light remar-orange" id="recordButtonB"><g:message code="tile.sound.record.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="pauseButtonB" disabled=""><g:message code="tile.sound.pause.button.label"/></a>
                    <a class="btn waves-effect waves-light remar-orange" id="stopButtonB" disabled=""><g:message code="tile.sound.stop.button.label"/></a>
                </div>
            </div>
            <div>
                <h3><g:message code="tile.recordings.list.header"/></h3>
                <div id="recordingsListB"></div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="input-field col s8 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
        <g:textField id="textA" name="textA" class="remar-input" maxlength="50" required="" value="${tileInstance?.textA}"/>
        <label for="content">
            <g:message code="tile.textA.label" default="Texto Primeira Carta" />
            <span class="required-indicator">*</span>
        </label>
    </div>

    <div class="input-field col s4 fieldcontain ${hasErrors(bean: tileInstance, field: 'difficulty', 'error')} required">
        <g:textField id="textB" name="textB" class="remar-input" maxlength="50" required="" value="${tileInstance?.textB}"/>
        <label for="difficulty">
            <g:message code="tile.textB.label" default="Texto Segunda Carta" />
            <span class="required-indicator">*</span>
        </label>
    </div>
</div>

<div class="row right-align">
    <a id="back" name="back" class="btn btn-success remar-orange">${message(code:'tile.create.backButton')}</a>

    <input id="submit" type="button" name="submit" class="btn btn-success remar-orange" value="${message(code:'tile.create.sendButton')}"/>
</div>

<script src="https://cdn.rawgit.com/mattdiamond/Recorderjs/08e7abd9/dist/recorder.js"></script>
<g:javascript src="form.js"/>
