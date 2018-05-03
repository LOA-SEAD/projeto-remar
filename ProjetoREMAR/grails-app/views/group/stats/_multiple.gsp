<%--
##############################################

Author: Lucas Pessoa
Date: 03/10/2017

OBS.: o código desta página está com gambiarras em sua implementação. Após o término de pendências futuras,
ele será alterado, mantendo o seu funcionamento, de forma que sua estrutura fique com a possibilidade de
realização de uma manutenção mais facilmente.

##############################################
--%>


<%@ page import="br.ufscar.sead.loa.remar.User" contentType="text/html;charset=UTF-8" %>

<div class="cluster-header">
    <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 24px;">
        Estatísticas do Jogo
    </p>
    <p class="text-teal text-darken-3 center-align margin-bottom" style="font-size: 20px;">
        <b>${exportedResource.name}</b>
    </p>
    <div class="divider"></div>
</div>

<div class="row">
    <div class="required input-field col s8 offset-s2"> <!-- "required" apenas para campos obrigatórios -->
        <p><strong>Escolha a fase para obter os dados</strong></p>
        <select id="select-multiple" group-id="${group.id}" exp-id="${exportedResource.id}" class="validate">
            <g:each in="${gameLevelName}" var="it">
                <option value="${it.key}">${it.value}</option>
            </g:each>
        </select>
    </div>
</div>



<!-- Entra-se nos valores da primeira chave do map -->
<g:each in="${userStatsMap.entrySet().iterator().next()}" var="stats">
    <!-- Entra-se nos valores (arrays de stats) de cada chave (numero da fase) do map -->
    <g:each in="${stats.value}" var="statsSingle">

        <div id="tabelaStats-${statsSingle.key}" class="col s12 tabelaStats" num-fase="${statsSingle.key}" style="">
            <table class="bordered highlight responsive-table">
                <thead>
                <tr>
                    <th></th>
                    <g:each in="${1..statsSingle.value.get(0).gameSize}" var="num">
                        <th style="padding-left: 1.80em;">${num}</th>
                    </g:each>
                </tr>
                </thead>

                <tbody><tr>

                <g:each in="${userStatsMap.keySet()}" var="usuario" status="nroUser">
                    <tr>

                    <g:if test="${usuario instanceof User}">
                        <td style="padding-left: 1.80em;">${usuario.firstName + " " + usuario.lastName}</td>
                        <g:each in="${1..statsSingle.value.get(0).gameSize}">
                            <td></td>
                        </g:each>
                    </g:if>
                    <g:else>
                        <td style="padding-left: 1.80em;">${usuario.get(0).user.firstName + " " + usuario.get(0).user.lastName}</td>
                    </g:else>

                    <g:each in="${userStatsMap.entrySet().iterator().getAt(nroUser)}" var="statsUser">
                        <g:each in="${statsUser.value}" var="statsgameLevel">
                            <g:if test="${statsgameLevel.key == statsSingle.key}">
                                <g:each in="${0..statsgameLevel.value.get(0).gameSize-1}" var="i">

                                    <g:set var="levelWon" value="${statsgameLevel.value.find { it.challengeId == i && it.win == true}}"/>
                                    <g:set var="levelLose" value="${statsgameLevel.value.find { it.challengeId == i && it.win == false}}"/>

                                    <g:if test="${(levelLose?.challengeId!=null) && (levelWon?.challengeId!=null)}">
                                        <td style="padding-left: 1.80em;"> <a class="tooltipped" data-position="top" data-delay="30" data-tooltip="Acertou com erros" href="/group/user-stats/${usuario.get(0).user.id}?exp=${exportedResource.id}&challenge=${levelWon.challengeId}&level=${statsgameLevel.key}&levelName=${gameLevelName.getAt(statsgameLevel.key)}">
                                            <i style="color: #ff9800; margin-left: 2px" class="fa fa-check"></i></a></td>
                                    </g:if>
                                    <g:else>
                                        <g:if test="${levelWon}">
                                            <td style="padding-left: 1.80em;"> <a class="tooltipped" data-position="top" data-delay="30" data-tooltip="Acertou sem erros" href="/group/user-stats/${usuario.get(0).user.id}?exp=${exportedResource.id}&challenge=${levelWon.challengeId}&level=${statsgameLevel.key}&levelName=${gameLevelName.getAt(statsgameLevel.key)}"><i style="color: green" class="fa fa-check"></i></a> </td>
                                        </g:if>

                                        <g:elseif test="${levelLose}">
                                            <td style="padding-left: 1.80em;"> <a class="tooltipped" data-position="top" data-delay="30" data-tooltip="Errou" href="/group/user-stats/${usuario.get(0).user.id}?exp=${exportedResource.id}&challenge=${levelLose.challengeId}&level=${statsgameLevel.key}&levelName=${gameLevelName.getAt(statsgameLevel.key)}"> <i style="color: red" class="fa fa-times"></i> </a></td>
                                        </g:elseif>
                                        <g:else>
                                            <td></td>
                                        </g:else>
                                    </g:else>
                                </g:each>
                            </g:if>
                        </g:each>
                    </g:each>

                </g:each>
                </tr>
                </tbody>
            </table>

        </div>
    </g:each>
</g:each>

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

<g:javascript src="group/multiple-render.js"/>