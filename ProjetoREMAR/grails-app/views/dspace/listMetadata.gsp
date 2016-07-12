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
        <g:form action="listMetadata">
            <div class="row">
            <div class="col s6">
                <span class="description-input">Entre com o nome dos autores do item. </span>
                <div class="input-field col s12">
                    <input name="author" id="author" type="text" class="validate">
                    <label for="author"><g:message code="dspace.metadata.author"/> </label>
                    %{--<span id="email-error" class="">Digite um email no formato nome@exemplo.com</span>--}%
                </div>
            </div>

            <div class="col s6">
                <span class="description-input">Entre com o nome dos editores do item. </span>
                <div class="input-field col s12">
                    <input name="editor" id="editor" type="text" class="validate">
                    <label for="editor"><g:message code="dspace.metadata.editor"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com o título item. </span>
                <div class="input-field col s12">
                    <input name="title" id="title" type="text" class="validate">
                    <label for="title"><g:message code="dspace.metadata.title"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com o resumo do item. </span>
                <div class="input-field col s12">
                    <textarea name="abstract" id="abstract" class="materialize-textarea"></textarea>
                    <label for="abstract"><g:message code="dspace.metadata.abstract"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com uma data prevista de publicação do item. </span>
                <div class="input-field col s12">
                    <input name="date" type="date" id="date" class="datepicker">
                    <label for="date"><g:message code="dspace.metadata.date_publication"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com uma data prevista de publicação do item. </span>
                <div class="input-field col s12">
                    <select name="license" id="license">
                        %{--<option value="" disabled selected>Choose your option</option>--}%
                        <option value="cc-by-sa">cc-by-sa</option>
                        <option value="cc-by-nc-sa">cc-by-nc-sa</option>
                    </select>
                    <label for="license"><g:message code="dspace.metadata.license"/>:</label>
                </div>
            </div>
                <input type="hidden" name="step" value="1">
                <div class=" col s12 m12 l12">
                    <div class="right">
                        <button class="btn my-orange" type="submit"> <g:message code="dspace.metadata.button_next"/> </button>
                    </div>
                </div>
        </div>
        </g:form>
    </div>
</div>
<g:javascript src="dspace.js"/>
</body>
</html>