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
    <div class="col l12 offset-l2">
        <g:if test="${!allStats.empty}">
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
                            <g:if test="${stats.find { it.levelId == i && it.win == true}}">
                                <td style="padding-left: 1.80em;"> <i style="color: green" class="fa fa-check-square"></i> </td>
                            </g:if>
                            <g:elseif test="${stats.find { it.levelId == i && it.win == false}}">
                                <td style="padding-left: 1.80em;"> <i style="color: red" class="fa fa-times"></i> </td>
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
        </g:if>
    </div>
</div>


</body>
</html>