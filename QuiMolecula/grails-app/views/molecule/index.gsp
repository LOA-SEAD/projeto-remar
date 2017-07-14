<%@ page import="br.ufscar.sead.loa.quimolecula.remar.Molecule" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="/quimolecula/css/materialize.css" media="screen,projection"/>
    <link rel="stylesheet" type="text/css" href="/quimolecula/css/molecule.css">

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="utf-8">
    <g:javascript src="editableTable.js"/>
    <g:javascript src="scriptTable.js"/>
    <g:javascript src="validate.js"/>

    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>

    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:set var="entityName" value="${message(code: 'Molecule.label', default: 'Molecule')}"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>

</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        QuiMolécula - Banco de Moléculas
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
        <th>Nome <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                            style="visibility: hidden"></button></div>
        </th>
        <th>Estrutura <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                            style="visibility: hidden"></button></div>
        </th>
        <th>Dica<div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div></th>

        <th>Ação <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div></th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${MoleculeInstanceList}" status="i" var="MoleculeInstance">
        <tr id="tr${MoleculeInstance.id}" class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
            data-id="${fieldValue(bean: MoleculeInstance, field: "id")}"
            data-owner-id="${fieldValue(bean: MoleculeInstance, field: "ownerId")}"
            data-checked="false">
            <g:if test="${MoleculeInstance.author == userName}">

                <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                <td name="Molecule_label">${fieldValue(bean: MoleculeInstance, field: "statement")}</td>

                <td>${fieldValue(bean: MoleculeInstance, field: "answer")}</td>

                <td name="theme" id="theme">${fieldValue(bean: MoleculeInstance, field: "category")}</td>


                <td><i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff; margin-right:10px;"
                       class="fa fa-pencil"
                       ></i></td>


            </g:if>
            <g:else>
                <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                <td name="Molecule_label"
                    data-MoleculeId="${MoleculeInstance.id}">${fieldValue(bean: MoleculeInstance, field: "statement")}</td>

                <td>${fieldValue(bean: MoleculeInstance, field: "answer")}</td>

                <td name="theme" id="theme">${fieldValue(bean: MoleculeInstance, field: "category")}</td>

                <td><i style="color: gray; margin-right:10px;" class="fa fa-pencil"></i>
                </td>
            </g:else>
        </tr>
    </g:each>
    </tbody>
</table>

<input type="hidden" id="editMoleculeLabel" value=""> <label for="editMoleculeLabel"></label>

<div class="row">
    <div class="col s2">
        <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="save">Enviar
        </button>
    </div>

    <div class="col s1 offset-s6">
        <a name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" href="/quimolecula/molecule/createMolecule" data-tooltip="Criar moléculas">
        <i class="material-icons">add</i>Criar moléculas</a>
    </div>

    <div class="col s1 m1 l1">
        <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir molécula" ></a>
    </div>
</div>

<!-- InfoModal Structure -->
<div id="infoModal" class="modal">
    <div class="modal-content">
        <div id="totalMolecule">
        </div>
    </div>

    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Entendi</button>
    </div>
</div>

<script type="text/javascript" src="/quimolecula/js/materialize.min.js"></script>
</body>
</html>
