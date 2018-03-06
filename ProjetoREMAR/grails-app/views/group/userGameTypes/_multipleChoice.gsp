
<img class="circle" src="/data/users/${user.username}/profile-picture">
<span class="title">${user.firstName + " " + user.lastName}</span>
<p class=""><g:message code='group.label.user' default='Usuário'/>: ${user.username}</p><br>
<div class="divider"></div>
<h5 class="center-align"><g:message code='Estatísticas do jogo' default='Estatísticas do jogo'/> <i>${exportedResource.name}</i></h5>
<div class="divider"></div><br>
<p><b><g:message code="group.label.question" default="Pergunta"/>:</b> ${question.get(0).question}?</p>
<p><b><g:message code="group.label.answer" default="Resposta"/>:</b> ${question.get(0).answer}</p>
<p><b><g:message code="group.label.stage" default="Fase"/>:</b> ${question.get(0).levelId + 1}</p>
<table class=" centered highlight responsive-table">
    <thead>
    <tr>
        <th data-field="date"><g:message code="group.label.date" default="Data"/></th>
        <th data-field="choices"><g:message code="group.label.choice" default="Alternativas"/></th>
        <th data-field="choice"><g:message code="group.label.chosenChoice" default="Alternativa Escolhida"/></th>
        <th data-field="win"><g:message code="group.label.victory" default="Vitória"/></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timeStamp}"/></td>
            <td>${stats.choices}</td>
            <td>${stats.choice}</td>
            <td>
                <g:if test="${stats.win}"><i style="color: green" class="fa fa-check-square"></i></g:if>
                <g:else><i style="color: red" class="fa fa-times"></i></g:else>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
