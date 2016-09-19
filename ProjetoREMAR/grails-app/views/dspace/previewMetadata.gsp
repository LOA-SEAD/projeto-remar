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
        <h5>
            Por favor, revise seus dados antes de finalizar!
        </h5>
    </div>

    <article class="width-position">
        <div class=" col s12">
            <div class="right">
                <a id="editMetadata" class="btn my-orange" href="#!"> <g:message code="dspace.metadata.button_edit"/> </a>
            </div>
        </div>
        <div class="clearfix"></div>
        <g:form action="finishDataSending" method="POST" useToken="true">
            <g:render template="itemMetadata" model="[task: task, resource: resource]" />
            <g:render template="bitMetadata" model="[task: task, bitstreams: metadata.bitstreams, metadata: metadata]" />

            <input type="hidden" name="license" value="${metadata.license}" id="licenseValue" >
            <g:if test="${metadata.license == "cc-by-sa"}">
                <div class="col s12 m12 l12">
                    <span> Permitir usos comerciais do seu trabalho?</span>
                    <br>
                    <input onchange="showLicense()"  class="with-gap" name="comercialLicense" type="radio" id="comercialYes" checked/>
                    <label for="comercialYes">Sim</label>
                    <input onchange="showLicense()" class="with-gap" name="comercialLicense" type="radio" id="comercialNo" disabled/>
                    <label for="comercialNo">Não</label>
                </div>
                <br>
                <br>
                <div class="row">
                    <div class="col s12" id="licenseImage">
                        <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>
                            <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' />
                        </a>
                        <br />
                        <p> Esta obra está licenciado com uma Licença
                            <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional</a>
                            .
                        </p>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col s12 m12 l12">
                    <span> Permitir usos comerciais do seu trabalho?</span>
                    <br>
                    <input onchange="showLicense()"  class="with-gap" name="comercialLicense" type="radio" id="comercialYes" disabled/>
                    <label for="comercialYes">Sim</label>
                    <input onchange="showLicense()" class="with-gap" name="comercialLicense" type="radio" id="comercialNo" checked/>
                    <label for="comercialNo">Não</label>
                </div>
                <br>
                <br>
                <div class="row">
                    <div class="col s12" id="licenseImage">
                        <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>
                            <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />
                        </a>
                        <br />
                        <p> Esta obra está licenciado com uma Licença
                            <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>
                            .
                        </p>
                    </div>
                </div>
            </g:else>

            <input type="hidden" name="taskId" value="${task.id}">

            <div class=" col s12 m12 l12">
                <div class="right">
                    <button id="nextButton" class="btn my-orange hide" type="submit" > <g:message code="dspace.metadata.button_finish"/> </button>
                    <a id="nextLabel" class="btn my-orange disabled" > <g:message code="dspace.metadata.button_finish"/> </a>
                </div>
            </div>
        </g:form>
    </article>
</div>
</body>
</html>