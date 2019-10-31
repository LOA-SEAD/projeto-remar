<div class="modal-content">
    <div class="row">
        <div class="col s12 right-align div-close">
            <a class="modal-action modal-close btn-flat right-align"><i class="material-icons">close</i></a>
        </div>
        <g:if test="${bitstream.format.contains("image")}">
            <div class="col s12 m6 l6 center-align">
                <img src="${restUrl}${bitstream.retrieveLink}" title="${bitstream.name}" class="responsive-img"/>
            </div>
        </g:if>
        <div class="col s12 m6 l6 left-align">
            <p><span class="bold">Nome: </span>${bitstream.name}</p>
            <p><span class="bold">Descrição: </span>${bitstream.description}</p>
            <p><span class="bold">Formato: </span>${bitstream.format}</p>
            <p><span class="bold">Tamanho: </span>${bitstream.sizeBytes} KB</p>
        </div>
        <div class="col s12 m12 l12 right-align">
            <a href="${jspuiUrl}/retrieve/${bitstream.id}/${bitstream.name}" target="_blank" download="${bitstream.name}"
               class="waves-effect waves-light btn my-orange">Abrir</a>
        </div>
    </div>
</div>
<div>

</div>
