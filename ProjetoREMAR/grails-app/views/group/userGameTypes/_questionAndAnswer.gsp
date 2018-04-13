<p class="no-margin valign-wrapper">
    <i class="tiny material-icons">help</i><b>&nbspPergunta:&nbsp</b> ${allStats.get(0).question}
</p>

<p class="no-margin valign-wrapper">
    <i class="tiny material-icons">check_circle</i><b>&nbspResposta:&nbsp</b> ${allStats.get(0).answer}
</p>

<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date">Data</th>
        <th data-field="points">Pontos</th>
        <th data-field="points">Pontos Parciais</th>
        <th data-field="errors">Erros</th>
        <th data-field="win">Vitória</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timestamp}"/></td>
            <td>${stats.points}</td>
            <td>${stats.partialPoints}</td>
            <td>${stats.errors}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>