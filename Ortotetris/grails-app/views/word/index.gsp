<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="../css/materialize.css" media="screen,projection"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css">


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


<div class="container">

    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            <i class="small material-icons left">grid_on</i>Tabela de Palavras
        </p>
    </div>

    <div class="row">
        <div class="col s3 offset-s9">
            <input type="text" id="SearchLabel" placeholder="Buscar"/>
        </div>
    </div>

    <div class="row">
        <div class="col s12">
            <div id="ShowWord">

            </div>
        </div>

    </div>

    <section id="TableWordList">
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
            <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="save"
                    onclick="submit()">Enviar
                <i class="material-icons right">send</i>
            </button>
        </div>

        <div class="col s1 offset-s9">
            <a data-target="createModal" name="create"
               class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange"><i
                    class="material-icons">add</i></a>
        </div>
    </div>

</div>



<!-- Modal Structure -->
<div id="createModal" class="modal">
    <div class="modal-content">
        <h4>Criar Palavra</h4>

        <div class="row">
            <div class="row" id="buttonDiv">
                <div class="input-field col s6 offset-s3" id="parametersNewWord">
                    <input id="NewWordLabel" type="text" name="answer"> <label
                        for="NewWordLabel">Digite uma nova palavra</label>
                    <input type="hidden" value="none" name="word"> <label></label>
                    <input type="hidden" value="0" name="initialPosition"> <label></label>
                </div>
            </div>
            <button onclick="SaveNewWord()" class="btn btn-success btn-lg my-orange">Criar</button>

        </div>
    </div>
</div>

<!-- Modal Structure -->
<div id="showModal" class="modal">
    <div class="modal-content">
        <div class="row"></div>
        <div class="row"></div>

        <div class="row"  id="showWordModal">


        </div>

    </div>
    <div class="modal-footer">
    </div>
</div>

<script type="text/javascript" defer="defer">
    $(document).ready(function () {

        $('.modal-trigger').leanModal({
            ready: function () {
            },
            complete: function () {

            }
        });


    });


    function right(id) {
        var parameters = {"id": id};
        <g:remoteFunction action="move_to_right" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
    }

    function left(id) {
        var parameters = {"id": id};
        <g:remoteFunction action="move_to_left" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>

    }

    function mark_letter(id, pos) {
        var parameters = {"id": id, "pos": pos};
        <g:remoteFunction action="mark_letter" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
    }

    function clear_letter(id, pos) {
        var parameters = {"id": id, "pos": pos};
        <g:remoteFunction action="clear_position" params="parameters" update="TableWordList" onComplete="AutoClickButton(id)"/>
    }

    function SaveToJson() {
        var list="";
        var trs = document.getElementById('ListTable').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        console.log(trs.length);
        for (var i = 0; i < trs.length; i++) {
            if ($(trs[i]).attr('data-checked') == "true") {
                list += $(trs[i]).attr('data-id') + ',';
            }
        }

        var parameters = {"ids": list }
        <g:remoteFunction action="toJson" params="parameters"  />
    }

    function SaveNewWord() {
        var ans = document.getElementById("NewWordLabel").value;
        var node = document.getElementById("ShowWord");
        var parameters = {"answer": ans, "word": "none", "initial_position": 0};
        <g:remoteFunction action="save" params="parameters" update="TableWordList"/>
        $('#NewWordLabel').val("");
        $('#createModal').closeModal();
    }


</script>

</body>
</html>