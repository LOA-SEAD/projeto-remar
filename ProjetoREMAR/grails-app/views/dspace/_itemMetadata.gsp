<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Adicionar metadados</title>
</head>
<body>
<div class="row cluster">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom title-page">
            <i class="medium material-icons left">cloud_upload</i>Adicionar Metadados
        </p>
        <div class="divider"></div>
        <div class="clearfix"></div>
        <div class="right">
            <span>1/2</span>
        </div>
        <div class="progress my-orange-opaque">
            <div class="determinate my-orange" style="width: 50%"></div>
        </div>

        <div class="subtitle space">
            <h3 class="text-teal text-darken-3 center truncate">
                ${task.definition.name}
            </h3>
            <h5 class="center date">
                Criar um item
            </h5>
        </div>

        %{--<div class="row center">--}%
            %{--<p>--}%
                %{--Abaixo estão listadas as tarefas realizadas durante a customização do jogo. Selecione as tarefas que--}%
                %{--gostaria de enviar para o repositório.--}%
            %{--</p>--}%
        %{--</div>--}%

        <g:form action="createItem" method="POST" useToken="true">
            <div class="row">
                <div class="col s12 div-author">
                    <span class="description-input">Entre com o nome do autor do item. </span>
                    <div class="input-field col s12">
                        <input name="author" id="author" type="text" class="validate" value="${session.user.firstName}">
                        <span id="author-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                        <label for="author">
                            <g:message code="dspace.metadata.author"/>
                        </label>
                    </div>
                    <div class="right">
                        <span class="btn my-orange" id="add-author">adicionar autor</span>
                    </div>
                </div>

                <div class="col s12">
                    <span class="description-input">Entre com um nome padrão de citação. </span>
                    <div class="input-field col s12">
                        <input name="citation" id="citation" type="text" class="validate">
                        <span id="citation-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                        <label for="citation"><g:message code="dspace.metadata.citation"/> </label>
                    </div>
                </div>

                <div class="col s12">
                    <span class="description-input">Entre com o título item. </span>
                    <div class="input-field col s12">
                        <input name="title" id="title" type="text" class="">
                        <span id="title-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                        <label for="title"><g:message code="dspace.metadata.title"/> </label>
                    </div>
                </div>

                <div class="col s12">
                    <span class="description-input">Entre com o resumo do item. </span>
                    <div class="input-field col s12">
                        <textarea name="description" id="description" class="materialize-textarea"></textarea>
                        <span id="description-error" class="invalid-textarea" style="left: 0.75rem;">Este campo não pode ser vazio!</span>
                        <label for="description"><g:message code="dspace.metadata.abstract"/> </label>
                    </div>
                </div>

                %{--<div class="col s12 " style="display: none;">--}%
                    %{--<span class="description-input">Entre com uma data prevista de publicação do item. </span>--}%
                    %{--<div class="input-field col s12">--}%
                        %{--<input name="publication_date" type="hidden" id="publication_date" class="datepicker">--}%
                        %{--<span id="publication_date-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>--}%
                        %{--<label for="publication_date"><g:message code="dspace.metadata.publication_date"/> </label>--}%
                    %{--</div>--}%
                %{--</div>--}%

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
                <input type="hidden" name="license" value="cc-by" id="licenseValue" >
                <div class="row">
                    <div class="col s12" id="licenseImage">

                    </div>
                </div>

                <input type="hidden" name="taskId" value="${task.id}">

                <div class=" col s12 m12 l12">
                    <div class="right">
                        <button id="nextButton" class="btn my-orange hide" type="submit" > <g:message code="dspace.metadata.button_next"/> </button>
                        <a id="nextLabel" class="btn my-orange disabled" > <g:message code="dspace.metadata.button_next"/> </a>
                    </div>
                </div>
            </div>
        </g:form>

    </div>
</div>
<g:javascript src="dspace.js"/>
<g:javascript src="dspace/validateSubmit.js"/>


</body>
</html>