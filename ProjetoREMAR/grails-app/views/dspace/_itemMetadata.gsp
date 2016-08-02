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

        <g:form action="createItem" method="POST" useToken="true">
            <div class="row">
                <div class="col s6">
                    <span class="description-input">Entre com o nome dos autores do item. </span>
                    <div class="input-field col s12">
                        <input name="author" id="author" type="text" class="validate">
                        <label for="author"><g:message code="dspace.metadata.author"/> </label>
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
                    <span class="description-input">Entre com um nome padrão de citação. </span>
                    <div class="input-field col s12">
                        <input name="citation" id="citation" type="text" class="validate">
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
                        <label for="description"><g:message code="dspace.metadata.abstract"/> </label>
                    </div>
                </div>

                <div class="col s12">
                    <span class="description-input">Entre com uma data prevista de publicação do item. </span>
                    <div class="input-field col s12">
                        <input name="publication_date" type="date" id="publication_date" class="datepicker">
                        <span id="publication_date-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                        <label for="publication_date"><g:message code="dspace.metadata.publication_date"/> </label>
                    </div>
                </div>

                <div class="col s12">
                    <span class="description-input">Entre com a licença do item. </span>
                    <div class="input-field col s12">
                        <select name="license" id="license">
                            <option value="cc-by-sa">cc-by-sa</option>
                            <option value="cc-by-nc-sa">cc-by-nc-sa</option>
                        </select>
                        <label for="license"><g:message code="dspace.metadata.license"/>:</label>
                    </div>
                </div>
                <input type="hidden" name="step" value="${step}">
                <input type="hidden" name="processId" value="${processId}">
                <input type="hidden" name="taskId" value="${taskId}">

                <div class=" col s12 m12 l12">
                    <div class="right">
                        <button class="btn my-orange" type="submit"> <g:message code="dspace.metadata.button_next"/> </button>
                    </div>
                </div>
            </div>
        </g:form>

    </div>
</div>
<script>

</script>
<g:javascript src="dspace.js"/>
<g:javascript src="dspace/validateSubmit.js"/>


</body>
</html>