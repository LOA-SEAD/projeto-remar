/* Created by garciaph */

// TODO: implementar loading screen de 0.5~1,0 segundo para permitir o carregamento das imagens sem mostrar uma animação 'bugada' para o usuário

var difficultyList = ['', 'Fácil', 'Médio', 'Difícil'];



$(document).ready(function() {

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
                url: "/memoria/tile/delete/" + ids[i],
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

        if (ids.length == 3) {
            // Proceed to task submission
            $.ajax({
                type: "POST",
                traditional: true,
                data: {id: ids},
                url: "/memoria/tile/validate",
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
            Materialize.toast("Por favor, selecione exatamente 3 pares!", 4000)
            $('#loading-screen').hide();
        }

    });

    $('.modal').modal();
});

// fade out, change content, do something with the content if necessary and then fade in
function fadeInOut ($el, content, callback) {
    // hide element
    $el.animate({opacity: 0}, function() {
        // update content
        $el.html(content);

        // if there is a callback function, execute it
        callback = callback || null;
        if (callback) callback();

        // show element with new content
        $el.animate({opacity: 1});
    });
}

