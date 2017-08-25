<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>

%{-- Tile image --}%
<div id="default-image-sizes" class="hidden"></div>
<div class="row no-margin">
    <div class="col s4">
        <div class="row no-margin">
            <div class="tile-image col no-padding s6">
                <label>${tileInstance.content} - A</label>
                <img class="materialboxed" data-caption="${tileInstance.content} - A" src="/quimemoria/data/${tileInstance.ownerId}/tiles/tile${tileInstance.id}-a.png"/>
            </div>
            <div class="tile-image col no-padding s6">
                <label>${tileInstance.content} - B</label>
                <img class="materialboxed" data-caption="${tileInstance.content} - B" src="/quimemoria/data/${tileInstance.ownerId}/tiles/tile${tileInstance.id}-b.png" class="img-responsive max"/>
            </div>
        </div>
    </div>
    %{-- Tile info --}%
    <div class="col s8">
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
</div>