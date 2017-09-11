
<img class="circle" src="/data/users/${user.username}/profile-picture">
<span class="title">${user.firstName + " " + user.lastName}</span>
<p class="">Usuário: ${user.username}</p><br>
<div class="divider"></div>
<h5 class="center-align">Estatísticas do jogo <i>${exportedResource.name}</i></h5>
<div class="divider"></div><br>
<p><b>Pergunta:</b> ${question.get(0).question}?</p>
<p><b>Resposta:</b> ${question.get(0).answer}</p>
<p><b>Fase:</b> ${question.get(0).levelId + 1}</p>
<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date">Data</th>
        <th data-field="points">Pontos</th>
        <th data-field="errors">Erros</th>
        <th data-field="win">Vitória</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timeStamp}"/></td>
            <td>${stats.partialPoints}</td>
            <td>${stats.errors}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check-square"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
            