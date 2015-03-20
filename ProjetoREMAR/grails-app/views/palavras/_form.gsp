<!doctype html>
<%@ page import="projetoremar.Palavras" %>
<html>
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <style>
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }


    .ui-dialog .ui-state-error { padding: .3em; }
    </style>

    <script type="text/javascript">
        $(function() {
            var dialog, form = document.forms[0],
                    questao = $("#questao"),
                    resposta = $("#resposta"),
                    contribuicao = $("#contribuicao"),
                    allFields = $([]).add(questao).add(resposta).add(contribuicao);


            function addQuestion() {

                    jQuery.ajax({
                        url: "/ProjetoREMAR/palavras/save",
                        type: "POST",
                        data: {resposta: resposta.val(), dica: questao.val(), contribuicao: contribuicao.val()}

                    });

                    dialog.dialog( "close" );
                    //console.log(questao.val());

                // console.log(contribuicao.val());

            }
            dialog = $( "#dialog-form" ).dialog({

                autoOpen: false,
                height: 300,
                width: 500,
                modal: true,
                buttons: {
                    "Salvar Questão": addQuestion,
                    Cancel: function() {
                        dialog.dialog( "close" );
                    }
                },
                close: function() {

                    allFields.removeClass( "ui-state-error" );
                }
            });

            form = dialog.find( "form" ).on( "button", function( event ) {
                event.preventDefault();
                addQuestion();
            });

            $( "#create-question" ).button().on( "click", function() {
                dialog.dialog( "open" );
            });
        });
    </script>
</head>
<body>
<div id="dialog-form" title="Nova Questão" >
    <g:form>
        <fieldset>
            <label for="questao">Questão</label>

            <input type="text" name="questao" id="questao" value="${questao}" class="text ui-widget-content ui-corner-all"/>

            <label for="resposta">Resposta</label>
            <input type="text" name="resposta" value="${resposta}"  id="resposta" class="text ui-widget-content ui-corner-all"/>
            <label for="contribuicao">Contribuição</label>
            <input type="text" name="contribuicao" id="contribuicao" value="${contribuicao}" class="text ui-widget-content ui-corner-all"/>

            <!-- Allow form submission with keyboard without duplicating the dialog button -->
            <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
        </fieldset>
    </g:form>
</div>
<div id="users-contain" class="ui-widget">
    <h1>Lista de Questões:</h1>
    <table id="questoes" class="ui-widget ui-widget-content">
        <thead>
        <tr class="ui-widget-header ">

            <th>Questão</th>
            <th>Resposta</th>
            <th>Contribuicao</th>
        </tr>
        </thead>
        <tbody>
        </tbody>

    </table>
</div>

<button type="button"  id="create-question">Nova Questão</button>


</body>

