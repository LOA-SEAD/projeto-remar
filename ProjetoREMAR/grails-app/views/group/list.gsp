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
            <div class="cluster-header">
                <p class="text-teal text-darken-3 left-align margin-bottom">
                    <i class="small material-icons left">people</i>Meus grupos
                </p>
                <div class="divider"></div>
            </div>
            <div class="col l12">
                <a style="color: black;" class="" href="/group/new">
                    <div style="padding-bottom: 6em;" data-tooltip="Novo grupo" class="card col l3 s6 offset-s3 hoverable grey lighten-2 tooltipped">
                        <div class="card-content grey lighten-2">

                            <div class="row">
                                <div class="center">
                                    <i style="font-size: 3.2em; position: relative; top: 1.2em;" class="material-icons">add_circle</i>
                                </div>
                            </div>

                        </div>
                    </div>
                </a>
                <g:if test="${groups.empty}">
                    <h5>Você ainda não possui nenhum grupo criado :(</h5>
                </g:if>
                <g:else>
                        <g:each var="group" in="${groups}">
                            <a href="/group/show/${group.id}">
                                <div style="padding-bottom: 8.0em;" class="card white col l3 s6 offset-s3 hoverable">
                                    <div class="card-image">
                                        %{--TODO--}%
                                    </div>
                                    <div style="top: 3.2em; position: relative;" class="card-content">
                                        <p>Nome: ${group.name}</p>
                                            <p>Dono: ${group.owner.firstName +' '+ group.owner.lastName} </p>
                                    </div>

                                </div>
                            </a>
                        </g:each>
                </g:else>
            </div>
        </div>

        %{--<div class="row">--}%
            %{--<div class="col l3 offset-l4">--}%
                %{--<a style="position: relative; left: 28em; bottom: 2.3em;" data-tooltip="Novo grupo" href="/group/new" class="btn-floating btn-large my-orange tooltipped   "><i  class="material-icons large">add</i></a>--}%
            %{--</div>--}%
        %{--</div>--}%

    </body>

</html>