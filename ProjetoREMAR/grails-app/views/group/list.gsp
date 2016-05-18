<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 5/17/16
  Time: 9:01 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
        <div class="row">
            <div class="col l10 offset-l1">
                <g:if test="${groups.empty}">
                    <h5>Você ainda não possui nenhum grupo criado :(</h5>
                </g:if>
                <g:else>
                    %{--TODO -> show all groups with cards--}%
                </g:else>
            </div>
        </div>

        <div class="row">
            <div class="col l3 offset-l4">
                <a style="position: relative; left: 28em; top:17.5em;" data-tooltip="Novo grupo" href="/group/new" class="btn-floating btn-large my-orange tooltipped   "><i  class="material-icons large">add</i></a>
            </div>
        </div>

    </body>

</html>