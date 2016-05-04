/**
 * Created by lucasbocanegra on 03/05/16.
 */

//se o jogo já foi exportado
$(function () {
    var platforms = $('.platform');
    var plataformsIcons = $("#plataforms-icons");
    var web = $('#web');
    var moodle = $('#moodle');

    $(web).css('cursor', 'wait');
    $(platforms).css('cursor', 'wait');
    $(moodle).css('cursor', 'wait');
    plataformsIcons.hide();

    $.ajax({
        type: 'GET',
        url: location.origin + '/exported-resource/export/' + $("#resource-id").val(),
        success: function (data) {
            console.log("deu certo e exportou o jogo");
            $('.plataforms-progress').hide();
            plataformsIcons.show(500);
            $(web).css('cursor', '');
            $(platforms).css('cursor', '');
            $(moodle).css('cursor', '');

            $(web).parent().attr('href', data['web']);

            $(web).hover(function () {
                $(this).children().eq(1).text('Acessar ').append('<i class="fa fa-link"></i>').addClass('plataforms-link');
            }, function () {
                $(this).children().eq(1).text('Web').removeClass('plataforms-link');
            });

            $(moodle).children().eq(1).text('Disponível no Moodle');

            $(platforms).each(function () {
                $(this).parent().attr('href', data[$(this).data('name')]);

                $(this).hover(function () {
                    $(this).children().eq(1).text('Baixar ').append('<i class="fa fa-arrow-circle-down" aria-hidden="true"></i>').addClass('plataforms-link');
                }, function () {
                    $(this).children().eq(1).text($(this).data('text')).removeClass('plataforms-link');
                });
            });

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log(':(');
        }
    });

});