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
                <g:render template="userGameTypes/${allStats.get(0).gameType}" />
            </li>
        </ul>
    </div>
</div>

</body>
</html>