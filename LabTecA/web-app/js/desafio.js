/**
 * Created by garciaph on 22/02/17.
 */


$(document).ready(function() {
    // Faz aparecer o select
    $('select').material_select();

    // Materialize Transition
    $(function() {
        $("#composto").change(function() {
            //alert( $('option:selected', this).text() );
            $('#staggered-test').css("display", "block")
            Materialize.showStaggeredList('#staggered-test');

            // Seleciona o tipo do composto automaticamente para o desafio 1
            var composto = $('#composto').find(":selected").val();
            var url = location.origin + '/labteca/composto/getTipoComposto/' + composto;
            var data = {_method: 'GET'};

            $.ajax({
                    type: 'GET',
                    data: data,
                    url: url,
                    success: function (returndata) {
                       switch (returndata){
                            case 'Sal':
                                $("#tipo0").prop("checked", true);
                                break;
                            case 'Base':
                                $("#tipo1").prop("checked", true);
                                break;
                            case 'Ácido':
                                $("#tipo2").prop("checked", true);
                                break;
                            case 'Orgânico':
                                $("#tipo3").prop("checked", true);
                                break;
                            case 'Etc':
                                $("#tipo4").prop("checked", true);
                                break;
                            default :
                                console.log("Alternativa correta inválida");
                                break;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log("Error, não retornou a instância");
                    }
                }
            );

            // Seleciona o nome do composto automaticamente para o desafio 2
            var url = location.origin + '/labteca/composto/getNomeComposto/' + composto;
            var data = {_method: 'GET'};

            $.ajax({
                    type: 'GET',
                    data: data,
                    url: url,
                    success: function (returndata) {
                        $("#composto-nome").prop("placeholder", "");
                        $("#composto-nome").val(returndata);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log("Error, não retornou a instância");
                    }
                }
            );

            // Seleciona a fórmula do composto automaticamente para o desafio 3
            var url = location.origin + '/labteca/composto/getFormulaComposto/' + composto;
            var data = {_method: 'GET'};

            $.ajax({
                    type: 'GET',
                    data: data,
                    url: url,
                    success: function (returndata) {
                        $("#composto-formula").prop("placeholder", "");
                        $("#composto-formula").val(returndata);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log("Error, não retornou a instância");
                    }
                }
            );

        });
    });

    // Materialize Collapsible
    $('.collapsible').collapsible();
});

