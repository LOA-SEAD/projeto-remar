/* Created by garciaph */

// TODO: implementar loading screen de 0.5~1,0 segundo para permitir o carregamento das imagens sem mostrar uma animação 'bugada' para o usuário

var difficultyList = ['', 'Fácil', 'Médio', 'Difícil'];

const niveis = {
    FACIL  : 4,
    MEDIO  : 6,
    DIFICIL: 8
}


$(document).ready(function() {
    $('#BtnUnCheckAll').hide();
    // Pre-defined loading time
    setTimeout(function() {
        $('#loading-screen').fadeOut(1000, function() {
            $(this).hide();
        });
    }, 1000);

    // initialize materialize elements
    $('.tooltipped').tooltip({
        delay: 50,
        position: 'top',
        tooltip: $(this).data('tooltip-msg')
    });

    $("#removeSelected").click(function () {

        $('#loading-screen').show();

        var ids = [];
        $.each($("input[type=checkbox]:checked"), function (ignored, el) {
            ids.push($(el).attr('data-id'));
        });

        for(var i=0;i<ids.length;i++) {
            // Delete each selected tile
            $.ajax({
                async: false,
                type:"DELETE",
                data: {_method: "DELETE"},
                url: "/memoria_acessivel/tile/delete/" + ids[i],
                success: function (resp, status, xhr) {
                    if (xhr.status == 200) {
                        $("#tile-"+ids[i]).parent().parent().remove();
                    }
                },
                error: function (xhr, status, text) {
                    $('#loading-screen').hide();
                    console.log(text);
                }
            });
        }

        $('#loading-screen').hide();
        Materialize.toast("Par(es) removido(s) com sucesso!", 4000);
    });

    // send all tiles to controller
    $('#send').click(function() {
        // activates load screen
        $('#loading-screen').show();

        var ids = [];
        $.each($("input[type=checkbox]:checked"), function (ignored, el) {
            ids.push($(el).attr('data-id'));
        });


        var count = 0;

        switch(level){
            case 2: count = niveis.MEDIO; break;
            case 3: count = niveis.DIFICIL; break;
            default: count = niveis.FACIL;
        }

        console.log('level = ' + level);
        console.log('count = ' + count);

        if (ids.length == count) {
            // Proceed to task submission
            $.ajax({
                type: "POST",
                traditional: true,
                data: {id: ids},
                url: "/memoria_acessivel/tile/validate",
                success: function (resp, status, xhr) {
                    if (xhr.status == 200) {
                        window.top.location.href = resp;
                    } else {
                        $('#loading-screen').hide();
                        $('#fail-modal .modal-content p').html(resp);
                        $('#fail-modal').modal();
                        $('#fail-modal').modal('open');
                    }
                },
                error: function (xhr, status, text) {
                    $('#loading-screen').hide();
                    console.log(text);
                }
            });
        } else {
            Materialize.toast("Por favor, selecione exatamente " + count + " pares!", 4000)
            $('#loading-screen').hide();
        }

    });

    $('.modal').modal();
});

function check_all(){
    var CheckAll = document.getElementById("BtnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', 'checked');


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "true");
        }
    }

    $('#BtnCheckAll').hide();
    $('#BtnUnCheckAll').show();

}

function uncheck_all(){
    var UnCheckAll = document.getElementById("BtnUnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', false);


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "false");
        }
    }

    $('#BtnUnCheckAll').hide();
    $('#BtnCheckAll').show();

}