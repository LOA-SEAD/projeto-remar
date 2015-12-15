<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 10/8/15
  Time: 4:19 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dashboard">
    <title>Gerenciamento de tarefas</title>
</head>

<body>
    <!-- javascript to load modals -->
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
                fillUsers($("#userSearch").val())
            });

        });

        function fillUsers(filter) {
            if($("#userSearch").val() == undefined) {
                filter = "";
            }

            /*
            * <div class="preloader-wrapper big active">
             <div class="spinner-layer spinner-blue">
             <div class="circle-clipper left">
             <div class="circle"></div>
             </div><div class="gap-patch">
             <div class="circle"></div>
             </div><div class="circle-clipper right">
             <div class="circle"></div>
             </div>
             </div>

             <div class="spinner-layer spinner-red">
             <div class="circle-clipper left">
             <div class="circle"></div>
             </div><div class="gap-patch">
             <div class="circle"></div>
             </div><div class="circle-clipper right">
             <div class="circle"></div>
             </div>
             </div>

             <div class="spinner-layer spinner-yellow">
             <div class="circle-clipper left">
             <div class="circle"></div>
             </div><div class="gap-patch">
             <div class="circle"></div>
             </div><div class="circle-clipper right">
             <div class="circle"></div>
             </div>
             </div>

             <div class="spinner-layer spinner-green">
             <div class="circle-clipper left">
             <div class="circle"></div>
             </div><div class="gap-patch">
             <div class="circle"></div>
             </div><div class="circle-clipper right">
             <div class="circle"></div>
             </div>
             </div>
             </div>*/

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

    <!-- Modal with fixed footer -->
    <div id="modal" class="modal modal-fixed-footer">
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


    <div class=" col s12 m6 l4">
        <div class="card white z-depth-1-half">
            <div class="card-content">
                <span class="card-title black-text">Banco de questões</span>
                <div class="row">
                    <div class="col l6">
                        <p>Lorem ipsum dolor sit amet, novum dicam eu nam. Sit ut errem diceret, mel nulla sanctus delectus ad.</p>
                    </div>
                    <div class="col l6 center">
                        <p>Responsável:</p>
                        <a class="modal-trigger" href="#modal">
                            <img class="circle profile-picture" src="/images/avatars/default.png"/>
                        </a>

                        <br><p>Matheus</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class=" col s12 m6 l4">
        <div class="card white z-depth-1-half">
            <div class="card-content">
                <span class="card-title black-text">Criar/escolher tema</span>
                <div class="row">
                    <div class="col l6">
                        <p>Lorem ipsum dolor sit amet, novum dicam eu nam. Sit ut errem diceret, mel nulla sanctus delectus ad.</p>
                    </div>
                    <div class="col l6 center">
                        <p>Responsável:</p>
                        <a class="modal-trigger" href="#modal">
                            <img class="circle profile-picture" src="/images/avatars/default.png"/>
                        </a>
                        <br>Matheus
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class=" col s12 m6 l4">
        <div class="card white z-depth-1-half">
            <div class="card-content">
                <span class="card-title black-text">Lorem ipsum</span>
                <div class="row">
                    <div class="col l6">
                        <p>Lorem ipsum dolor sit amet, novum dicam eu nam. Sit ut errem diceret, mel nulla sanctus delectus ad.</p>
                    </div>
                    <div class="col l6 center">
                        <p>Responsável:</p>
                        <a class="modal-trigger" href="#modal">
                            <img class="circle profile-picture" src="/images/avatars/default.png"/>
                        </a>
                        <br>Matheus
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>