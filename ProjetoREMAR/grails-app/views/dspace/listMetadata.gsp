<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

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
                Informe os dados do item que será criado no repositório.
            </blockquote>
            <g:render template="itemMetadata" model="[task: task, resource: resource]" />
            <blockquote class="left-align">
                Abaixo estão os artefatos, gerados na customização desta tarefa, que serão enviados ao repositório. Por favor,
                informe uma pequena descrição a eles.
            </blockquote>
            <g:render template="bitMetadata" model="[task: task, bitstreams: bitstreams]" />

            <div class="col s12 m12 l12">
                <span> Permitir usos comerciais do seu trabalho?</span>
                <br>
                <input onchange="showLicense()"  class="with-gap" name="comercialLicense" type="radio" id="comercialYes"/>
                <label for="comercialYes">Sim</label>
                <input onchange="showLicense()" class="with-gap" name="comercialLicense" type="radio" id="comercialNo"/>
                <label for="comercialNo">Não</label>
            </div>
            <br>
            <br>
            <input type="hidden" name="license" value="${resource.license}" id="licenseValue" >
            <div class="row">
                <div class="col s12" id="licenseImage"></div>
            </div>

            <input type="hidden" name="taskId" value="${task.id}">

            <div class=" col s12 m12 l12">
                <div class="right">
                    <button id="nextButton" class="btn my-orange hide" type="submit" > <g:message code="dspace.metadata.button_next"/> </button>
                    <a id="nextLabel" class="btn my-orange disabled" > <g:message code="dspace.metadata.button_next"/> </a>
                </div>
            </div>
        </g:form>
    </article>
</div>
</body>
</html>