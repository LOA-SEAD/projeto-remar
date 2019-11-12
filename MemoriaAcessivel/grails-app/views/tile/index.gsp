
<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
    %{-- Loading Screen --}%
    <div id="loading-screen">
        <div class="spinner outer" style="background-image: url(${resource(dir: 'images', file: 'outerspinner.png')});"></div>
        <img class="spinner inner" src="${resource(dir: 'images', file: 'innerspinner.png')}">
    </div>

    <div class="row cluster">
        <div class="cluster-header">
            <h4>Memória - Tabela de Questões</h4>
            <div class="divider"></div>
        </div>

        <div class="row show">
            %{-- Lista de peças --}%
            <div class="row tile-display-container">
                <table id="table">
                    <thead>
                    <tr>
                        <th>Selecionar
                            <div class="row" style="margin-bottom: -10px;">
                                <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnCheckAll" onclick="check_all()"><i  class="material-icons">check_box_outline_blank</i></button>
                                <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnUnCheckAll" onclick="uncheck_all()"><i  class="material-icons">done</i></button>
                            </div></th>
                        <th>${message(code: 'tile.table.textA.header', default: 'Texto da Primeira Carta')}</th>
                        <th>${message(code: 'tile.table.textB.header', default: 'Texto da Segunda Carta')}</th>
                        <th>${message(code: 'tile.table.actions.header', default: 'Ações')}</th>
                    </tr>
                    </thead>
                    <tbody>
                        <g:if test="${tilesCount}">
                            <g:each var="tile" in="${tilesList}">
                                <tr>
                                    <td>
                                        <input type="checkbox" id="tile-${tile.id}" name="id" class="filled-in" data-id="${tile.id}"/>
                                        <label for="tile-${tile.id}"></label>
                                    </td>
                                    <td>
                                        ${tile.textA}
                                        <audio controls>
                                            <source src="data/${tile.ownerId}/audios/${tile.id}/carta1.mp3" type="audio/mpeg">
                                            Your browser does not support the audio tag.
                                        </audio>
                                    </td>
                                    <td>
                                        ${tile.textB}
                                        <audio controls>
                                            <source src="data/${tile.ownerId}/audios/${tile.id}/carta2.mp3" type="audio/mpeg">
                                            Your browser does not support the audio tag.
                                        </audio>
                                    </td>
                                    <td>
                                        <a href="${createLink(action: "edit")}/${tile.id}">
                                            <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil edit" data-id="${tile.id}"></i>
                                        </a>
                                    </td>
                                </tr>
                            </g:each>
                        </g:if>
                        <g:else>
                            <td colspan="3">Não há pares cadastrados!</td>
                        </g:else>

                    </tbody>
                </table>
            </div>

            <div class="row">
                <div class="col s2">
                    <a href="#!" id="send" class="btn btn-success btn-lg remar-orange">Enviar</a>
                </div>
                <div class="col offset-s8">
                    <a href="${createLink(action: "create", controller: "tile")}"
                       class="btn-floating btn-success btn-large waves-effect waves-light remar-orange tooltipped" action="create" data-tooltip="Criar novo par"><i class="material-icons">add</i></a>
                </div>
                <div class="col s1 offset-s1 m1 l1">
                    <a class="modal-trigger btn btn-floating btn-large waves-effect waves-light remar-orange tooltipped" href="#deleteModal" data-tooltip="Exluir pares selecionados" ><i class="material-icons">delete</i></a>
                </div>

                </div>
            </div>
        </div>
    </div>

    <div id="fail-modal" class="modal remar-modal">
        <div class="modal-content">
            <h4>Não foi possível enviar</h4>
            <p></p>
        </div>
        <div class="modal-footer">
            <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">OK</a>
        </div>
    </div>

    <div id="deleteModal" class="modal remar-modal">
        <div class="modal-content">
            <h4> Tem certeza que deseja remover esses pares?</h4>
        </div>
        <div class="modal-footer">
            <a id="removeSelected" href="#!" class="modal-action modal-close waves-effect waves-light remar-orange">Sim</a>
            <a href="#!" class="modal-action modal-close waves-effect waves-light remar-orange">Não</a>
        </div>
    </div>

    <g:javascript>
        level = ${level};
    </g:javascript>
    <g:javascript src="rememoria.js"/>
</body>
</html>
