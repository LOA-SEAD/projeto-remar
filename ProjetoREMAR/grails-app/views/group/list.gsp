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
        <div class="col l12 s12 m12">
            <ul class="tabs">
                <li class="tab"><a href="#my-groups">Sou dono</a></li>
                <li class="tab"><a href="#others-groups">Sou membro</a></li>
            </ul>
        </div>
    </div>
    <div id="my-groups">
        <div style="position: relative; left: 1em" class="row">
            <g:if test="${groupsIOwn.empty}">
                <h5>Você ainda não possui nenhum grupo criado :(</h5>
            </g:if>
                <g:else>
                        <g:each var="group" in="${groupsIOwn}">
                            <a href="/group/show/${group.id}">
                                <div style="padding-bottom: 8.0em;" class="card white col l3 s6 m3 offset-s3 hoverable">
                                    <div class="card-image">
                                        %{--TODO--}%
                                    </div>
                                    <div style="top: 3.2em; position: relative;" class="card-content">
                                        <p>${group.name}</p>
                                    </div>

                                </div>
                            </a>
                        </g:each>
                </g:else>
                <a style="color: black;" class="" href="/group/new">
                    <div style="padding-bottom: 4.5em;" data-tooltip="Novo grupo" class="card col l3 s6 m3 offset-s3 hoverable grey lighten-2 tooltipped">
                        <div class="card-content grey lighten-2">

                            <div class="row">
                                <div class="center">
                                    <i style="font-size: 3.2em; position: relative; top: 1.0em;" class="material-icons">add_circle</i>
                                </div>
                            </div>

                        </div>
                    </div>
                </a>
        </div>
    </div>

    <div id="others-groups">
        <div class="row">
            <g:form action="addUser" method="post">
                <div class="col offset-l4 offset-s2 offset-m3">
                <div class="input-field col l6 s6">
                    <input name="membertoken" id="member-token" type="text" placeholder="Senha de acesso" required>
                    <label for="member-token"><i class="fa fa-search"></i></label>
                    %{--<input type="hidden" value="${group.id}" name="groupid">--}%
                    %{--<input type="hidden" value="" id="user-id" name="userid">--}%
                </div>
                <div class="col l6 s4 m6">
                    <button type="submit" style="font-size: 0.8em; top: 1.4em; position:relative;"  class="btn waves-effect waves-light">Entrar
                        <i class="material-icons right">group_add</i>
                    </button>
                </div>
                </div>
            </g:form>
        </div>
         <div class="row">

            <g:if test="${groupsIBelong.empty}">
                <h5 class="center-align">Você ainda não pertence a um grupo :(</h5>
            </g:if>
            <g:else>
                <g:each var="group" in="${groupsIBelong}">
                    <a href="/group/show/${group.id}">
                        <div style="padding-bottom: 8.0em;" class="card white col l3 s6 m3 offset-s3 hoverable">
                            <div class="card-image">
                                %{--TODO--}%
                            </div>
                            <div style="top: 3.2em; position: relative;" class="card-content">
                                <p>${group.name}</p>
                            </div>

                        </div>
                    </a>
                </g:each>
            </g:else>

        </div>

    </div>
    <script>
        $(document).ready(function(){
            $('ul.tabs').tabs();
        });
    </script>
    </body>


</html>