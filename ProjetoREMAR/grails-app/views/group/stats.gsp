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
    <g:if test="${!allStats.empty}">
        <div class="col l12 offset-l2">
            <table class="bordered highlight responsive-table" style="width: auto">
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

                            <g:set var="levelWon" value="${stats.find { it.levelId == i && it.win == true}}"/>
                            <g:set var="levelLose" value="${stats.find { it.levelId == i && it.win == false}}"/>

                            <g:if test="${levelWon}">
                                <td style="padding-left: 1.80em;"> <a href="/group/user-stats/${stats.get(0).user.id}?exp=${exportedResource.id}&level=${levelWon.levelId}"><i style="color: green" class="fa fa-check-square"></i></a> </td>
                            </g:if>

                            <g:elseif test="${levelLose}">
                                <td style="padding-left: 1.80em;"> <a href="/group/user-stats/${stats.get(0).user.id}?exp=${exportedResource.id}&level=${levelLose.levelId}"> <i style="color: red" class="fa fa-times"></i> </a></td>
                            </g:elseif>
                            <g:else>
                                <td></td>
                            </g:else>

                        </g:each>
                    </g:else>
                </tr>
            </g:each>

            </tbody>
        </table>
    </div>
    </g:if>
    <g:else>
        <div class="col l12">
            <h5>Nenhuma estatística foi encontrada ou este jogo não possui suporte para isto.</h5>
        </div>
    </g:else>

</div>


</body>
</html>