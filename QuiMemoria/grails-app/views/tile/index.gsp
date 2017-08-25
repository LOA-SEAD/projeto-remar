
<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
    <div class="row cluster">
        <div class="cluster-header">
            <h4>Memória - Peças</h4>
            <div class="divider"></div>
        </div>

        <div class="row show">
            %{-- Orientação das peças --}%
            <div class="row">
                <ul class="collection with-header">
                    <li class="collection-header">
                        <div class="row valign-wrapper no-margin">
                            <div class="col s12">
                                <h4>Orientação das Peças</h4>
                            </div>
                        </div>
                    </li>
                    <li class="collection-item row">
                        <div class="col s12">
                            <div class="row no-margin valign-wrapper">
                                %{-- Switch disposição das peças --}%
                                <div class="col s6">
                                    <div class="switch">
                                        <label class="valign-wrapper">
                                            <div>
                                                <p class="no-margin">Vertical</p>
                                                <img class="" src="/quimemoria/images/flipped_v.jpg"/>
                                            </div>
                                            <div>
                                                <input type="checkbox">
                                                <span class="lever"></span>
                                            </div>
                                            <div>
                                                <p class="no-margin">Horizontal</p>
                                                <img class="" src="/quimemoria/images/flipped_h.jpg"/>
                                            </div>
                                        </label>
                                    </div>
                                </div>
                                %{-- Download do modelo de peças --}%
                                <div class="col s6">
                                    <div class="row valign-wrapper">
                                        <div class="col s6 right-align">
                                            <p>Download do modelo de peças</p>
                                        </div>
                                        <div class="col s6">
                                            <a id="model-download" class="btn-floating waves-effect waves-light my-orange" href="/quimemoria/samples/tilesample_v.zip">
                                                <i class="material-icons">file_download</i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            %{-- Lista de peças --}%
            <div class="row tile-display-container">
                <ul class="collection with-header">
                    <li class="collection-header">
                        <div class="row valign-wrapper no-margin">
                            <div id="tile-display-header" class="col s6">
                                <label>
                                    O nível selecionado deve ter no mínimo
                                    <b id="difficulty-minimum">4</b>
                                     peças.
                                </label>
                                <h4>
                                    Nível
                                    <a id="decrease-level" href="#!" class="tooltipped" style="margin-left: 15px"
                                       data-delay="50" data-position="top" data-tooltip="Diminuir">
                                        <i class="grow material-icons">chevron_left</i>
                                    </a>
                                    <div class="center-align">
                                        <span id="difficulty-level"></span>
                                    </div>
                                    <a id="increase-level" href="#!" class="tooltipped"
                                       data-delay="50" data-position="top" data-tooltip="Aumentar">
                                        <i class="grow material-icons">chevron_right</i>
                                    </a>
                                </h4>
                            </div>

                            <div id="difficulty-select-container" class="col s6"></div>
                        </div>
                    </li>
                    <li id="tile-display" class="collection-item inactive">
                    </li>
                </ul>
            </div>

            <div class="row no-margin">
                <div class="col s3 offset-s7 right-align ">
                    <g:link class="btn btn-success btn-lg my-orange" action="create">Novo par</g:link>
                </div>
                <div class="col s2 center-align ">
                    <a href="#!" id="send" class="btn btn-success btn-lg my-orange">Enviar</a>
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

    %{--
    <div class="row">
        <form class="col s12" name="formName">
            <ul class="collapsible" data-collapsible="accordion">
                <li>
                    <div class="collapsible-header active"> <b>Minhas Peças </b></div>
                    <div class="collapsible-body">
                        <g:if test="${tileInstanceListMy.size() < 1 }">
                            <p> Você ainda não possui nenhuma peça</p>
                        </g:if>
                        <g:else>
                            <table class="" id="tableMyTile">
                                <thead>
                                <tr>
                                    <th class="simpleTable">Selecionar</th>
                                    <th class="simpleTable">Peça A</th>
                                    <th class="simpleTable">Peça B</th>
                                    <th class="simpleTable">Ação</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${tileInstanceListMy}" status="i" var="tileInstance">
                                    <tr data-id="${fieldValue(bean: tileInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td class="myTile simpleTable" align="center "><input class="with-gap " name="checkbox" type="checkbox" id="myTile${i}" data-tileid="${tileInstance.id}"
                                                                                              value="${fieldValue(bean: tileInstance, field: "id")}" > <label for="myTile${i}"></label>
                                        </td>
                                        <td align="center"><img width="142"
                                                                src="/quimemoria/data/${fieldValue(bean: tileInstance, field: "ownerId")}/tiles/tile${fieldValue(bean: tileInstance, field: "id")}-a.png"
                                                                class="img-responsive max"/></td>
                                        <td align="center"><img width="142"
                                                                src="/quimemoria/data/${fieldValue(bean: tileInstance, field: "ownerId")}/tiles/tile${fieldValue(bean: tileInstance, field: "id")}-b.png"
                                                                class="img-responsive max"/></td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </g:else>
                    </div>
                </li>
            </ul>
            <div class="row">
                <div class="col s12">
                    <g:submitButton name="save" class="save btn btn-success btn-lg my-orange" value="Enviar"/>

                </div>
            </div>
        </form>
    </div>
    --}%
</body>
</html>
