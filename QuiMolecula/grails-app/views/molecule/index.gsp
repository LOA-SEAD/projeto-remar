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

                    <ul id="available-molecules" class="row molecule-list-box sortable" data-button="deleteMoleculeButton">
                        <g:each in="${MoleculeInstanceList}" status="i" var="MoleculeInstance">
                            <li class="row" data-molecule-id="${fieldValue(bean: MoleculeInstance, field: "id")}" data-owner-id="${fieldValue(bean: MoleculeInstance, field: "ownerId")}">
                                <div class="col s2">
                                    <i class="material-icons">drag_handle</i>
                                </div>
                                <div class="col s5">
                                    <span>${fieldValue(bean: MoleculeInstance, field: "name")}</span>
                                </div>
                                <div class="col s3">
                                    <span class="molecule-structure">${fieldValue(bean: MoleculeInstance, field: "structure")}</span>
                                </div>
                                <div class="col s2">
                                    <i class="fa fa-info tooltipped"
                                       data-position="bottom" data-delay="50" data-tooltip="${fieldValue(bean: MoleculeInstance, field: "tip")}"></i>
                                </div>
                            </li>
                        </g:each>
                    </ul>

                    <div class="molecule-list-box-button">
                        <div class="row">
                            <div class="col s6">
                                <a id="createMoleculeButton" class="waves-effect waves-light btn remar-orange" href="${createLink(action: 'create')}">
                                    <span>
                                        <p>Adicionar</p>
                                    </span>
                                </a>
                            </div>
                            <div class="col s6">
                                <a id="deleteMoleculeButton" class="waves-effect waves-light btn remar-orange disabled">
                                    <span>
                                        <p>Remover</p>
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="molecule-list-box-container">
                    <div class="molecule-list-box-title">
                        <p>Moléculas Selecionadas</p>
                    </div>

                    <ul id="selected-molecules" class="row molecule-list-box sortable" data-button="sendMoleculeButton">

                    </ul>

                    <div class="molecule-list-box-button">
                        <div class="row">
                            <div class="col s12">
                                <a id="sendMoleculeButton" class="waves-effect waves-light btn remar-orange disabled" href="${createLink(action: 'send')}">
                                    <span>
                                        <p>Enviar</p>
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
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
