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
                    console.log("Modal openned");
                },
                complete: function() {
                    console.log("modal completed");
                }
            });
        });
    </script>

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
                        <a class="modal-trigger" href="#modal1">
                            <img class="circle profile-picture" src="/images/avatars/male.png"/>
                        </a>

                        <br><p>Matheus</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal with fixed footer -->
    <div id="modal1" class="modal modal-fixed-footer">
        <div class="modal-content">
            <h4>Modal Header</h4>
            <p>A bunch of text</p>
        </div>
        <div class="modal-footer">
            <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat green">Escolher</a>
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
                        <a class="modal-trigger" href="#modal2">
                            <img class="circle profile-picture" src="/images/avatars/male.png"/>
                        </a>
                        <br>Matheus
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Modal with fixed footer -->
    <div id="modal2" class="modal modal-fixed-footer">
        <div class="modal-content">
            <h4>Modal Header</h4>
            <p>A bunch of text</p>
        </div>
        <div class="modal-footer">
            <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat green">Escolher</a>
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
                        <img class="circle profile-picture" src="/images/avatars/male.png"/>
                        <br>Matheus
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>