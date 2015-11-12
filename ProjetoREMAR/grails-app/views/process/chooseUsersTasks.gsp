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
    <div id="user-modal" class="modal modal-fixed-footer">
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

    <div class="container">
        <ul class="collection with-header">
            <li class="collection-header">
                <h4>Tarefas pendentes</h4>
            </li>
            <g:each in="${tasks}" var="task">
                <li class="collection-item">
                    <div class="row valign-wrapper">
                        <div class="col s3 m2 l2 center">
                            <a class="modal-trigger" href="#user-modal">
                                <img src="http://demo.geekslabs.com/materialize/v2.1/layout01/images/avatar.jpg" alt class="circle my-img" />
                                <br />
                                <p class="no-margin truncate">Matheus<br />Fernandes</p>
                            </a>
                        </div>
                        <div class="col s9 m10 l10">
                            <span class="title">${task.name}SSDASD S</span>
                            <p>Tarefa sem descrição. A Bia só clicou o botao direito da playlist e enviou o link para a galera. A paz reinou novamente até o Rafa se meter!</p>
                        </div>
                        <div class="secondary-content">
                            <a href="#"><i class=" small mdi-content-send"></i></a>
                        </div>
                    </div>
                </li>




            </g:each>
        </ul>
    </div>
</body>
</html>