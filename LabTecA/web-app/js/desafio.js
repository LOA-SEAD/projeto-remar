/**
 * Created by garciaph on 22/02/17.
 */

var isCollapsibleVisible = false;

$(document).ready(function() {
    // Inicializações
    $('select').material_select();
    $('.collapsible').collapsible();
    $('.modal-trigger').leanModal();
});


window.onload = function() {

    $('#submitButton').click(function() {
        if (!isEmpty($('#volume-inicial').val()) &&
            !isEmpty($('#molaridade-inicial').val()) &&
            !isEmpty($('#volume-final').val()) &&
            !isEmpty($('#molaridade-final').val())) {

            var compostoInstance = $('#composto').val();
            var volInicial = $('#volume-inicial').val();
            var molInicial = $('#molaridade-inicial').val();
            var volFinal = $('#volume-final').val();
            var molFinal = $('#molaridade-final').val();

            // Chama controlador para salvar o desafio em um arquivo .json e no banco de dados
            $.ajax({
                type: 'POST',
                traditional: true,
                url: "/labteca/desafio/export",
                data: {compostoInstance: compostoInstance, volInicial: volInicial, molInicial: molInicial, volFinal: volFinal, molFinal: molFinal},
                success: function (returndata) {
                    window.top.location.href = returndata;
                },
                error: function (returndata) {
                    alert ("Error:\n" + returndata.responseText);
                    if (returndata.status == 401) window.top.location.href = document.referrer;
                }
            });

        } else {
            $('#errorSubmitingModal').openModal();
        }
    })

    // Seleção de um novo composto da lista de compostos
    $('#composto').change(function() {
        // Torna a lista de desafios visível
        if (!isCollapsibleVisible) {
            $('#staggered-test').css('display', 'block')
            Materialize.showStaggeredList('#staggered-test');
            isCollapsibleVisible = true;
        }

        if ($('#composto').val() != '') {
            // Seleciona o tipo do composto automaticamente para o desafio 1
            var composto = $('#composto').find(':selected').val();
            var url = location.origin + '/labteca/composto/getTipoComposto/' + composto;
            var data = {_method: 'GET'};

            $.ajax({
                    type: 'GET',
                    data: data,
                    url: url,
                    success: function (returndata) {
                        switch (returndata) {
                            case 'Sal':
                                $('#tipo0').prop('checked', true);
                                break;
                            case 'Base':
                                $('#tipo1').prop('checked', true);
                                break;
                            case 'Ácido':
                                $('#tipo2').prop('checked', true);
                                break;
                            case 'Orgânico':
                                $('#tipo3').prop('checked', true);
                                break;
                            case 'Etc':
                                $('#tipo4').prop('checked', true);
                                break;
                            default :
                                console.log('Alternativa correta inválida');
                                break;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log('Error, não retornou a instância');
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
                        $('#composto-nome').val(returndata);
                        Materialize.updateTextFields();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log('Error, não retornou a instância');
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
                        $('#composto-formula').val(returndata);
                        Materialize.updateTextFields();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log('Error, não retornou a instância');
                    }
                }
            );

            $('#volume-inicial').val("200");
            $('#molaridade-inicial').val("1.0");
            Materialize.updateTextFields();
        }
    });
}

function isEmpty(str) {
    return (!str || 0 === str.length);
}

