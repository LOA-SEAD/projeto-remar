<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dashboard">
    <title>Atribuição de tarefas</title>
</head>
<body>

    <!-- script to trigger the modal -->
    <script>
    $(document).ready(function() {
        // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
        $('.modal-trigger').leanModal({
            dismissible: false,
            opacity: .5,
            ready: function() {
                //console.log("Modal openned");
            },
            complete: function() {
                //console.log("modal completed");
            }
        });

        fillUsers("");

        $("#userSearch").keyup(function() {
            console.log("keyup");
            fillUsers($("#userSearch").val())
        });

    });

    function fillUsers(filter) {
        if($("#userSearch").val() == undefined) {
            filter = "";
        }

        $.ajax({
            type: 'POST',
            url: '/user/filteredUserList',
            data: {
                filter: filter
            }
        }).success(function(data) {
            console.log("ajax done");
            $('#users-content').html(data);
        });
    }
    </script>

    <!-- The modal code -->
    <div id="user-modal" class="modal">
        <div class="modal-content">
            <h4>Escolha um responsável</h4>
            <div class="row">
                <div class="header-search-wrapper">
                    <i class="mdi-action-search"></i>
                    <input type="text" id="userSearch" class="header-search-input z-depth-2" placeholder="Procure por pessoas" />
                </div>
            </div>
            <div class="row">
                <div id="users-content">



                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat green lighten-1" style="margin-left: 10px">Escolher</a>
            <a href="#!" class="modal-action modal-close waves-effect waves-red btn-flat bg-gray lighten-1">Cancelar</a>
        </div>
    </div>


    <g:each in="${tasks}" var="task">
        <div class="col s12 m6 l4">
            <div class="card z-depth-1-half">
                <div class="card-header red">
                    <div class="card-title">
                        <h5 class="task-name truncate">${task.name}</h5>
                        <p class="task-status">Sem usuário responsável</p>
                        <a class="modal-trigger" href="#user-modal"><img class="circle profile-picture right" src="/images/avatars/female.png?v=2"/></a>
                    </div>
                </div>
                <div class="card-content">
                    <g:if test="${task.description != null}">
                        <p class="text-justify">${task.description}</p>
                    </g:if>
                    <g:else>
                        <p class="text-justify">Tarefa sem descrição.</p>
                    </g:else>
                </div> <!-- card-content -->
            </div> <!-- card -->
        </div> <!-- col -->
    </g:each>
</body>
</html>