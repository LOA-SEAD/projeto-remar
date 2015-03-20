 $(function() {
            var dialog, form = document.forms[0],
                    questao = $("#questao"),
                    resposta = $("#resposta"),
                    contribuicao = $("#contribuicao"),
                    allFields = $([]).add(questao).add(resposta).add(contribuicao);


            function addQuestion() {
                var valid = true;
                allFields.removeClass( "ui-state-error" );
                if ( valid ) {
                    $("#questoes tbody" ).append( "<tr>" +
                    "<td>" + questao.val() + "</td>" +
                    "<td>" + resposta.val() + "</td>" +
                    "<td>" + contribuicao.val() + "</td>" +
                    "</tr>" );
                    dialog.dialog( "close" );

                    jQuery.ajax({
                        url: "/ProjetoREMAR/palavras/save",
                        type: "POST",
                        data: {resposta: "resposta", dica: "questao", contribuicao: "contribuicao" }


                    });

                    //console.log(questao.val());
                }
                // console.log(contribuicao.val());
                return valid;
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
