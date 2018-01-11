<p class="no-margin valign-wrapper">
    <i class="tiny material-icons">help</i><b>&nbspPergunta:&nbsp</b> ${allStats.get(0).question}
</p>

<p class="no-margin valign-wrapper">
    <i class="tiny material-icons">check_circle</i><b>&nbspResposta:&nbsp</b> ${allStats.get(0).answer}
</p>

<%--p class="no-margin valign-wrapper">
    <i class="tiny material-icons">explore</i><b>&nbspFase:&nbsp</b> ${allStats.get(0).levelId + 1}
</p--%>

<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date">Data</th>
        <th data-field="choices">Alternativas</th>
        <th data-field="choice">Alternativa Escolhida</th>
        <th data-field="win">Vitória</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timestamp}"/></td>
            <td>${stats.choices}</td>
            <td>${stats.choice}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
            