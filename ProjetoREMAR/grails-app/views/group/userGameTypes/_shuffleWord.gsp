<p class="no-margin valign-wrapper"><i class="tiny material-icons">check_circle</i><b>&nbspResposta:&nbsp</b> ${question.get(0).answer}</p>
<p class="no-margin valign-wrapper"><i class="tiny material-icons">explore</i><b>&nbspFase:&nbsp</b> ${question.get(0).levelId + 1}</p>
<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date">Data</th>
        <th data-field="points">Palavra Embaralhada</th>
        <th data-field="errors">Resposta</th>
        <th data-field="errors">Erros</th>
        <th data-field="win">Vitória</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timestamp}"/></td>
            <td>${stats.word}</td>
            <td>${stats.answer}</td>
            <td>${stats.numberMistake}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check-square"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>