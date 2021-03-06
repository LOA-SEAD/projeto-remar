<%@ page import="br.ufscar.sead.loa.remar.User" contentType="text/html;charset=UTF-8" %>

<div class="cluster-header">
    <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 24px;">
        Estatísticas do Jogo
    </p>
    <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 20px;">
        <b>${exportedResource.name}</b>
    </p>

    <div class="divider"></div>
    <p></p>
</div>

<table class="bordered highlight responsive-table" >
    <thead>
        <tr>
            <th></th>
            <g:each in="${1..allStats.get(0).get(1).gameSize}" status="i" var="stats">
                <th style="padding-left: 1.80em;">${stats}</th>
            </g:each>
        </tr>
    </thead>
    <tbody>
    <g:each in="${allStats}" var="stats">
        <tr>
            <g:if test="${stats instanceof User}">
                <td style="padding-left: 1.80em;">${stats.firstName + " " + stats.lastName}</td>
                <g:each in="${1..allStats.get(0).get(1).gameSize}">
                    <td></td>
                </g:each>
            </g:if>
            <g:else>
                <td style="padding-left: 1.80em;">${stats.get(0).user.firstName + " " + stats.get(0).user.lastName}</td>
                <g:each in="${0..allStats.get(0).get(1).gameSize-1}" var="i">

                    <g:set var="levelWon" value="${stats.find { it.challengeId == i && it.win == true}}"/>
                    <g:set var="levelLose" value="${stats.find { it.challengeId == i && it.win == false}}"/>


                    <g:if test="${(levelLose?.challengeId!=null) && (levelWon?.challengeId!=null)}">
                        <td style="padding-left: 1.80em;"> <a class="tooltipped" data-position="top" data-delay="30" data-tooltip="Acertou com erros" href="/group/user-stats/${stats.get(0).user.id}?exp=${exportedResource.id}&challenge=${levelWon.challengeId}"><i style="color: #ff9800; margin-left: 2px" class="fa fa-check"></i></a></td>
                    </g:if>
                    <g:else>

                        <g:if test="${levelWon}">
                            <td style="padding-left: 1.80em;"> <a class="tooltipped" data-position="top" data-delay="30" data-tooltip="Acertou sem erros" href="/group/user-stats/${stats.get(0).user.id}?exp=${exportedResource.id}&challenge=${levelWon.challengeId}"><i style="color: green" class="fa fa-check"></i></a> </td>
                        </g:if>

                        <g:elseif test="${levelLose}">
                            <td style="padding-left: 1.80em;"> <a class="tooltipped" data-position="top" data-delay="30" data-tooltip="Errou" href="/group/user-stats/${stats.get(0).user.id}?exp=${exportedResource.id}&challenge=${levelLose.challengeId}"> <i style="color: red" class="fa fa-times"></i> </a></td>
                        </g:elseif>
                        <g:else>
                            <td></td>
                        </g:else>

                    </g:else>



                </g:each>
            </g:else>
        </tr>
    </g:each>

    </tbody>
</table>

<div class="row">
    <div style="padding-top: 3em; text-align: justify" class="col s6 offset-s3">
        <div class="card-panel hoverable remar-brown"> <!-- colocar no css o standardization -->
            <div class="right-align"><i style="cursor: pointer; color: white" class="material-icons close">close</i></div>
            <span class="white-text">
                Na tabela acima você encontra todas as tentativas (certas ou erradas) dos membros do grupo. Clique no icone embaixo do numero
                da questão para visualizar todas as tentativas do jogador.
            </span>
        </div>
    </div>
</div>