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
        <div class="row">
            <div class="col s6">
                <span class="description-input">Entre com o nome dos autores do item. </span>
                <div class="input-field col s12">
                    <input id="author" type="text" class="validate">
                    <label for="author"><g:message code="dspace.metadata.author"/> </label>
                    %{--<span id="email-error" class="">Digite um email no formato nome@exemplo.com</span>--}%
                </div>
            </div>

            <div class="col s6">
                <span class="description-input">Entre com o nome dos editores do item. </span>
                <div class="input-field col s12">
                    <input id="editor" type="text" class="validate">
                    <label for="editor"><g:message code="dspace.metadata.editor"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com o título item. </span>
                <div class="input-field col s12">
                    <input id="title" type="text" class="validate">
                    <label for="title"><g:message code="dspace.metadata.title"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com o resumo do item. </span>
                <div class="input-field col s12">
                    <textarea id="abstract" class="materialize-textarea"></textarea>
                    <label for="abstract"><g:message code="dspace.metadata.abstract"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com uma data prevista de publicação do item. </span>
                <div class="input-field col s12">
                    <input type="date" id="date" class="datepicker">
                    <label for="date"><g:message code="dspace.metadata.date_publication"/> </label>
                </div>
            </div>

            <div class="col s12">
                <span class="description-input">Entre com uma data prevista de publicação do item. </span>
                <div class="input-field col s12">
                    <select id="license">
                        %{--<option value="" disabled selected>Choose your option</option>--}%
                        <option value="1">cc-by-sa</option>
                        <option value="2">cc-by-nc-sa</option>
                    </select>
                    <label for="license">Licensa:</label>
                </div>
            </div>


            <a class="waves-effect waves-light btn right my-orange">
                <g:message code="dspace.metadata.button_next"/>
            </a>
        </div>
    </div>
</div>
<g:javascript src="dspace.js"/>
</body>
</html>