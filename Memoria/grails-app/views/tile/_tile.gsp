<%@ page import="br.ufscar.sead.loa.memoria.Tile" %>
%{-- Tile image --}%
<div id="default-image-sizes" class="hidden"></div>
<div class="row no-margin">
    <div class="col s6">
        <div class="row no-margin">
            <div class="tile-image col no-padding s6">
                <label>${tileInstance.content} - A</label>
                <img class="materialboxed" alt="${tileInstance.content} - A" data-caption="${tileInstance.content} - A" src="/memoria/data/${tileInstance.ownerId}/tiles/tile${tileInstance.id}-a.png"/>
            </div>
            <div class="tile-image col no-padding s6">
                <label>${tileInstance.content} - B</label>
                <img class="materialboxed" alt="${tileInstance.content} - B" data-caption="${tileInstance.content} - B" src="/memoria/data/${tileInstance.ownerId}/tiles/tile${tileInstance.id}-b.png" class="img-responsive max"/>
            </div>
        </div>
    </div>
    %{-- Tile info --}%
    <div id="tile-info-column" class="col s4">
        <div class="row">
            <div class="input-field col s12">
                <label class="active">Conteúdo</label>
                <p class="wrapped">${tileInstance.content}</p>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s12">
                <label class="active">Descrição</label>
                <p class="wrapped">${tileInstance.description}</p>
            </div>
        </div>
    </div>
    %{-- Tile options --}%
    <div id="tile-options-column" class="col s1 center-align">
        <div class="fixed-action-btn">
            <a class="btn-floating btn-large red remar-orange tooltipped" data-tooltip-msg="Opções">
                <i class="large material-icons">more_vert</i>
            </a>
            <ul>
                <li>
                    <a id="edit-button" href="${createLink(controller:'tile', action:'edit', params:[id: tileInstance.id])}" class="btn-floating remar-brown tooltipped" data-tooltip-msg="Editar">
                        <i class="material-icons">mode_edit</i>
                    </a>
                </li>
                <li>
                    <a href="#delete-modal" class="btn-floating remar-brown modal-trigger tooltipped" data-tooltip-msg="Remover">
                        <i class="material-icons">delete</i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<div id="delete-modal" class="modal remar-modal">
    <div class="modal-content">
        <h4>Aviso</h4>
        <p>A remoção é permanente. O par de peças não poderá ser recuperado depois. Deseja continuar?</p>
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Não</a>
        <a href="${createLink(controller:'tile', action:'delete', params:[id: tileInstance.id])}" class="modal-action modal-close btn waves-effect waves-light remar-orange">Sim</a>
    </div>
</div>