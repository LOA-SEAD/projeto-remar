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
        <div class="col l12 s11">
            <ul class="tabs">
                <li class="tab"><a href="#my-groups">Grupos que sou dono</a></li>
                <li class="tab"><a href="#others-groups">Grupos que sou membro</a></li>
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
            <div class="input-field col l3 offset-l3">
                <input name="membertoken" id="member-token" type="text" placeholder="Senha de acesso" required>
                <label for="member-token"><i class="fa fa-search"></i></label>
                %{--<input type="hidden" value="${group.id}" name="groupid">--}%
                %{--<input type="hidden" value="" id="user-id" name="userid">--}%
            </div>
            <div class="col l3">
                <button onclick="enterGroup()" style="font-size: 0.8em; top: 1.4em; position:relative;"  class="btn waves-effect waves-light">Entrar
                    <i class="material-icons right">group_add</i>
                </button>
            </div>
        </div>
         <div style="position: relative; left: 1em" class="row">

            <g:if test="${groupsIBelong.empty}">
                <h5>Você ainda não pertence a um grupo :(</h5>
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

        function enterGroup(){
            $.ajax({
                type:'POST',
                url:"/group/addUser",
                data: {
                    token: $("#member-token").val()
                },
                success: function(data) {
                    console.log(data);
                    console.log("success");
//                window.location.reload();
                }
            })
        }
    </script>
    </body>


</html>