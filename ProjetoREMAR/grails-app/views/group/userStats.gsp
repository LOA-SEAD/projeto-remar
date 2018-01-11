<%@ page import="br.ufscar.sead.loa.remar.User" contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="row">
    <div class="col l12 offset-l1">
        <ul class="collection">
            <li class="collection-item left-align">
                <div class="row valign-wrapper" style="margin-bottom: 10px !important">
                    <div class="col s1 valign-wrapper">
                        <img src="/data/users/${user.username}/profile-picture" style="width: 42px; height: 42px; ">
                    </div>
                    <div class="col s11">
                        <p class="title no-margin"><strong>Nome:</strong> ${user.firstName + " " + user.lastName}</p>
                        <p class="title no-margin"><strong>Usuário:</strong> ${user.username}</p>
                    </div>
                </div>
                <div class="divider"></div>
                <h5 class="center-align">Estatísticas do jogo <b>${exportedResource.name}</b></h5>

                <g:if test="${fase}">
                    <p class="center-align" style="font-size:15pt; margin: 10px"><i>${fase}</i></p>
                </g:if>

                <div class="divider"></div><br>
                <g:render template="userGameTypes/${allStats.get(0).gameType}" />
            </li>
        </ul>
    </div>

    <div class="right">
        <a id="backButton" name="Back" class="btn my-orange" href="javascript:history.back()"> Voltar </a>
    </div>
</div>

</body>
</html>