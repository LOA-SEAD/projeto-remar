<%@ page import="br.ufscar.sead.loa.remar.User" contentType="text/html;charset=UTF-8" %>

<div class="cluster-header">
    <!--
    <div class="col s10">
        <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 24px;">
            Estatísticas do Jogo
        </p>
    </div>

    <div class="col s2" style="text-align: right;">
        <a href="/stats/analysis/?groupId=${group.id}&exportedResourceId=${exportedResource.id}"
           alt="Versão em gráficos">Versão em gráficos</a>
        <a class="btn btn-floating pulse my-orange" href="/stats/analysis/?groupId=${group.id}&exportedResourceId=${exportedResource.id}">
            <i class="material-icons">timeline</i>
        </a>
    </div>


    <div class="col s10">
        <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 20px;">
            <b>${exportedResource.name}</b>
        </p>
    </div>
    -->

    <div class="container-fluid" style="margin-top:10px;">
        <div class="row">
            <div class="col s12 m1 l1">
                <p></p>
            </div>

            <div class="col s12 m9 l9">
                <h3 class="center-align" style="margin:0; font-weight:bold">ESTATÍSTICAS</h3>
                <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 20px;">
                    <b>${exportedResource.name}</b>
                </p>
            </div>

            <div class="col s12 m2 l2" style="text-align: right;">
                <p class="center-align">
                    <a href="/stats/analysis/?groupId=${group.id}&exportedResourceId=${exportedResource.id}"
                       alt="Versão em gráficos">Versão em gráficos</a>
                    <a class="btn btn-floating pulse my-orange" href="/stats/analysis/?groupId=${group.id}&exportedResourceId=${exportedResource.id}">
                        <i class="material-icons">timeline</i>
                    </a>
                </p>
            </div>
        </div>
    </div>

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
                Na tabela acima você encontra todas as tentativas (certas ou erradas) dos membros do grupo. Clique no ícone embaixo do número
                da questão para visualizar todas as tentativas do jogador.
            </span>
        </div>
    </div>
</div>