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
                <g:link class="btn my-orange" action="editListMetadata" params="[taskId: task.id]">
                    <g:message code="dspace.metadata.button_edit"/>
                </g:link>
            </div>
        </div>
        <div class="clearfix"></div>
        <g:form action="finishDataSending" method="POST" useToken="true">
            %{--<g:render template="itemMetadata" model="[task: task, resource: resource]" />--}%
            <fieldset class="preview-fieldset">
                <div class="row">
                    <p>
                        <span class="bold">Autor (es): </span>
                        <g:each in="${metadata.authors}" var="author">${author.name}; </g:each>
                    </p>
                    <p>
                        <span class="bold">Citação: </span>
                        ${metadata.citation}
                    </p>
                    <p>
                        <span class="bold">Título: </span>
                        ${metadata.title}
                    </p>
                    <p>
                        <span class="bold">Resumo: </span>
                        ${metadata.abstract}
                    </p>
                </div>
            </fieldset>

            <g:render template="bitMetadata" model="[task: task, bitstreams: metadata.bitstreams, preview: true]" />

            <div class="row">
                <div class="col s12" id="licenseImage">
                    <g:if test="${metadata.license == "cc-by-sa"}">
                        <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>
                           <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' />
                        </a>
                        <br />
                        <p> Esta obra está licenciado com uma Licença
                           <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional</a>
                            .
                        </p>
                    </g:if>
                    <g:else>
                        <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>
                            <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />
                        </a>
                        <br />
                        <p> Esta obra está licenciado com uma Licença
                            <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>
                            .
                        </p>
                    </g:else>
                </div>
            </div>

            <input type="hidden" name="taskId" value="${task.id}">
            <input type="hidden" name="metadata" value="${metadata}">

            <div class=" col s12 m12 l12">
                <div class="right">
                    <button id="cancel" class="btn my-orange" type="submit" > <g:message code="dspace.metadata.button_cancel"/> </button>
                    <button id="nextButton" class="btn my-orange" type="submit" > <g:message code="dspace.metadata.button_send"/> </button>
                </div>
            </div>
        </g:form>
    </article>
</div>
</body>
</html>