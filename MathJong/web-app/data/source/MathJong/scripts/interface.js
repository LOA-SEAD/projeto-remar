var cor_botao = "#EEEEEE", cor_fonte = "#555555";

var fonte = 18, line_height = fonte, largura = fonte * 6, altura = fonte*3+20;

define(['jquery', 'ui', '../utils/audio', 'text!../templates/layout.html', './models/model', './tutorial/tutorial'], function ($, Ui, Audio, Layout, Model, Tutorial) {

    var menu,
            menuPrincipal,
            menuGravidade,
            jogo,
            configuracao,
            derrota,
            vitoria,
            tutorial,
            finalDeJogo,
            areaDasPecas,
            invervaloDeAtualizacao,
            pontuacao,
            botaoDica,
            controleSom,
            textoTutorial,
            posicaoBase,
            dicaDesabilitada = true,
            alturaQueSobraEmCima,
            larguraQueSobraADireita,
            volume = 50,
            cronometro,
            nivelAtual, nivelTotal,
            barraCronometro,
            mudo = true;


    function criarLayout() {
        $('body').append(Layout);
    }

    function obterElementos() {
        menu = $('#menu');
        menuPrincipal = $('#principal.camada');
        menuGravidade = $('#gravidade.camada');
        jogo = $('#jogo.camada');
        configuracao = $('#configuracao.camada');
        derrota = $('#derrota');
        vitoria = $('#vitoria');
        finalDeJogo = $('#finalDeJogo');
        areaDasPecas = $('#areaDasPecas')
        cronometro = $('#textoCronometro');
        nivelAtual = $('#nivel-atual');
        nivelTotal = $('#nivel-total');
        barraCronometro = $('#barraCronometro');
        pontuacao = $('#pontuacao');
        botaoDica = $('#dica.botaoJogo');
        controleSom = $('#controleDeSom');
        textoTutorial = $('#textoTutorial');
        tutorial = $('#tutorial.camada');
    }

    function configuraEventos() {
        configurarMenuBotaoJogar();
        configurarMenuBotaoConfiguracao();
        configurarMenuBotaoTutorial();
        configurarTutorialBotaoProximo();
        configurarTutorialBotaoPular();
        configurarMenuBotaoComGravidade();
        configurarMenuBotaoSemGravidade();
        configurarMenuBotaoVoltar();
        configurarJogoBotaoDica();
        configurarJogoBotaoVoltar();
        configurarJogoBotaoLembretes();
        configurarJogoPopupLembretes();
        configurarConfiguracaoBotaoVoltar();
        configurarSomBotaoSom();
        configurarSomSlider();
        configurarCamadaVitoria();
        configurarCamadaDerrota();
        configurarCamadaFinalDeJogo();
    }

    function iniciarJogo(gravidadeLigada) {
        if (Model.obterEstadoDeJogo() != 'finalizado')
        {
            Model.ajustarGravidade(gravidadeLigada);
            Model.iniciarJogo();
            atualizarCronometro();
            atualizarPontuacao();
            atualizarNiveis();
            $('#lembretes.popup').hide();
            $('#tutorial.camada').hide();
            $('#areaDasPecas').css('left', '0px');
            invervaloDeAtualizacao = setInterval(atualizar, 1000);
            colocarMatrizEmTela(Model.obterMatrizDePecas());
            posicaoBase = $('#0-0.peca').position();
        }
        else
            tratarFinalDoJogo();
    }

    function colocarMatrizEmTela(matriz) {
        $('.peca').remove();

        var alturaDaAreaDasPecas = parseInt(areaDasPecas.css('height'));
        var larguraDaAreaDasPecas = parseInt(areaDasPecas.css('width'));

        var alturaNecessariaParaPecas = altura * Model.obterNumeroDeLinhas();
        var larguraNecessariaParaPecas = largura * Model.obterNumeroDeColunas();

        alturaQueSobraEmCima = (alturaDaAreaDasPecas - alturaNecessariaParaPecas) / 2;
        larguraQueSobraADireita = (larguraDaAreaDasPecas - larguraNecessariaParaPecas) / 2;

        for (var i = 0; i < Model.obterNumeroDeLinhas(); i++)
        {
            for (var j = 0; j < Model.obterNumeroDeColunas(); j++)
            {
                if (matriz[i][j] != null)
                {
                    $('<div>')
                            .attr({'id': i + '-' + j, 'class': 'peca'})
                            .css({'top': i * altura + alturaQueSobraEmCima, 'left': j * largura + larguraQueSobraADireita, 'height': altura, 'width': largura, 'font-size': fonte + 'px', 'line-height': line_height + 'px',
                                'color': cor_fonte, 'background': cor_botao})
                            .html('<div>' + matriz[i][j].texto + '</div>')
                            .click(function () {
                                selecionarPeca($(this));
                            })
                            .appendTo(areaDasPecas);

                }
            }
        }
        MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
    }

    function atualizar() {
        estadoDeJogo = Model.obterEstadoDeJogo();

        if (estadoDeJogo == 'jogando')
        {
            atualizarPontuacao();
            atualizarCronometro();
        }
        else
        {
            tratarFimDeJogo(estadoDeJogo);
        }
    }

    function tratarFimDeJogo(estado) {
        switch (estado)
        {
            case 'perdeu':
                clearInterval(invervaloDeAtualizacao);
                fimDeJogoDerrota();
                break;
            case 'venceu':
                clearInterval(invervaloDeAtualizacao);
                fimDeJogoVitoria();
                break;
            case 'impossivel':
                setTimeout(function () {
                    tratarImpossibilidade();
                    Model.checarFimPorImpossibilidade();
                }, 1000);
                break;
            case 'finalizado':
                tratarFinalDoJogo();
                break;
        }
    }

    function tratarFinalDoJogo() {
        jogo.hide();
        vitoria.hide();
        finalDeJogo.fadeIn();
        Model.tratarFinalDoJogo();
    }

    function derrubarColuna(aPartirDaPeca, ateAPeca, coluna, velocidade) {
        //console.log(aPartirDaPeca, ateAPeca, aPartirDaPeca < ateAPeca)
        //console.log('tentou derrubar coluna: ' + coluna + ' a partir da peca: '+aPartirDaPeca+ 'ate a peca: ' + ateAPeca);swa

        for (var i = aPartirDaPeca - 1; i >= ateAPeca; i--)
        {
            derrubarPeca(i, coluna, velocidade);
        }
    }

    function derrubarPeca(linha, coluna, velocidade) {
        //console.log('derrubou peca da linha: '+ linha+ ' e da coluna: '+coluna);
        elemento = $('#' + linha + '-' + coluna);
        linha = parseInt(linha) + parseInt(velocidade);
        elemento.attr('id', linha + '-' + coluna).css('top', linha * altura + alturaQueSobraEmCima);
    }

    function atualizarPontuacao() {
        pontuacao.html('Pontuação: ' + Model.obterPontuacao());

        if (Model.obterPontuacao() >= Model.obterCustoDaDica())
        {
            if (dicaDesabilitada)
                //Habilitamos o botao da dica
                botaoDica.css('background-image', 'url("MathJong/imgs/botaoDica.png")');

            dicaDesabilitada = false;
        }
        else
        {
            if (!dicaDesabilitada)
                //Desabilitamos o botao dica
                botaoDica.css('background-image', 'url("MathJong/imgs/botaoDicaDesabilitado.png")');

            dicaDesabilitada = true;
        }
    }

    function atualizarCronometro() {
        tempo = Model.obterTempoRestante();
        minutos = parseInt(tempo / 60);
        segundos = tempo % 60;

        cronometro.html('Cronometro: ' + minutos + ':' + ((segundos < 10) ? "0" + segundos : segundos));

        barraCronometro.css('width', parseInt(148 * tempo / Model.obterTempoDoNivel()));
    }

    /**
     * Atualiza o conteudo no display "niveis"
     */
    function atualizarNiveis() {
        nivelAtual.html((Model.obterNivel() + 1).toString());
        nivelTotal.html((Model.obterNumeroDeNiveis() + 1).toString());
    }

    function fimDeJogoVitoria() {
        clearInterval(invervaloDeAtualizacao);
        jogo.hide();
        vitoria.fadeIn();
    }

    function fimDeJogoDerrota() {
        Model.sairJogo();
        clearInterval(invervaloDeAtualizacao);
        jogo.hide();
        derrota.fadeIn();
    }

    function tratarImpossibilidade() {
        var vetorDeNovasPosicoes = Model.fazerPossivel();

        for (var i = 0; i < vetorDeNovasPosicoes.length; i++)
        {
            var idAtual = vetorDeNovasPosicoes[i].x0 + '-' + vetorDeNovasPosicoes[i].y0;
            var idNovoX = vetorDeNovasPosicoes[i].x1;
            var idNovoY = vetorDeNovasPosicoes[i].y1;

            $('#' + idAtual).attr('id', idNovoX + '--' + idNovoY).css({'top': idNovoX * altura + alturaQueSobraEmCima, 'left': idNovoY * largura + larguraQueSobraADireita});
        }

        $('.peca').each(function () {
            $(this).attr('id', this.id.split('--')[0] + '-' + this.id.split('--')[1]);
        });
    }

    function selecionarPeca(peca) {

        pecasSelecionadas = $('.pecaSelecionada');
        if (pecasSelecionadas.length <= 1)
        {
            if ((pecasSelecionadas.length == 1) && (peca[0] == pecasSelecionadas[0]))
            {
                peca.removeClass('pecaSelecionada');
            }
            else
            {
                peca.addClass('pecaSelecionada');
            }
        }
        pecasSelecionadas = $('.pecaSelecionada');

        if (pecasSelecionadas.length > 1)
        {
            pos1 = pecasSelecionadas[0].id.split('-');
            pos2 = pecasSelecionadas[1].id.split('-');
            if (Model.tentarLigar(pos1, pos2))
            {
                //Pecas ligaram, vou verificar se ele ja pode pedir dicas
                if (Model.obterPontuacao() >= Model.obterCustoDaDica())
                {
                    botaoDica.css('background-image', 'Cestos/imgs/jogo/botaoDica.png')
                }

                desenharLinhas();

                $('.linha').fadeOut(500, function () {
                    $('.linha').remove();
                });

                $(pecasSelecionadas[0]).fadeOut(750);
                $(pecasSelecionadas[1]).fadeOut(750, function () {
                    if (Model.obterGravidade())
                    {
                        pos1[0] = parseInt(pos1[0]);
                        pos1[1] = parseInt(pos1[1]);
                        pos2[0] = parseInt(pos2[0]);
                        pos2[1] = parseInt(pos2[1]);

                        //Se as duas pecas sao da mesma coluna
                        if (pos1[1] == pos2[1])
                        {
                            //Se a peca dois esta acima da peca um
                            if (pos1[0] > pos2[0])
                            {
                                derrubarColuna(pos1[0], pos2[0], pos1[1], 1);
                                derrubarColuna(pos2[0], 0, pos2[1], 2);
                            }
                            //Se a peca um esta acima da peca dois
                            else
                            {
                                derrubarColuna(pos2[0], pos1[0], pos2[1], 1);
                                derrubarColuna(pos1[0], 0, pos1[1], 2);
                            }
                        }
                        else
                        {
                            derrubarColuna(pos2[0], 0, pos2[1], 1);
                            derrubarColuna(pos1[0], 0, pos1[1], 1);
                        }
                    }

                    pecasSelecionadas.remove();
                });
            }
            else
            {
                pecasSelecionadas.removeClass('pecaSelecionada');
            }
        }
    }

    function desenharLinhas()
    {
        var classeL, topL, leftL;
        var caminho = Model.obterCaminho();

        for (var i = 1; i < caminho.length; i++)
        {
            if (caminho[i - 1].x == caminho[i].x)
            {
                classe = "linha-horizontal";
                topL = posicaoBase.top - 45 + caminho[i].x * altura;
                leftL = (posicaoBase.left - largura + largura * (caminho[i].y + caminho[i - 1].y) / 2) - 18;
            }
            else
            {
                classe = "linha-vertical";
                topL = posicaoBase.top - altura + altura * (caminho[i].x + caminho[i - 1].x) / 2;
                leftL = (posicaoBase.left - 75 + caminho[i].y * largura);
            }

            $('<div>')
                    .addClass('linha')
                    .addClass(classe)
                    .css({
                        'top': topL,
                        'left': leftL,
                    })
                    .appendTo('#areaDasPecas');
        }
    }

    //Configuracoes da camada menu
    function configurarMenuBotaoJogar() {
        $('#jogar.botaoMenu').click(function () {
            menuPrincipal.hide();
            menuGravidade.fadeIn();
        });
    }

    function configurarMenuBotaoConfiguracao() {
        $('#config.botaoMenu').click(function () {
            menu.hide();
            configuracao.fadeIn();
            controleSom.hide();
            destroi_peca();
            criar_peca();
            criar_texto();

        });
    }

    function configurarMenuBotaoTutorial() {
        $('#tutorial.botaoMenu').click(function () {
            menu.hide();
            menuGravidade.hide();

            Tutorial.tutorialAtual = -1;

            jogo.fadeIn();
            iniciarJogo(true);
            Model.pausarCronometro();
            tutorial.fadeIn();
            $('#areaDasPecas').css('left', '-100px');
            proximoTutorial();
        });
    }

    function configurarTutorialBotaoProximo() {
        $('#proximo.botaoTutorial').click(function () {
            proximoTutorial();
        });
    }

    function proximoTutorial() {
        Tutorial.tutorialAtual++;

        textoTutorial
                .fadeOut(500, function () {
                    $(this)
                            .hide()
                            .html(Tutorial.texto[Tutorial.tutorialAtual])
                            .slideDown(500)
                            .fadeIn(500)
                })

        pecas = Model.checarPossivelLigacao();

        switch (Tutorial.tutorialAtual)
        {
            case 1:
                pecas = Model.checarPossivelLigacao();
                setTimeout(function () {
                    Model.continuarCronometro();
                    selecionarPeca($('#' + pecas[0].pos[0] + '-' + pecas[0].pos[1]));
                    Model.pausarCronometro();
                }, 1000);
                break;
            case 2:
                pecas = Model.checarPossivelLigacao();
                setTimeout(function () {
                    Model.continuarCronometro();
                    selecionarPeca($('#' + pecas[1].pos[0] + '-' + pecas[1].pos[1]));
                    Model.pausarCronometro();
                }, 1000);
                break;
            case 4:
                $(dica).addClass('circulado');
                break;
            case 5:
                $(dica).removeClass('circulado');
                $(lembretes).addClass('circulado');
                break;
            case 6:
                $(lembretes).removeClass('circulado');
                $('#cronometro').addClass('circulado');
                break;
            case 7:
                $('#cronometro').removeClass('circulado');
                $('#botaoSom').addClass('circulado');
                break;
            case 8:
                $('#botaoSom').removeClass('circulado');
                pecas = Model.checarPossivelLigacao();
                Model.continuarCronometro();
                selecionarPeca($('#' + pecas[0].pos[0] + '-' + pecas[0].pos[1]));
                selecionarPeca($('#' + pecas[1].pos[0] + '-' + pecas[1].pos[1]));
                Model.pausarCronometro();
                break;
            case 9:
                Model.ajustarGravidade(false);
                pecas = Model.checarPossivelLigacao();
                Model.continuarCronometro();
                selecionarPeca($('#' + pecas[0].pos[0] + '-' + pecas[0].pos[1]));
                selecionarPeca($('#' + pecas[1].pos[0] + '-' + pecas[1].pos[1]));
                Model.pausarCronometro();
                break;
            case 11:
                jogo.hide();
                tutorial.hide();
                menu.fadeIn();
                menuGravidade.fadeIn();
                Model.sairJogo();
                clearInterval(invervaloDeAtualizacao);
                break;
        }
    }

    function configurarTutorialBotaoPular() {
        $('#pular.botaoTutorial').click(function () {
            $(dica).removeClass('circulado');
            $('#cronometro').removeClass('circulado');
            $(lembretes).removeClass('circulado');
            $('#botaoSom').removeClass('circulado');

            jogo.hide();
            tutorial.hide();
            menu.fadeIn();
            menuGravidade.fadeIn();
            clearInterval(invervaloDeAtualizacao);
            Model.sairJogo();
        })
    }

    function configurarMenuBotaoComGravidade() {
        $('#comGravidade.botaoMenu').click(function () {
            menuGravidade.hide();
            menu.hide();
            jogo.fadeIn();
            iniciarJogo(true);
        });
    }

    function configurarMenuBotaoSemGravidade() {
        $('#semGravidade.botaoMenu').click(function () {
            menuGravidade.hide();
            menu.hide();
            jogo.fadeIn();
            iniciarJogo(false);
        });
    }

    function configurarMenuBotaoVoltar() {
        $('#voltar.botaoMenu').click(function () {
            menuGravidade.hide();
            menuPrincipal.fadeIn();
        });
    }

    //Configuracoes da camada jogo        
    function configurarJogoBotaoDica() {

        $('#dica.botaoJogo').click(function () {

            pecas = Model.retornarPecasQueSeLigam();

            if (pecas != false)
            {
                peca1 = $('#' + pecas[0].pos[0] + '-' + pecas[0].pos[1] + '.peca').addClass('pecaDica');
                peca2 = $('#' + pecas[1].pos[0] + '-' + pecas[1].pos[1] + '.peca').addClass('pecaDica');

                setTimeout(function () {
                    peca1.removeClass('pecaDica');
                    peca2.removeClass('pecaDica');
                }, 1000);
            }
        });
    }

    function configurarJogoBotaoVoltar() {
        $('#voltar.botaoJogo').click(function () {
            Model.sairJogo();
            clearInterval(invervaloDeAtualizacao);
            jogo.hide();
            menu.fadeIn();
            menuPrincipal.fadeIn();
        });
    }

    function configurarJogoBotaoLembretes() {
        $('#lembretes.botaoJogo').click(function () {
            Model.pausarCronometro();
            $('#lembretes.popup').fadeIn();
        })
    }

    function configurarJogoPopupLembretes() {
        $('#lembretes.popup').click(function () {
            $(this).hide();
            Model.continuarCronometro();
        })
    }

    //Configuracoes da camada creditos
    function configurarConfiguracaoBotaoVoltar() {
        $('#voltar.botaoConfiguracao').click(function () {
            configuracao.hide();
            menu.fadeIn();
            controleSom.fadeIn();

            destroi_peca();
        });
    }

    //Configuracoes do controle de som
    function configurarSomBotaoSom() {
        $('#botaoSom')
                .css('background', 'url("MathJong/imgs/botaoSom.png")')
                .click(function () {
                    mudo = !mudo;
                    if (mudo) {
                        $(this).css('background', 'url("MathJong/imgs/botaoSemSom.png")');
                        Audio.pausarSom();
                    }
                    else {
                        $(this).css('background', 'url("MathJong/imgs/botaoSom.png")');
                        Audio.iniciarSom();
                    }

                });
    }

    function configurarSomSlider() {
        //Nem sei fazer isso
        $('#slider').slider({
            max: 100,
            min: 0,
            value: 100,
            create: function (event, ui) {
                Audio.iniciarSom();
            },
            change: function (event, ui) {
                Audio.ajustarVolumePara(ui.value / 100);
            },
        });
    }

    //Configuracoes das camadas
    function configurarCamadaVitoria() {
        vitoria.click(function () {
            vitoria.hide();
            jogo.fadeIn();
            Model.proximoNivel();
            iniciarJogo(Model.obterGravidade());
        });
    }

    function configurarCamadaDerrota() {
        derrota.click(function () {
            derrota.hide();
            menu.fadeIn();
            menuGravidade.fadeIn();
        });
    }

    function configurarCamadaFinalDeJogo() {
        finalDeJogo.click(function () {
            finalDeJogo.hide();
            menu.fadeIn();
            menuGravidade.hide();
            menuPrincipal.show();
        });
    }

    return {
        iniciar: function ()
        {
            criarLayout();
            obterElementos();
            configuraEventos();
        }
    };



});

