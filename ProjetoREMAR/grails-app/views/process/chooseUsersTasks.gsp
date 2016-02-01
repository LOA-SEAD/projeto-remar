<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 07/08/15
  Time: 08:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    td a {
        display:block;
        width:100%;
    }
    </style>

    <meta name="layout" content="materialize-layout">
    <title>Customizando Jogo</title>

</head>
<body>
<div class="row cluster">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">games</i>${nameProcess}
        </p>
        <div class="divider"></div>
    </div>
    <div class="row show">
        <article class="row">
            %{--<h5 class="center"> Jogos em customização</h5>--}%
            <ul class="collapsible popout" data-collapsible="accordion">
                <li>
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    <div class="collapsible-header active"> <i class="material-icons">info_outline</i>Informações básicas</div>
                    <div class="collapsible-body">
                        <div class="row">
                            <div class="input-field col s6">
                                <input value="${nameProcess}" id="game_name" type="text" class="validate">
                                <label class="active" for="game_name">Nome do jogo</label>
                            </div>
                            <div class="input-field col s6">
                                <select>
                                    <option value="1" selected>Todas</option>
                                    <option value="2">Ação</option>
                                    <option value="3">Aventura</option>
                                    <option value="4">Educacional</option>
                                </select>
                                <label>Escolha uma categoria</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s2 img-preview">
                                <img id="img1Preview" class="materialboxed" width="100" height="100" />
                            </div>
                            <div class="col s10">
                                <div class="file-field input-field">
                                    <div class="btn waves-effect waves-light my-orange">
                                        <span>File</span>
                                        <input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text" placeholder="Imagem do jogo" id="img-1-text" readonly >
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s6">
                                <p class="title">Plataformas: </p>
                                <div class="divider"></div>
                                <p>
                                    <input type="checkbox" id="web" checked="checked" />
                                    <label for="web" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Web"><i class="fa fa-globe" ></i></label>
                                </p>

                                <p>
                                    <input type="checkbox" id="android"/>
                                    <label for="android" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Android"><i class="fa fa-android"></i></label>
                                </p>
                                <p>
                                    <input type="checkbox" id="linux"/>
                                    <label for="linux" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Linux"><i class="fa fa-linux"></i></label>
                                </p>
                                <p>
                                    <input type="checkbox" id="moodle"/>
                                    <label  for="moodle" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Moodle"><i class="fa fa-graduation-cap"></i></label>
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12" >
                                %{--<div id="preloader-wrapper" class="preloader-wrapper small active right">--}%
                                    %{--<div class="spinner-layer spinner-red-only">--}%
                                        %{--<div class="circle-clipper left">--}%
                                            %{--<div class="circle"></div>--}%
                                        %{--</div><div class="gap-patch">--}%
                                        %{--<div class="circle"></div>--}%
                                    %{--</div><div class="circle-clipper right">--}%
                                        %{--<div class="circle"></div>--}%
                                    %{--</div>--}%
                                    %{--</div>--}%
                                %{--</div>--}%
                                <div class="send-war right">
                                    <a href="#!" data-position="bottom" data-delay="5" data-tooltip="Enviar" class="waves-effect waves-light btn-flat send">
                                        Enviar
                                        %{--<i class="material-icons send-icon" style="color: green;">done</i>--}%
                                    </a>
                                </div>
                            </div>
                            <br class="clear" />
                        </div>
                    </div>
                </li>
                <li>
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    <div class="collapsible-header"><i class="material-icons">list</i>Tarefas </div>
                    <div class="collapsible-body">
                         <table class="striped responsive-table">
                            %{--<thead>--}%
                            %{--<tr>--}%
                            %{--<th data-field="id">Nome da tarefa</th>--}%
                            %{--<th data-field="name">status</th>--}%
                            %{--</tr>--}%
                            %{--</thead>--}%
                        <tbody>
                            <g:each in="${tasks}" var="task">
                                    <tr class="pending">
                                        <td class="">
                                            <a href="/frame/${uri}/${task.taskDefinitionKey}">
                                                ${task.getName()}
                                                %{--${task.taskDefinitionKey}--}%
                                            </a>
                                        </td>

                                        %{--<td> <i class="small material-icons right tooltipped" data-position="right" data-delay="50" data-tooltip="Pendente">warning</i></td>--}%

                                        %{--<g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">--}%
                                        <g:if test="${task.getDelegationState().toString() == "PENDING"}">
                                            <td>Pendente – <a href="/frame/${uri}/${task.taskDefinitionKey}" >REALIZAR</a></td>
                                        </g:if>
                                        <g:elseif test="${task.getDelegationState().toString() == "RESOLVED"}">
                                            <td>Realizada – Aguardando aprovação – <g:link uri="/process/task/complete/${task.getId()}">APROVAR</g:link></td>
                                        </g:elseif>
                                        %{--<g:elseif test="${task.getDelegationState().toString() == "null"}">--}%
                                            %{--<td>Sem usuário responsável</td>--}%
                                        %{--</g:elseif>--}%
                                    </tr>
                                    %{--${task.getName()} <br>--}%
                                    %{--<tr role="row">--}%
                                    %{--<td>${task.getName()} </td>--}%
                                    %{--<td>--}%
                                    %{--<g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">--}%
                                    %{--<input name="${task.getId()}"  id="userlabel" value="${task.getAssignee()}">--}%
                                    %{--</g:if>--}%
                                    %{--<g:else>--}%
                                    %{--<input name="${task.getId()}"  id="userlabel" value="${currentUser.username}">--}%
                                    %{--</g:else>--}%
                                    %{--</td>--}%
                            </g:each>
                        </tbody>
                        </table>
                    </div>
                <!-- pensar um algum método para mostrar processo ativo ou desativado-->
                %{--<g:if test="${!process[2]}">--}%
                %{--<td>Ativo</td>--}%
                %{--</g:if>--}%
                </li>
            </ul>
        </article>
    </div>
</div>
<g:javascript src="menu.js"/>
<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
<script>
    $(document).ready(function(){
        $('.collapsible').collapsible({
            accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
        });
        $('.tooltipped').tooltip({delay: 50});
    });
</script>
</body>
</html>
