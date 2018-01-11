
<p class="no-margin valign-wrapper">
    <i class="tiny material-icons">explore</i><b>&nbspFase:&nbsp</b> ${question.get(0).levelId + 1}
</p>

<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date">Data</th>
        <th data-field="points">Pontos</th>
        <th data-field="time">Tempo Restante</th>
        <th data-field="win">Vitória</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timetamp}"/></td>
            <td>${stats.partialPoints}</td>
            <td>${stats.remainingTime}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
            