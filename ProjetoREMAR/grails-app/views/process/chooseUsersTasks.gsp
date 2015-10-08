    <%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 10/06/15
  Time: 09:55
--%>

    <%@ page contentType="text/html;charset=UTF-8" %>
    <html>
    <head>
        <meta name="layout" content="materialize-layout">
    <!--<g:javascript src="help.js"/>-->
        <g:if test="${dev}">
            <script>window.dev = true</script>
        </g:if>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    </head>
    <body>


        <div class="row">
            <div class="col s12 m12 l12">
                <ul id="task-card" class="collection with-header">
                    <li class="collection-header light-green">
                        <h3 class="task-card-title">Tarefas</h3>
                    </li>
                    <g:each in="${alltasks}" status="i" var="task" >
                        <li class="collection-item">
                            <div class="row">
                                <div class="col l3">
                                    <div class="row">
                                        <b>Nome</b>
                                        <p>${task.getName()}</p>
                                    </div>
                                </div>

                                <div class="col l6">
                                    <div class="row">
                                        <b>Descrição</b>
                                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                                        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p>
                                    </div>
                                </div>


                                <!--<p>
                                    <input name="${task.getId()}"  id="userlabel" value="${userlabel}">
                                </p>-->



                                <div class="col l3">
                                    <div class="row">
                                        <b>Responsável</b>
                                    </div>
                                </div>
                                <!--<g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">
                                %{--<td>Pendente – <g:link target="_blank" uri="/${uri}/${task.taskDefinitionKey}" id="${task.getId()}">REALIZAR</g:link></td>--}%
                                    <p>Pendente – <a href="/frame/${uri}/${task.taskDefinitionKey}" >REALIZAR</a></p>

                                </g:if>
                                <g:elseif test="${task.getDelegationState().toString() == "PENDING"}">
                                    <p>Pendente</p>
                                </g:elseif>
                                <g:elseif test="${task.getDelegationState().toString() == "RESOLVED"}">
                                    <p>Realizada – Aguardando aprovação – <g:link uri="/process/task/complete/${task.getId()}">APROVAR</g:link></p>
                                </g:elseif>
                                <g:elseif test="${task.getDelegationState().toString() == "null"}">
                                    <p>Sem usuário responsável</p>
                                </g:elseif>-->
                            </div>
                        </li>
                    </g:each>

                </ul>
            </div>

            <!--<div class="col s12 m12 l6">
                <ul id="task-card" class="collection with-header max-height-180 overflow-y">
                    <li class="collection-header orange lighten-1">
                        <h3 class="task-card-title">Pessoas</h3>
                    </li>
                    <li class="collection-item">
                        <div class="row">
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                            <div class="col s4">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt="Foto" class="circle responsive-img valign" />
                            </div>
                        </div>
                    </li>
                </ul>
            </div>-->
        </div>

<script>
    /*$("input").on('keyup', function () {
        var url = location.origin + '/user/autocomplete';
        var data = {autocomplete: $(this).val()};

        $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (data) {

                if (data != "") {

                    $("input").autocomplete({
                        source: data.split(","),
                        minLength: 3
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    });*/
</script>


</body>
</html>