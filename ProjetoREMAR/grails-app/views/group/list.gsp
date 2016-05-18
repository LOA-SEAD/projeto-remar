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
                    <div class="cluster-header">
                        <p class="text-teal text-darken-3 left-align margin-bottom">
                            <i class="small material-icons left">people</i>Meus grupos
                        </p>
                        <div class="divider"></div>
                    </div>
                    <div class="row">
                        <g:each var="group" in="${groups}">
                            <div class="card white col l4">
                                <div class="card-image">
                                    %{--TODO--}%
                                </div>
                                <div class="card-content">
                                    <a href="/group/show/${group.id}"><p>Nome: ${group.name}</p></a>
                                    <g:each var="owner" in="${group.owners}">
                                        <p>Dono(s): ${owner.firstName +' '+ owner.lastName} </p>
                                    </g:each>
                                </div>

                        </div>
                        </g:each>
                    </div>

                </g:else>
            </div>
        </div>

        <div class="row">
            <div class="col l3 offset-l4">
                <a style="position: relative; left: 28em; bottom: 10.3em;" data-tooltip="Novo grupo" href="/group/new" class="btn-floating btn-large my-orange tooltipped   "><i  class="material-icons large">add</i></a>
            </div>
        </div>

    </body>

</html>