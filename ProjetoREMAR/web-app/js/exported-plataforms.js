/**
 * Created by lucasbocanegra on 03/05/16.
 * Edited by Pedro Garcia on 06/06/17
 */

 $(document).ready(function () {
    // Monitoramento do processo de exportação
    var flags;                  /* flags representando o estado de cada estágio da exportação */
    var finishedStages;         /* contador de exportações finalizadas */
    var stages;                 /* armazena o total de estágios da exportação */
    var progressPercentage;     /* porcentagem do progresso: finishedStages/stages */
    var ID = $('#resource-id').val();
    var URL = '/exported-resource/getExportMonitor';

    // A cada meio segundo, uma chamada AJAX é feita para verificar se houve alguma mudança nas flags
    var progress = setInterval(function () {
        $.ajax ({
            cache: false,
            type: 'GET',
            url: URL,
            data: {id: ID},
            success: function (resp) {
                flags = resp;

                // Contagem dos processos finalizados
                finishedStages = 0;
                for (platform in flags) {
                    if (flags[platform]) {
                        finishedStages = finishedStages + 1;
                    }
                }

                // Atualização do feedback ao usuário
                stages = Object.keys(flags).length;
                progressPercentage = ( finishedStages / stages ) * 100;
                $('#exportProgress').html( progressPercentage + '%');

                // Termina a execução dessa função se todas as flags são true, ou seja, se o jogo
                // já foi exportado para todas as plataformas
                if (finishedStages == stages) {
                    URL = '/exported-resource/removeExportMonitor';

                    // remove o monitor do cluster de monitores por meio de uma função do controlador
                    $.ajax ({
                        cache: false,
                        type: 'GET',
                        url: URL,
                        data: {id: ID},
                        success: function (resp) {
                            console.log('Success on removing monitor [' + ID + '] from cluster.');
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            console.log('Failed on removing monitor [' + ID + '] from cluster.');
                            console.log(errorThrown);
                        }
                    });

                    // Apaga a barra e a mensagem de progresso
                    $('#exportProgress').hide();

                    // Faz com que a função "progress" pare de ocorrer a cada meio segundo
                    clearInterval (progress);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log('Failed to retrieve monitor ' + ID + ' flags with status: ' + errorThrown);
            }
        });
    }, 500);
 });

//se o jogo já foi exportado
$(function () {
    var platforms = $('.platform');
    var plataformsIcons = $('#plataforms-icons');
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
