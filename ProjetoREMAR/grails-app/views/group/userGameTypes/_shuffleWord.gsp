<p class="no-margin valign-wrapper">
    <i class="tiny material-icons">check_circle</i><b>&nbspPalavra:&nbsp</b> ${allStats.get(0).correctAnswer?.toUpperCase()}
</p>

<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date">Data</th>
        <th data-field="points">Palavra Embaralhada</th>
        <th data-field="errors">Resposta</th>
        <th data-field="errors">Tentativas</th>
        <th data-field="win">Vitória</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timestamp}"/></td>
            <td>${stats.word?.toUpperCase()}</td>
            <td>${stats.answer?.toUpperCase()}</td>
            <td>${stats.numberTries}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>