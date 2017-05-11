<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="materialize-layout">
    <title>Adicionar metadados</title>
</head>
<body>
<div class="row cluster">
    <aside>
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom title-page">
            <i class="medium material-icons left">cloud_upload</i>Adicionar Metadados
        </p>
        <div class="divider"></div>
        <div class="clearfix"></div>
    </aside>
    <div class="subtitle space">
        <h3 class="text-teal text-darken-3 center truncate">
            ${task.definition.name}
        </h3>
    </div>

    <article class="width-position">
        <g:form action="previewMetadata" method="POST" useToken="true">
            <blockquote class="left-align">
                Informe os metadados do item que será criado no repositório.
            </blockquote>
            <g:if test="${metadata != null}">
                <g:render template="itemMetadata" model="[task: task, resource: resource, metadata: metadata]" />
            </g:if>
            <g:else>
                <g:render template="itemMetadata" model="[task: task, resource: resource]" />
            </g:else>

            <blockquote class="left-align">
                Abaixo estão os arquivos que serão enviados ao repositório.
            </blockquote>

            <g:if test="${metadata != null}">
                <g:render template="bitMetadata" model="[task: task, bitstreams: metadata.bitstreams]"/>
            </g:if>
            <g:else>
                <g:render template="bitMetadata" model="[task: task, bitstreams: bitstreams]" />
            </g:else>

            <div class="col s12 m12 l12">
                <span style="display: inline-flex;">
                    <p style="margin: 0px;"></p> Permitir que adaptações do seu trabalho sejam compartilhadas?</p>
                    <i class="material-icons tooltipped cursor-pointer valign" data-tooltip="Mais informações" onclick="openThisModal('modalShareAsLike')">info</i>
                </span>
            </div>
            <div>
                <input class="with-gap" name="shareGame" type="radio" id="shareYes" disabled checked="checked"/>
                <label for="shareYes" >Sim, desde que outros compartilhem igual <span class="required-indicator">*</span></label>
            </div>
            <br><br>

            <div class="col s12 m12 l12">
                <span> Permitir usos comerciais do seu trabalho?</span>
                <br>
                <input onchange="showLicense()"  class="with-gap" name="comercialLicense" type="radio" id="comercialYes"/>
                <label for="comercialYes">Sim</label>
                <input onchange="showLicense()" class="with-gap" name="comercialLicense" type="radio" id="comercialNo"/>
                <label for="comercialNo">Não</label>
            </div>
            <br><br><br>

            <input type="hidden" name="license" value="${resource.license}" id="licenseValue" >
            <div class="row">
                <div class="col s12" id="licenseImage"></div>
            </div>

            <input type="hidden" name="taskId" value="${task.id}">

            <div class=" col s12 m12 l12">
                <div class="right">
                    <button id="nextButton" class="btn my-orange hide" type="submit" > <g:message code="dspace.metadata.button_send"/> </button>
                    <a id="nextLabel" class="btn my-orange disabled" > <g:message code="dspace.metadata.button_send"/> </a>
                </div>
            </div>
        </g:form>
    </article>
</div>
<g:javascript src="dspace/validateSubmit.js"/>
<g:javascript src="dspace/item.js"/>
</body>
</html>