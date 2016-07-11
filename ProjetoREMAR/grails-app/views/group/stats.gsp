<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 7/8/16
  Time: 9:04 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="row">
    <div class="col l12 offset-l1">
        <h5 class=""><i class="fa fa-bar-chart fa-1x"></i> Estatísticas do jogo</h5><br>
        <ul class="collection users-collection">
            <g:each var="userGroup" in="${group.userGroups.sort{it.user.firstName}}">
                %{--<g:if test="${allStats.get(i).userId == userGroup.user.id}">--}%
                    <li id="user-group-card-${userGroup.id}" class="collection-item avatar left-align">
                    <img alt src="/data/users/${userGroup.user.username}/profile-picture" class="circle">
                    <span class="title">${userGroup.user.firstName + " " + userGroup.user.lastName}</span>
                    <p class="">Usuário: ${userGroup.user.username}</p>
                    <div class="divider"></div>
                    <div class="row">
                        <g:if test="${ids.contains(userGroup.user.id)}">
                            <table class="bordered centered highlight responsive-table">
                                <thead>
                                <tr>
                                    <th data-field="date">Data</th>
                                    <th data-field="question">Pergunta</th>
                                    <th data-field="answer">Resposta</th>
                                    <th data-field="partialPoints">Pontos Parciais</th>
                                    <th data-field="points">Pontos Acumulados</th>
                                    <th data-field="errors">Erros</th>
                                </tr>
                                </thead>
                                <tbody>
                                        <g:each in="${allStats}" var="stats">
                                            <g:if test="${stats.userId == userGroup.user.id}">
                                                <tr>
                                                    <td><g:formatDate format="dd/MM/yy - HH:mm" date="${stats.date}"/></td>
                                                    <td>${stats.question}</td>
                                                    <td>${stats.answer}</td>
                                                    <td>${stats.partialPoints}</td>
                                                    <td>${stats.points}</td>
                                                    <td>${stats.errors}</td>
                                                </tr>
                                                <g:if test="${stats.end == "true"}">
                                                    <tr><th class="center" colspan="6">Fim de jogo</th></tr>
                                                </g:if>
                                            </g:if>
                                        </g:each>
                                </tbody>
                            </table>
                        </g:if>
                        <g:else>
                            <br>
                            <h5 class="center">Este usuário ainda não jogou.</h5>
                        </g:else>
                    </div>
                </li>
                %{--</g:if>--}%
            </g:each>
        </ul>

    </div>

</div>


</body>
</html>