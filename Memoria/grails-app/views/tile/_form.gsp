<%@ page import="br.ufscar.sead.loa.memoria.Tile" %>

<g:if test="${edit}">
    <g:hiddenField name="id" value="${tileInstance.id}"/>
</g:if>
<div id="image-preview-table" class="row">
    <div id="preview-table-header" class="row no-margin">
        <div class="col s6">
            <p class="center-align"><g:message code="tile.create.preview"/></p>
        </div>
        <div class="col s6 center-align">
            <p class="center-align"><g:message code="tile.create.file"/></p>
        </div>
    </div>
    <div class="divider"></div>
    <div class="row no-margin">
        <div class="col s6">
            <div class="row image-preview-container">
                <div class="tile-image col no-padding s6">
                    <label><g:message code="tile.label"/> A</label>
                    <g:if test="${edit}">
                        <img id="a-preview" class="materialboxed edit"  src="${resource(dir:"/data/${tileInstance.ownerId}/${tileInstance.taskId}/tiles", file:"tile${tileInstance.id}-a.png")}" alt="${tileInstance.content} - A" width="180">
                    </g:if>
                    <g:else>
                        <img id="a-preview" class="materialboxed hidden">
                    </g:else>
                </div>
                <div class="tile-image col no-padding s6">
                    <label><g:message code="tile.label"/> B</label>
                    <g:if test="${edit}">
                        <img id="b-preview" class="materialboxed edit" src="${resource(dir:"/data/${tileInstance.ownerId}/${tileInstance.taskId}/tiles", file:"tile${tileInstance.id}-b.png")}"  alt="${tileInstance.content} - B" width="180">
                    </g:if>
                    <g:else>
                        <img id="b-preview" class="materialboxed hidden">
                    </g:else>
                </div>
            </div>
        </div>
        <div class="col s6">
            <div class="row file-field input-field">
                <div class="col s3 btn right remar-orange">
                    <span><g:message code="tile.create.fileButton"/></span>
                    <input data-image="true" type="file" name="tile-a" class="previewed-image" data-preview-target="a-preview">
                </div>
                <div class="col s9 file-path-wrapper">
                    <input ${edit ? '' : 'required'} class="file-path validate remar-input" type="text" placeholder="${message(code:'tile.create.tileA')}">
                </div>
            </div>
            <div class="row file-field input-field">
                <div class="col s3 btn right remar-orange">
                    <span><g:message code="tile.create.fileButton"/></span>
                    <input data-image="true" type="file" name="tile-b" class="previewed-image remar-input" data-preview-target="b-preview">
                </div>
                <div class="col s9 file-path-wrapper">
                    <input ${edit ? '' : 'required'} class="file-path validate remar-input" type="text" placeholder="${message(code:'tile.create.tileB')}">
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="input-field col s8 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
        <g:textField id="content" name="content" class="remar-input" maxlength="50" required="" value="${tileInstance?.content}"/>
        <label for="content">
            <g:message code="tile.content.label"/>
            <span class="required-indicator">*</span>
        </label>
    </div>

    <div class="input-field col s4 fieldcontain ${hasErrors(bean: tileInstance, field: 'difficulty', 'error')} required">
        <g:select name="difficulty" from="${tileInstance.constraints.difficulty.inList}" required="" value="${tileInstance?.difficulty}" valueMessagePrefix="tile.difficulty"/>
        <label for="difficulty">
            <g:message code="tile.difficulty.label" default="Difficulty" />
            <span class="required-indicator">*</span>
        </label>
    </div>
</div>

<div class="row">
    <div class="input-field col s12 fieldcontain ${hasErrors(bean: tileInstance, field: 'description', 'error')} required">
        <textarea id="description" class="materialize-textarea remar-input" name="description" required="" data-length="500">${tileInstance?.description}</textarea>
        <label for="description">
            <g:message code="tile.description.label"/>
            <span class="required-indicator">*</span>
        </label>
    </div>
</div>

<div class="row right-align">
    <a id="back" name="back" class="btn btn-success remar-orange">${message(code:'tile.create.backButton')}</a>

    <input id="upload" type="submit" name="upload" class="btn btn-success remar-orange" value="${message(code:'tile.create.sendButton')}"/>
</div>

<g:javascript src="form.js"/>
