<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 7/8/16
  Time: 9:04 AM
--%>

<%@ page import="br.ufscar.sead.loa.remar.User" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="row">
    <div class="col l12 offset-l1">
        <ul class="collection">
            <li class="collection-item avatar left-align">
                <img class="circle" src="/data/users/${user.username}/profile-picture">
                <span class="title">${user.firstName + " " + user.lastName}</span>
                <p class="">Usuário: ${user.username}</p><br>
                <div class="divider"></div>
                <h5 class="center-align">Estatísticas do jogo <i>${exportedResource.name}</i></h5>
                <div class="divider"></div><br>
                <g:if test="${allStats.get(0).gameType == "questionAndAnswer" || allStats.get(0).gameType == "multipleChoice"}">
                    <p><b>Pergunta:</b> ${question.get(0).question}?</p>
                    <p><b>Resposta:</b> ${question.get(0).answer}</p>
                </g:if>

                <g:elseif test="${allStats.get(0).gameType == "puzzleWithTime"}">
                </g:elseif>
                <p><b>Fase:</b> ${question.get(0).levelId + 1}</p>

                <table class=" centered highlight responsive-table">
                    <thead>
                    <tr>
                        <th data-field="date">Data</th>
            
                        <g:if test="${allStats.get(0).gameType == "questionAndAnswer"}">
                            <th data-field="points">Pontos</th>
                            <th data-field="errors">Erros</th>
                        </g:if>
                        <g:elseif test="${allStats.get(0).gameType == "puzzleWithTime"}">
                            <th data-field="points">Pontos</th>
                            <th data-field="time">Tempo Restante</th>
                        </g:elseif>
                        <g:elseif test="${allStats.get(0).gameType == "multipleChoice"}">
                            <th data-field="choices">Alternativas</th>
                            <th data-field="choice">Alternativa Escolhida</th>
                        </g:elseif>
                        <th data-field="win">Vitória</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${allStats}" var="stats">
                            <tr>
                                <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.timeStamp}"/></td>
                                <g:if test="${allStats.get(0).gameType == "questionAndAnswer"}">
                                    <td>${stats.partialPoints}</td>
                                    <td>${stats.errors}</td>
                                </g:if>
                                <g:elseif test="${allStats.get(0).gameType == "puzzleWithTime"}">
                                    <td>${stats.partialPoints}</td>
                                    <td>${stats.remainingTime}</td>
                                </g:elseif>
                                <g:elseif test="${allStats.get(0).gameType == "multipleChoice"}">
                                    <td>${stats.choices}</td>
                                    <td>${stats.choice}</td>
                                </g:elseif>
                                <td>
                                    <g:if test="${stats.win}"><i style="color: green" class="fa fa-check-square"></i></g:if>
                                    <g:else><i style="color: red" class="fa fa-times"></i></g:else>
                                </td>
                            </tr>
                    </g:each>
                    </tbody>
                </table>
            </li>

        </ul>
    </div>
</div>

</body>
</html>