function criar_peca() {
    $('<div>')
            .attr({'id': 0 + '-' + 0, 'class': 'peca'})
            .css({'height': altura, 'width': largura, 'font-size': fonte + 'px', 'line-height': line_height + 'px',
                'color': cor_fonte, 'background': cor_botao})
            .appendTo('#PecaTeste');
}
function criar_texto() {

    $('<div>')
            .attr({'id': 'peca', 'class': 'peca1'})
            .html('<div>' + '$$x^2$$' + '</div>')
            .appendTo('#0-0');
    MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
}

function destroi_peca() {
    $('.peca').remove();
}

function troca_fundo(cor) {
    document.body.style = "background: " + cor + ";";
}

function troca_fundo_peca(cor) {
    document.getElementById('peca').style = "background: " + cor + ";" + "color: " + cor_fonte + ";";
    cor_botao = cor;
    destroi_peca();
    criar_peca();
    criar_texto();
}

function troca_fonte(cor) {
    cor_fonte = cor;
    document.getElementById('peca').style = "color: " + cor + ";" + "background: " + cor_botao + ";";
    destroi_peca();
    criar_peca();
    criar_texto();
}

function troca_tamanho(tamanho) {
    fonte = tamanho;
    line_height = parseInt(fonte);
    largura = parseInt(fonte) * 6;
    altura = parseInt(fonte) * 3 + 20;
    document.getElementById('0-0').style = "height: " + altura + "px;" + "width: " + largura + "px;" + "font-size: " + fonte + "px;" +
            "line-height: " + line_height + "px;" + "color: " + cor_fonte + ";" + "background: " + cor_botao + ";";
    destroi_peca();
    criar_peca();
    criar_texto();
}
