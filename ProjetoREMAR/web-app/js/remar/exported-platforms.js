/**
 * Created by Pedro Garcia on 06/06/17
 */

$(document).ready(function () {
    // Inicialização do processo de exportação
    var ID = $('#resource-id').val();
    var URL = '/exported-resource/export';

    // Esconde o bloco de compartilhar para grupos, que é mostrado apenas após o compartilhamento à todas as plataformas
    $('#groups').hide();

    // Esconde todos os ícones para acesso às plataformas ja exportadas
    $('.platform-icon').each(function() {
        $(this).hide();
    });

    // Chamadas AJAX aos procedimentos de exportação
    // A primeira chamada é para o procedimento geral, a fim de resgatar os parametros que
    //  serão utilizados pelas demais funções. Depois disso, as demais são feitas simultaneamente.
    $.ajax ({
        type: 'GET',
        url: URL,
        data: {id: ID},
        success: function (resp) {
            // Seta a variável contadora de plataformas para usar na função de acompanhamento do progresso
            var platformCounter = resp.platforms.length;
            var finished = 0;

            $('#progress-text').text('Estamos exportando seu jogo para diversas plataformas, por favor aguarde...');
            updateProgress(1,100);
            // Exportação para plataforma web
            if (resp.platforms.includes('web')) {
                URL = '/exported-resource/exportWeb';
                // Apenas a exportação para web ẽ assĩncrona, para garantir que terminará primeiro que as demais
                $.ajax ({
                    type: 'GET',
                    url: URL,
                    data: {params: resp.params},
                    success: function () {
                        console.log('Resource ' + ID + ' exported to web with success.');

                        // Atualiza barra de progresso e feedback ao usuário
                        finished = finished + 1;
                        updateProgress (finished, resp.platforms.length);

                        // Mostra o ĩcone clicável
                        var $element = $('#web');
                        $element.css('width', '100px');
                        $element.fadeIn('slow');
                        $element.find('a').attr('href', resp.urls.web);
                        $element.find('a').hover(function () {
                            $(this).find('.platform-title').text('Acessar ').append('<i class="fa fa-link"></i>').addClass('platforms-link');
                        }, function () {
                            $(this).find('.platform-title').text('Web').removeClass('platforms-link');
                        });
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log('Failed to export resource ' + ID + ' to web with error: ');
                        console.log(errorThrown);
                    }
                });
            }

            // Exportação para plataforma desktop
            if (resp.platforms.includes('desktop')) {
                URL = '/exported-resource/exportDesktop';

                $.ajax ({
                    type: 'GET',
                    url: URL,
                    data: {params: resp.params},
                    success: function () {
                        console.log('Resource ' + ID + ' exported to desktop with success.');

                        // Atualiza barra de progresso e feedback ao usuário
                        finished = finished + 1;
                        updateProgress (finished, resp.platforms.length);

                        // Mostra os ĩcones clicáveis
                        var platforms = ['windows', 'linux', 'mac'];

                        for (var i = 0; i < 3; i++) {
                            var $element = $('#' + platforms[i]);

                            $element.css('width', '100px');
                            $element.fadeIn('slow');
                            $element.find('a').attr('href', resp.urls[platforms[i]]);
                            $element.hover(function () {
                                $(this).find('a').find('.platform-title').text('Baixar ').append('<i class="fa fa-arrow-circle-down" aria-hidden="true"></i>').addClass('platforms-link');
                            }, function () {
                                $(this).find('a').find('.platform-title').text($(this).find('a > div').data('text')).removeClass('platforms-link');
                            });
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log('Failed to export resource ' + ID + ' to desktop with error: ');
                        console.log(errorThrown);
                    }
                });
            }

            // Exportação para plataforma android
            if (resp.platforms.includes('android')) {
                URL = '/exported-resource/exportAndroid';
                $.ajax ({
                    type: 'GET',
                    url: URL,
                    data: {params: resp.params},
                    success: function () {
                        console.log('Resource ' + ID + ' exported to android with success.');

                        // Atualiza barra de progresso e feedback ao usuário
                        finished = finished + 1;
                        updateProgress (finished, resp.platforms.length);

                        // Mostra o ĩcone clicável
                        var $element = $('#android');

                        $element.css('width', '100px');
                        $element.fadeIn('slow');
                        $element.find('a').attr('href', resp.urls.android);
                        $element.hover(function () {
                            $(this).find('a').find('.platform-title').text('Baixar ').append('<i class="fa fa-arrow-circle-down" aria-hidden="true"></i>').addClass('platforms-link');
                        }, function () {
                            $(this).find('a').find('.platform-title').text($(this).find('a > div').data('text')).removeClass('platforms-link');
                        });
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log('Failed to export resource ' + ID + ' to android with error: ');
                        console.log(errorThrown);
                    }
                });
            }

            // Verifica se o processo de exportação já acabou para esconder a barra de progresso
            var clearProgress = setInterval(function () {
                if (finished == platformCounter) {
                    $('#progress-viewer').hide(1000);
                    $('#groups').fadeIn('slow');

                    id = $('.infos-exportedResource').data('instance_id');

                    var url = location.origin + "/exportedResource/cardInfos/" + id; // envia o id do jogo para gerar o modal de compartilhamento

                    $.ajax({
                        type: 'GET',
                        url:  url,
                        data: null,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            $("#share-container").html(data);
                            $("#share-container h4").remove();
                            compartilhaJogo();
                        },
                        error: function (request, status, error) {
                            console.log(error);
                        }
                    });

                    console.log ('Exportação concluída');
                    clearInterval(clearProgress);
                } else {
                    console.log ('Exportação ainda não concluída');
                }

            },1000);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log('Failed to start export process for resource ' + ID + ' with error: ');
            console.log(errorThrown);
        }
    });

});

function updateProgress(finished, total) {
    progressPercentage = Math.ceil(( finished / total ) * 100);
    percentageString = progressPercentage.toString() + '%';

    $('#progress-percentage').html(percentageString);
    $('.progress .determinate').css({'width':percentageString});
}
