<%@ page import="br.ufscar.sead.loa.quimolecula.remar.Molecule" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="utf-8">
    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:external dir="css" file="molecule.css"/>

    <g:set var="entityName" value="${message(code: 'Molecule.label', default: 'Molecule')}"/>
</head>

<body>

    <div class="row">
        <div class="row cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                QuiMolécula - Banco de Moléculas
            </p>
        </div>

        <div class="row">
            <section class="molecule-management">
                <div class="molecule-list-box-container">
                    <div class="molecule-list-box-title">
                        <p>Banco de Moléculas</p>
                    </div>

                    <div class="molecule-list-box">
                        <ul id="available-molecules" class="sortable connected-sortable">
                            <g:each in="${MoleculeInstanceList}" status="i" var="MoleculeInstance">
                                <li class="ui-state-default" data-molecule-id="${fieldValue(bean: MoleculeInstance, field: "id")}" data-owner-id="${fieldValue(bean: MoleculeInstance, field: "ownerId")}">
                                    <i class="material-icons">drag_handle</i>
                                    <p>${fieldValue(bean: MoleculeInstance, field: "name")} ${fieldValue(bean: MoleculeInstance, field: "structure")}</p>
                                    <!-- ${fieldValue(bean: MoleculeInstance, field: "tip")} -->
                                    %{-- TODO: permitir que usuário dono edite a molécula
                                        <td>
                                            <i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff; margin-right:10px;" class="fa fa-pencil"></i>
                                        </td>
                                    --}%
                                </li>
                            </g:each>
                        </ul>
                    </div>

                    <div class="molecule-list-box-button">
                        <a id="delete-btn" class="waves-effect waves-light btn remar-orange disabled">
                            <span>
                                <p>Remover</p>
                            </span>
                        </a>
                    </div>
                </div>

                <div class="molecule-list-box-container">
                    <div class="molecule-list-box-title">
                        <p>Moléculas Selecionadas</p>
                    </div>

                    <div class="molecule-list-box">
                        <ul id="selected-molecules" class="sortable connected-sortable">

                        </ul>
                    </div>

                    <div class="molecule-list-box-button">
                        <a id="send-btn" class="waves-effect waves-light btn remar-orange disabled">
                            <span>
                                <p>Enviar</p>
                            </span>
                        </a>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <div class="cluster-header">

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

                    <td name="Molecule_label">${fieldValue(bean: MoleculeInstance, field: "name")}</td>

                    <td>${fieldValue(bean: MoleculeInstance, field: "structure")}</td>

                    <td name="theme" id="theme">${fieldValue(bean: MoleculeInstance, field: "tip")}</td>


                    <td><i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff; margin-right:10px;"
                           class="fa fa-pencil"
                           ></i></td>


                </g:if>
                <g:else>
                    <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                    <td name="Molecule_label"
                        data-MoleculeId="${MoleculeInstance.id}">${fieldValue(bean: MoleculeInstance, field: "name")}</td>

                    <td>${fieldValue(bean: MoleculeInstance, field: "structure")}</td>

                    <td name="theme" id="theme">${fieldValue(bean: MoleculeInstance, field: "tip")}</td>

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
            <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir molécula" >
            <i class="material-icons">delete</i>Excluir moléculas</a>
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

    <g:javascript src="materialize.min.js"/>
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:javascript src="molecule.js"/>
</body>
</html>
