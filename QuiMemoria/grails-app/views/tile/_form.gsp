<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>

<div class="row">
    <table id="image-preview-table" class="centered">
        <thead>
            <tr>
                <th><g:message code="tile.create.preview"/></th>
                <th><g:message code="tile.create.file"/></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="row image-preview-container">
                        <img id="a-preview" class="door" height="200" />
                    </div>
                </td>
                <td>
                    <div class="row file-field input-field">
                        <div class="col s2 btn right remar-orange">
                            <span><g:message code="tile.create.fileButton"/></span>
                            <input data-image="true" type="file" name="tile-a" id="tile-a">
                        </div>
                        <div class="col s10 file-path-wrapper">
                            <input required="" class="file-path validate" type="text" placeholder="${message(code:'tile.create.tileA')}">
                        </div>
                    </div>
                    <div class="row file-field input-field">
                        <div class="col s2 btn right remar-orange">
                            <span><g:message code="tile.create.fileButton"/></span>
                            <input data-image="true" type="file" name="tile-b" id="tile-b">
                        </div>
                        <div class="col s10 file-path-wrapper">
                            <input required="" class="file-path validate" type="text" placeholder="${message(code:'tile.create.tileB')}">
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div class="row">
    <div class="input-field col s8 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
        <g:textField id="content" name="content" maxlength="50" required="" value="${tileInstance?.content}"/>
        <label for="content">
            <g:message code="tile.content.label"/>
            <span class="required-indicator">*</span>
        </label>
    </div>

    <div class="input-field col s4 fieldcontain ${hasErrors(bean: tileInstance, field: 'difficulty', 'error')} required">
        <g:select name="difficulty" from="${tileInstance.constraints.difficulty.inList}" required="" value="${fieldValue(bean: tileInstance, field: 'difficulty')}" valueMessagePrefix="tile.difficulty"/>
        <label for="difficulty">
            <g:message code="tile.difficulty.label" default="Difficulty" />
            <span class="required-indicator">*</span>
        </label>
    </div>
</div>

<div class="row">
    <div class="input-field col s12 fieldcontain ${hasErrors(bean: tileInstance, field: 'description', 'error')} required">
        <textarea id="description" class="materialize-textarea" name="description" required="" length="500"></textarea>
        <label for="description">
            <g:message code="tile.description.label"/>
            <span class="required-indicator">*</span>
        </label>
    </div>
</div>

<div class="row right-align">
    <input id="upload" type="submit" name="upload" class="btn btn-success my-orange" value="${message(code:'tile.create.sendButton')}"/>
</div>

<g:external dir="css" file="tiles.css"/>
