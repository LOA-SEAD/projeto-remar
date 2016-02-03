<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="../css/materialize.css"  media="screen,projection"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}"	type="text/css">


    <!--Let browser know website is optimized for mobile-->
    <meta name="layout" content="main"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Ortotetris</title>
</head>

<body>
<!--Import jQuery before materialize.js-->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
%{--<script type="text/javascript" src="../js/materialize.min.js"></script>--}%
<script type="text/javascript" src="${resource(dir: 'js', file: 'materialize.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'principal.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'order.js')}"></script>





%{--<%@ page import="br.ufscar.sead.loa.remar.Word" %>--}%
%{--<%@ page contentType="text/html;charset=UTF-8" %>--}%
%{--<!DOCTYPE html>--}%
%{--<html>--}%
%{--<head>--}%
	%{--<meta name="layout" content="main"/>--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">--}%

    %{--<link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>--}%
	%{--<link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>--}%
	%{--<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">--}%
	%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}"	type="text/css">--}%
	%{--<!--Import Google Icon Font-->--}%
	%{--<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">--}%
	%{--<!--Import materialize.css-->--}%

	%{--<!--Let browser know website is optimized for mobile-->--}%
	%{--<meta name="viewport" content="width=device-width, initial-scale=1.0"/>--}%

	%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'materialize.css')}"	type="text/css" media="screen,projection">--}%
	%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'external-styles.css')}"	type="text/css">--}%
	%{--<!--Import jQuery before materialize.js-->--}%
	%{--<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>--}%



%{--</head>--}%

<div class="container">

    <nav class="layout-top-nav">
        <div class="nav-wrapper">
            <h3>Ortotetris</h3>
        </div>
    </nav>

    <div class="row">
    </div>

    <div class="row">
        <div class="col s3 offset-s9">
            <input  type="text" id="SearchLabel" placeholder="Buscar"/>
        </div>
    </div>

    <div class="row">
        <div class="col s12">
            <div id="ShowWord">

            </div>
        </div>

    </div>

    <section id="TableWordList" >
        <g:render template="list"/>
    </section>

    <div class="row">
        <div class="col s12">

        </div>
    </div>

    <div class="row">
        <div class="col s12">

        </div>
    </div>

    <div class="row">
        <div class="col s2">
            <button class="btn waves-effect waves-light" type="submit" name="save" id="save" onclick="SaveToJson()">Enviar
                <i class="material-icons right">send</i>
            </button>
        </div>
        <div class="col s1 offset-s9">
            <a data-target="createModal"  name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger"><i class="material-icons">add</i></a>
        </div>
    </div>

</div>



    <!-- Modal Structure -->
    <div id="createModal" class="modal">
        <div class="modal-content">
            <h4>Criar Palavra</h4>
            <div class="row">
                %{--<g:form url="[resource:wordInstance, action:'save']" >--}%
                <div class="row">
                    <div class="input-field col s6 offset-s3" id="parametersNewWord">
                        <input id="NewWordLabel" type="text" name="answer"> <label for="NewWordLabel">Digite uma nova palavra</label>
                        <input type="hidden" value="none" name="word"> <label></label>
                        <input type="hidden" value="0" name="initialPosition"> <label></label>
                    </div>
                </div>
                <button onclick="SaveNewWord()" class="btn btn-success btn-lg">Criar</button>
                %{--</g:form>--}%
            </div>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="showModal" class="modal">
        <div class="modal-content">

            <div id="showWordModal">


            </div>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div id="warningLabel">

            </div>
        </div>
        <div class="modal-footer">
            <button id="deleteButton" class="btn waves-effect waves-light modal-close">Sim</button>
            <button class="btn red waves-effect waves-light modal-close">Não</button>

        </div>
    </div>




    <script type="text/javascript" defer="defer">
    $(document).ready(function() {
        $('.modal-trigger').leanModal({
            complete: function() {
                window.location.reload();

            }
        });



//        $('#showModal').leanModal({
//                    dismissible: true, // Modal can be dismissed by clicking outside of the modal
//                    opacity: .5, // Opacity of modal background
//                    in_duration: 300, // Transition in duration
//                    out_duration: 200, // Transition out duration
//                    ready: function() { alert('Ready'); }, // Callback for Modal open
//                    complete: function() { alert('Closed'); } // Callback for Modal close
//                }
//        );

    });


        function right(id){
            var parameters = {"id": id};
            <g:remoteFunction action="move_to_right" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
        }

        function left(id){
            var parameters = {"id": id};
            <g:remoteFunction action="move_to_left" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>

        }

        function mark_letter(id,pos){
            var parameters = {"id": id, "pos":pos};
            <g:remoteFunction action="mark_letter" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
        }

        function clear_letter(id,pos){
            var parameters = {"id": id, "pos":pos};
            <g:remoteFunction action="clear_position" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
        }

        function SaveToJson(){
            <g:remoteFunction action="toJsonAnswer" update="MessageDiv"/>
            <g:remoteFunction action="toJsonWord" update="MessageDiv" />
        }

        function SaveNewWord(){
            var ans = document.getElementById("NewWordLabel").value;
            var node = document.getElementById("ShowWord");
            var parameters = {"answer": ans, "word": "none", "initial_position":0};
            <g:remoteFunction action="save" params="parameters" update="TableWordList"/>
            $('#createModal').closeModal({
                complete: function() { alert('Closed'); } // Callback for Modal close
            });
        }

        function WordDelete(id){
            $('#warningLabel').empty();
            $("#warningLabel").append("<div> <p> Você tem certeza ?  </p> </div>");
            $('#deleteModal').openModal({
                complete: function(){
                    window.location.reload();
                }
            });
            $('#deleteButton').click(function(){

                var parameters = {"id":id};
                <g:remoteFunction action="WordDelete" params="parameters" update="TableWordList"/>
            });
        }



    </script>



</body>
</html>