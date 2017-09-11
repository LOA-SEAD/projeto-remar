<%@ page import="br.ufscar.sead.loa.remar.User" contentType="text/html;charset=UTF-8" %>

<table class="bordered highlight responsive-table" style="width: auto">
<thead>

    <g:each in="${groupStats.entrySet().toArray()}" var="it">
        <g each in="${it.getValue()}" var="aaa">
            ${aaa}<br>
        </g><br>
    </g:each>
<tbody>

    %{--<g:each in="${groupStats}" var="user">
        <tr>
            <g:if test="${user.get(0) instanceof User}">
                <td style="padding-left: 1.80em;">${user.get(0).firstName + " " + user.get(0).lastName}</td>
                <g:each in="${1..user.get(1).gameSize}">
                    <td></td>
                </g:each>
            </g:if>
            <g:else>
                <td style="padding-left: 1.80em;">${user.get(0).firstName + " " + user.get(0).lastName}</td>
                <g:each in="${0..user.get(1).gameSize-1}" var="i">

                    <g:set var="levelWon" value="${stats.find { stats.levelId == i && stats.win == true}}"/>
                    <g:set var="levelLose" value="${stats.find { stats.levelId == i && stats.win == false}}"/>

                    <g:if test="${levelWon}">
                        <td style="padding-left: 1.80em;"> <a href="/group/user-stats/${stats.user.id}?exp=${exportedResource.id}&level=${levelWon.levelId}"><i style="color: green" class="fa fa-check-square"></i></a> </td>
                    </g:if>

                    <g:elseif test="${levelLose}">
                        <td style="padding-left: 1.80em;"> <a href="/group/user-stats/${stats.user.id}?exp=${exportedResource.id}&level=${levelLose.levelId}"> <i style="color: red" class="fa fa-times"></i> </a></td>
                    </g:elseif>
                    <g:else>
                        <td></td>
                    </g:else>

                </g:each>
            </g:else>
        </tr>
    </g:each> --}%

    </tbody>
</table>