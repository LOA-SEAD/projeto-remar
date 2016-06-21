<ul class="collection">
    <g:each in="${objects}" var="obj">
        <li class="collection-item avatar left-align">
            <img src="${restUrl}${obj.retrieveLink}" alt="" class="circle">
            <a href="/dspace/index.gsp" data-id="${obj.id}">${obj.name}</a>
            <p>${obj.shortDescription}</p>
        </li>
    </g:each>
</ul>