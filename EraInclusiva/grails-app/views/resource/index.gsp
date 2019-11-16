<%@ page import="br.ufscar.sead.loa.erainclusiva.remar.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="/erainclusiva/css/materialize.css" media="screen,projection"/>
    <link rel="stylesheet" type="text/css" href="/erainclusiva/css/resource.css">

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="utf-8">
    <g:javascript src="editableTable.js"/>
    <g:javascript src="scriptTable.js"/>
    <g:javascript src="validate.js"/>
    <g:javascript src="resource.js"/>

    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>

    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:set var="entityName" value="${message(code: 'resource.label', default: 'Resource')}"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>

</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        A Era Inclusiva - Tabela de Recursos
    </p>
</div>


<div class="row">
    <div class="col s3 offset-s9">
        <input type="text" id="SearchLabel" class="remar-input" placeholder="Buscar"/>
    </div>
</div>

<table class="highlight" id="table" style="margin-top: -30px;">
    <thead>
    <tr>
        <th>Selecionar
            <div class="row" style="margin-bottom: -10px;">

                <button style="margin-left: 3px; background-color: #795548;" class="btn-floating" id="BtnCheckAll"
                        onclick="check_all()"><i class="material-icons">check_box_outline_blank</i></button>
                <button style="margin-left: 3px; background-color: #795548;" class="btn-floating" id="BtnUnCheckAll"
                        onclick="uncheck_all()"><i class="material-icons">done</i></button>
            </div>
        </th>
        <th>Nome<div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                       style="visibility: hidden"></button></div>
        </th>
        <th>Link <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div>
        </th>
        <th>Categoria <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                             style="visibility: hidden"></button></div>
        </th>

        <th>Ação <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div></th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${resourceInstanceList}" status="i" var="resourceInstance">
        <tr id="tr${resourceInstance.id}" class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} "
            style="cursor: pointer;"
            data-id="${fieldValue(bean: resourceInstance, field: "id")}"
            data-owner-id="${fieldValue(bean: resourceInstance, field: "ownerId")}"
            data-checked="false">
            <g:if test="${resourceInstance.author == userName}">

                <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                <td name="resource_label">${fieldValue(bean: resourceInstance, field: "statement")}</td>

                <td>${fieldValue(bean: resourceInstance, field: "answer")}</td>

                <td name="theme" id="theme">${fieldValue(bean: resourceInstance, field: "category")}</td>


                <td><i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff; margin-right:10px;"
                       class="fa fa-pencil"></i></td>

            </g:if>
            <g:else>
                <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                <td name="resource_label"
                    data-resourceId="${resourceInstance.id}">${fieldValue(bean: resourceInstance, field: "statement")}</td>

                <td>${fieldValue(bean: resourceInstance, field: "answer")}</td>

                <td name="theme" id="theme">${fieldValue(bean: resourceInstance, field: "category")}</td>

                <td><i style="color: gray; margin-right:10px;" class="fa fa-pencil"></i>
                </td>
            </g:else>
        </tr>
    </g:each>
    </tbody>
</table>

<input type="hidden" id="editResourceLabel" value=""> <label for="editResourceLabel"></label>

<div class="row">
    <div class="col s2">
        <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="save">Enviar
        </button>
    </div>

    <div class="col s1 offset-s6">
        <a data-target="createModal" name="create"
           - class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped"
           data-tooltip="Criar questão"><i
                - class="material-icons">add</i></a>
    </div>

    <div class="col s1 m1 l1">
        <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped"
           data-tooltip="Excluir questão"><i class="material-icons">delete</i></a>
    </div>
</div>



<!-- Modal Structure -->
<div id="createModal" class="modal remar-modal">
    <g:form url="[resource: resourceInstance, action: 'newResource']">
        <div class="modal-content">
            <h4>Criar Recurso<i class="material-icons tooltipped" data-position="right" data-delay="30"
                                data-tooltip="Criação de recursos (nome, link, categoria)">info</i>
            </h4>

            <div class="row">
                <g:render template="form"/>
            </div>
        </div>

        <div class="modal-footer">
            <a href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange" action="create"
               onclick="$(this).closest('form').submit()" name="create">Criar</a>
            <a href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
        </div>
    </g:form>
</div>



<!-- Modal -->
<div id="editModal" class="modal remar-modal">
    <g:form url="[resource: resourceInstance, action: 'update']" method="PUT">
        <div class="modal-content">
            <h4>Editar Recurso</h4>

            <input id="editVersion" name="version" required="" value="" type="hidden">
            <input type="hidden" id="resourceID" name="resourceID">


            <div class="input-field col s12">
                <input id="editStatement" name="statement" required="" value="" type="text" class="validate remar-input"
                       maxlength="150">
                <label id="statementLabel" for="editStatement">Nome</label>
            </div>

            <div class="input-field col s12">
                <input id="editAnswer" name="answer" required="" value="" type="text" class="validate remar-input"
                       maxlength="48">
                <label id="answerLabel" for="editAnswer">Link</label>
            </div>

            <div class="input-field col s12">
                <g:select id="category" name="category" from="${Resource.categorias}"
                          value="${resourceInstance?.category}"/>
                <label for="category">Categoria</label>
            </div>

            <!-- div class="input-field col s12">
                <input id="editCategory" name="category" required="" value="" type="text" class="validate remar-input">
                <label id="categoryLabel" for="editCategory">Tema</label>
            </div-->

            <div class="input-field col s12" style="display: none;">
                <input id="editAuthor" name="author" required="" readonly="readonly" value="" type="text"
                       class="validate remar-input">
                <label id="authorLabel" for="editAuthor">Autor</label>
            </div>

        </div>

        <div class="modal-footer">
            <a href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange" action="update"
               onclick="$(this).closest('form').submit()" name="create">Atualizar</a>
            <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
        </div>
    </g:form>
</div>

<!-- Modal Structure -->
<div id="infoModal" class="modal">
    <div class="modal-content">
        <div id="totalResource">

        </div>
    </div>

    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Entendi</button>
    </div>
</div>

<script type="text/javascript" src="/erainclusiva/js/materialize.min.js"></script>
<script type="text/javascript">

    function changeEditResource(variable) {
        var editResource = document.getElementById("editResourceLabel");
        editResource.value = variable;

        console.log(editResource.value);
        //console.log(variable);
    }

</script>

</body>
</html>
