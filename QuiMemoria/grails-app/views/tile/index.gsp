
<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>
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
                                            <div class="row no-margin">
                                                <p class="no-margin">Download do modelo de peças</p>
                                            </div>
                                            <div class="row no-margin">
                                                <label>
                                                    Modelo de peças na
                                                    <b id="model-orientation">vertical</b>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col s6">
                                            <a id="model-download" class="btn-floating waves-effect waves-light remar-orange" href="/quimemoria/samples/tilesample_v.zip">
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
                            <div class="col s6">
                                <label>
                                    O nível selecionado deve ter no mínimo
                                    <b id="difficulty-minimum"></b>
                                    pares
                                </label>
                            </div>
                            <div class="col s6">
                                <div id="difficulty-select-message">
                                    <label>Escolha um par de peças para visualizar (total: <b id="difficulty-total"></b>)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row valign-wrapper no-margin">
                            <div id="tile-display-header" class="col s6">
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
                    <g:link class="btn btn-success btn-lg remar-orange" action="create">Novo par</g:link>
                </div>
                <div class="col s2 center-align ">
                    <a href="#!" id="send" class="btn btn-success btn-lg remar-orange">Enviar</a>
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

    <g:javascript src="rememoria.js"/>
</body>
</html>
