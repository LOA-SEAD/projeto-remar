var newMoleculeUrl = "/quimolecula/molecule/save"

var EDITOR_TITLE = "Editor"


//Variavel que indica quantas moleculas foram cadastradas
quantidadeDeMoleculas = 1;
//Variavel que controla qual o maior nivel que o usuaio chegou(indexado a partir do 0)
maxNivel = save.load();
//Variavel que controla em qual niveis o usuario esta fazendo agora
nivel = maxNivel;
//Variavel que controla qual background estasendo mostrado
backgroundI = 0;
//Variavel que guarda todos que estao em jogo
elementosNoJogo = [];
//Variavel que controla qual atomo esta selecionado(usado quando vamos criar ligacoes)
atomoSelecionado = null;
//Variavel que controla qual ligacao foi usada para selecionar o primeiro atomo
ligacaoAtual = null;
//Variavel que guarda todas as ligacoes feitas durante o jogo
ligacoesNoJogo = [];
//Variavel que controla se os carbonos estao mostrando o numero ou a letra C
estaNumerado = false;
//Guarda a posicao inicial de qualquer elemento que pode ser arrastado
posicaoInicial = 0;
//Variaveis que guarda o que esta guardado na tecla D(ligacao, atomo ou nada)
var funcaoAtual;
//Variavel que guarda qual atomo esta sendo usado com a tecla D
var atomoAtual;
//Variavel que guarda qual ligacao ou atomo esta selecionado com a tecla D
var elementoSelecionado;
//Variavel que guarda a posicao do mouse na tela
var mouseObj = new Object();

$(document).ready(function() {
    criarJogo();

    $("#createMoreMoleculesButton").click(function(){
        reiniciarJogo();
        $("#name").val("");
        $("#structure").val("");
        $("#tip").val("");
    });

    $("#sendMoleculeButton").click(function(){
        var strXml = ""
        var name = $("#name").val();
        var structure = $("#structure").val();
        var tip = $("#tip").val();

        strXml += "<?xml version='1.0' encoding='utf-8'?>\n<molecule name='" + name + "'";
        strXml += " formula = '" + structure + "'";
        strXml += " dica = '" + tip + "'>\n";

        var a = new Object;

        for(var i=0; i<elementosNoJogo.length;i++)
        {
        //elementosNoJogo[i].numero
            var tipo = elementosNoJogo[i].nome;
            var cod = elementosNoJogo[i].codigo;
            a[tipo+cod] = i;
            strXml += " <atom id='"+i+"' type='"+elementosNoJogo[i].nome+"' number='"+elementosNoJogo[i].numero+"'/>\n";
        }
        console.log(a);
        console.log(a);
        for(var i=0; i<ligacoesNoJogo.length;i++)
        {
            var tipo = ligacoesNoJogo[i].elementos[0].nome;
            var cod = ligacoesNoJogo[i].elementos[0].codigo;
            var tipo1 = ligacoesNoJogo[i].elementos[1].nome;
            var cod1 = ligacoesNoJogo[i].elementos[1].codigo;
            strXml += " <bond source='"+a[tipo+cod]+"' target='"+a[tipo1+cod1]+"' type='"+ligacoesNoJogo[i].valor+"'/>\n";
        }
        strXml+="</molecule>";


        newMol = {
            name: name,
            structure: structure,
            tip: tip,
            xml: strXml
        };

        $.ajax ({
            type: "POST",
            url: newMoleculeUrl,
            data: newMol,
            success: function(data) {
                $("#successModal").openModal();
            },
            error: function(xhrElement, error, exceptionThrown) {
                alert("Um erro ocorreu. Tente novamente.");
                console.log(data);
            }
        });

    })
});

//Funcao chamada para iniciar o elemento da area central
function iniciarAreaCentral() {
    $('<div>').attr({'id': 'areaCentral'}).appendTo($('#camadaJogo'));
}

//Funcao chamada depois que o xml eh lido com sucesso para iniciar todo o jogo
function iniciarJogo() {

    iniciarAreaCentral();

    document.onmousemove = mouseMove;
    document.onkeypress = debugKeyListeners;

    iniciarAreaInferior();
    inciarAreaLateral();

    atualizarDica();
    iniciarTutorial();
}

//Funcao chamada para iniciar todos os elementos da area lateral
function inciarAreaLateral() {
    $('<div>').attr({'id': 'areaLateral'}).appendTo($('#camadaJogo'));


    //Inicia a area onde sera mostrado o nome da molecula
    $('<div>').attr('id', 'nomeDaMolecula')
                .html(EDITOR_TITLE)
                .css({ 'height': '80px', 'padding-top': '20px' })
                .appendTo($('#areaLateral'));

    $('<div>').attr('id', 'btnNumCarbonos')
                .click(numerarCarbonos)
                .appendTo($('#areaLateral'));

    $('<input type=text>').attr('id', 'tb1')
                    .attr({'maxlength': 2,
                            'text-align': 'center'})
                    .css({'text-align': 'center',})
                    .appendTo($('#areaLateral'));


    //Inicia os atomos que podem ser escolhidos
    $('<div>').attr({'id':'hidrogenio', 'class': ' atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'carbono', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'oxigenio', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'nitrogenio', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'bromo', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'cloro', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'iodo', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'fosforo', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'enxofre', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    $('<div>').attr({'id':'fluor', 'class': 'atomoDisponivel'}).appendTo($('#areaLateral'));

    //Define o comportamento de arrastar um atomo da area lateral
    $('.atomoDisponivel').draggable({
                            containment: "#palco",
                            cursorAt: { top: 22, left: 20},
                            start: function(event, ui) {
                                funcaoAtual = "atomo";
                                elementoSelecionado = this;
                                $(this).css('z-index', '16');
                                posicaoInicial = $('#' + this.id).position()
                            },

                            stop: function(event, ui) {

                                criarAtomo(this.id);
                                voltarPosicaoInicial($(this));
                                funcaoAtual = "nada";
                                $(this).css('z-index', '');
                                elementoSelecionado = null;
                            }});

    //Inicia as ligacoes que podem ser escolhidos
    $('<div>').attr({'id': 'ligacaosimples', 'class': 'ligacaoDisponivel'}).appendTo($('#areaLateral'));
    $('<div>').attr({'id': 'ligacaodupla', 'class': 'ligacaoDisponivel'}).appendTo($('#areaLateral'));
    $('<div>').attr({'id': 'ligacaotripla', 'class': 'ligacaoDisponivel'}).appendTo($('#areaLateral'));

    //Define o comportamento de arrastar um atomo da area lateral
    $('.ligacaoDisponivel').draggable({
        containment: "#palco",
        cursorAt: { top: 10, left: 20},

        start: function(event, ui) {
            funcaoAtual = "ligacao";
            elementoSelecionado = this;
            $(this).css('z-index', '16');
            posicaoInicial = $('#' + this.id).position();
        },

        stop: function(event, ui){
        {
            funcaoAtual = "nada";
            elementoSelecionado = null;
            $(this).css('z-index', '');
            voltarPosicaoInicial($(this));}}
        });
    $('<div>').attr('id','btnVerifica')
                .click(function() {
                    $("#createModal").openModal();
                }).appendTo($('#areaLateral'));

    $('<div>').attr('id','btnMenu')
                .click(function(){
                    window.location.pathname = "/quimolecula/molecule/"
                }).appendTo($('#areaLateral'));
}

//Funcao que zera todas as variaveis e limpa a areaCentral
function reiniciarJogo() {
    $('#areaCentral').remove();
    ligacoesNoJogo= [];
    elementosNoJogo = [];
    iniciarAreaCentral();
    atomoSelecionado = null;
    ligacaoAtual = null;
    estaNumerado = false;
    posicaoInicial = 0;
}

//Funcao chamada para iniciar todos os elementos da area inferior
function iniciarAreaInferior() {
    $('<div>').attr({'id': 'areaInferior'}).appendTo($('#camadaJogo'));

    $('<div>').attr({'id': 'textoDica'}).appendTo($('#areaInferior'));


    $('<div>')
    .attr('id', 'btnLixeira')
    .click ( function() {

        $('<div>')
        .attr({ 'id': 'lixeira', 'class': 'popup' })
        .html('<p style="position: absolute; width: 350px; left: 25px">Tem certeza que deseja limpar a area de edição?</p>')
        .appendTo($('#camadaJogo.camada'));

        $('<div>')
        .attr({ 'id': 'continuar', 'class': 'botao' })
        .html('N?')
        .click(function(){
            $(this).parent().fadeOut('slow', function(){
                $(this).remove();
            })
        })
        .appendTo($('#lixeira.popup'));

        $('<div>')
        .attr({ 'id': 'reiniciar', 'class': 'botao' })
        .html('Sim')
        .click(function(){
            reiniciarJogo();
            $(this).parent().fadeOut('slow', function(){
                $(this).remove();
            });
        })
        .appendTo($('#lixeira.popup'));
    })
    .droppable({
        drop: function(event, ui){

            var elementoParaExcluir;

            if($(ui.draggable).attr('class').split(' ')[0] == 'atomoEmEdicao')
            {
                for(var i = 0; i < elementosNoJogo.length; i++)
                {
                    if(ui.draggable.attr('id') == elementosNoJogo[i].div.attr('id'))
                    {
                        elementoParaExcluir = i;
                    }
                }
                removerElemento(elementosNoJogo[elementoParaExcluir]);
            }



            if($(ui.draggable).attr('class').split(' ')[0] == 'ligacaoEmEdicao')
            {
                var n = $(ui.draggable).attr('id').split('-')[1];
                var aux = ligacoesNoJogo[n-1].elementos;

                ligacoesNoJogo[n-1].desligar();

                if(aux[0].numeroDeLigacoesFeitas == '0')
                {
                    $(aux[0].div).draggable({disabled: false,})
                }
                if(aux[1].numeroDeLigacoesFeitas == '0')
                {
                    $(aux[1].div).draggable({disabled: false,})
                }
            }
        }})
    .appendTo($('#areaInferior'));
}

//Funcao que verifica se a posicao passada como parametros est?vazia
function posicaoVazia(pos, id) {
    for(var i = 0; i<elementosNoJogo.length; i++)
    {
        if((Math.abs(elementosNoJogo[i].div.position().top - pos.top) < 5)
            && (Math.abs(elementosNoJogo[i].div.position().left - pos.left+200) < 5)
            && (id != elementosNoJogo[i].div.attr('id')))
        {
            return false;
        }
    }

    return true;
}

//Funcao que cria um atomo na tela
//Essa funcao j??reponsavel por todas as checagens, ou seja, s?precisamos passar o nome do elementos a ser criado
function criarAtomo(_id) {
    var aux = 1;
    if(_id == 'carbono')
    {

        for(var i = 0; i < elementosNoJogo.length; i++) {
            if(elementosNoJogo[i].nome == 'carbono') {
                aux++;
            }
        }
    }
    else {
        aux = -1;
    }

    if(estaNaAreaDeEdicao(_id))
    {
        var posicao = colocarNaGrade(posicaoAbsoluta(_id));

        var cont = 0;
        for(var i = 0; i < elementosNoJogo.length; i++)
        {
            if(elementosNoJogo[i].nome == _id)
            {
                cont++;
            }
        }

        if(posicaoVazia(posicao, _id+'-'+cont))
        {
            var maxDeLigacoes = maximoDeLigacoesPorAtomo(_id);

            var divAtomo = $('<div>').attr({'id': _id + '-' + cont,
                                            'class': 'atomoEmEdicao',})
                                    .css({'top': posicao.top + 'px',
                                            'left': posicao.left - 200 + 'px',
                                            'background': 'url("' + imgPath + 'atomos/' + _id +'.png")'})
                                    .hover(function(){tileEmQueMouseEsta = this.id;}, function(){tileEmQueMouseEsta = "";})
                                    .appendTo($('#areaCentral'))
                                    .click(function(){

                                        if(atomoSelecionado != null && atomoSelecionado != this)
                                        {
                                            selecionaSegundoAtomo(this);
                                        }
                                        else
                                        {
                                            mudarNumeroCarbono(this);
                                        }
                                    })
                                    .draggable({
                                        containment: "#palco",
                                        cursorAt: { top: 22, left: 20},
                                        start: function(event, ui) {
                                            posicaoInicial = $(this).position();
                                            $(this).css('z-index', '16');
                                            },

                                        stop: function(event, ui){

                                            var posicao = colocarNaGrade(posicaoAbsoluta($(this).attr('id')));

                                            if(estaNaAreaDeEdicao(this.id) && posicaoVazia(posicao, this.id))
                                            {

                                                $(this).css({'top': posicao.top, 'left': posicao.left - 200});
                                            }
                                            else
                                            {
                                                voltarPosicaoInicial($(this));
                                            }
                                            $(this).css('z-index', '');
                                            }})
                                    .droppable({
                                        drop: function(event, ui) {

                                            if(ui.draggable.attr('class').split(' ')[0] == 'ligacaoDisponivel')
                                            {
                                                if(atomoSelecionado == null)
                                                {
                                                    atomoSelecionado = this;
                                                    ligacaoAtual = ui.draggable.attr('id');
                                                    $(this).addClass('atomoSelecionado');
                                                }
                                                else
                                                {
                                                    $(atomoSelecionado).removeClass('atomoSelecionado');
                                                    ligacaoAtual = ui.draggable.attr('id');
                                                    atomoSelecionado = this;
                                                    $(this).addClass('atomoSelecionado');
                                                }
                                            }

                                        },});


            var atomo = new Atomo(_id, maxDeLigacoes, cont, divAtomo, aux);

            colocarElemento(atomo);

            if(estaNumerado && elementosNoJogo[i].nome == 'carbono') {
                $(elementosNoJogo[i].div).css({'background-image': 'url("' + imgPath + 'atomos/' + 'C_preto.png")'});
                $('<p>').attr({'class': 'numCarbonos'})
                            .css({'text-align': 'center',
                                'color' : 'white',
                                'top': '-5px',
                                'position': 'absolute',
                                'left': '6px',
                                'cursor': 'default',
                                'width': '30px',})
                                            .html(atomo.numero)
                                            .appendTo(atomo.div);
            }
        }
    }
}

//Funcao que verifica se a div est?dentro da area central(area de edicao da molecula)
function estaNaAreaDeEdicao(_id) {

    var posicao = posicaoAbsoluta(_id);

    if(posicao.left > 200 && posicao.left < 800)
    {
        if(posicao.top > 0 && posicao.top < 520)
            return true;
        else
            return false;
    }
    else
    {
        return false;
    }
}

//Todas as posicoes dependem da posicao dos pais das divs
//Essa funcao pega a posicao absoluta da div em relacao ao palco
function posicaoAbsoluta(_id) {

    var p = {};
    var posicaoPai = $('#' + _id).parent().position();

    p.left = $('#' + _id).position().left + posicaoPai.left + parseInt($('#' + _id).css('width'))/2;
    p.top = $('#' + _id).position().top + posicaoPai.top + parseInt($('#' + _id).css('height'))/2;

    p.left = parseInt(p.left);
    p.top = parseInt(p.top);

    return p;
}

//Funcao que retorna o numero maximo de ligacoes que um determinado atomo pode fazer
function maximoDeLigacoesPorAtomo(_id) {

    switch(_id)
    {
        case 'hidrogenio':
            return 1;
            break;

        case 'carbono':
            return 4;
            break;

        case 'oxigenio':
            return 2;
            break;

        case 'nitrogenio':
            return 3;
            break;

        case 'bromo':
            return 1;
            break;

        case 'cloro':
            return 1;
            break;

        case 'iodo':
            return 1;
            break;

        case 'fosforo':
            return 3;
            break;

        case 'enxofre':
            return 2;
            break;

        case 'fluor':
            return 1;
            break;
    }
}

//Funcao que coloca um atomo na variavel global que controla todos os atomos na tela
function colocarElemento(_atomo) {

    elementosNoJogo[elementosNoJogo.length] = _atomo;
}

//Funcao que remove um atomo da variavel global que controla todos os atomos na tela
function removerElemento(_atomo) {

    var achou = false;
    var codigo = null;
    var nome = null;
    var numeroCarb = carbonosEmTela();

    if((_atomo.nome == 'carbono') && (_atomo.numero != -1))
    {
        for(var i = 0; i < elementosNoJogo.length; i++)
        {
            if(elementosNoJogo[i].nome == 'carbono')
            {
                if(elementosNoJogo[i].numero >= numeroCarb)
                {
                    elementosNoJogo[i].numero--;
                }
            }
        }
        numerarCarbonos();
        numerarCarbonos();
    }

    for(var i = 0; i < elementosNoJogo.length; i++)
    {
        if(elementosNoJogo[i] == _atomo)
        {
            _atomo.div.remove();
            codigo = elementosNoJogo[i].codigo;
            nome = elementosNoJogo[i].nome;
            elementosNoJogo.splice(i,1);
            achou = true;
        }

        if(achou && i < elementosNoJogo.length)
        {
            if(elementosNoJogo[i].nome == nome)
            {
                elementosNoJogo[i].codigo = codigo;

                $(elementosNoJogo[i].div).attr('id', elementosNoJogo[i].nome + '-' + elementosNoJogo[i].codigo);
                codigo++;
            }
        }
    }
}

//Os atomos s? alinhados automaticamente a uma grade invisivel
//Essa funcao retorna a posicao na grade que que o atomo deve ir a partir da posicao inicial passada como parametro
function colocarNaGrade(_position) {

    _position.left = parseInt(_position.left/40) * 40;
    _position.top = parseInt(_position.top/40) * 40;

    _position.left = parseInt(_position.left);
    _position.top = parseInt(_position.top);

    return _position;
}

//Funcao que verifica se dois atomos sao vizinhos, ou seja, estao em casa subsequentes
function saoVizinhos(e1, e2) {

    var position1 = e1.position();
    var position2 = e2.position();
    var width1 = e1.width();
    var height1 = e1.height();
    if((position2.left >= position1.left - width1) && (position2.left < position1.left + 2*width1) && (position2.top >= position1.top - height1) && (position2.top < position1.top + 2*height1))
        return true;
    else
        return false;
}

//Funcao usada para selecionar o segundo atomos, ou seja, j?temos um atomo selecionado e vamos selecionar o segundo
//Essa funcao ja cuida das verificacoes para ter certeza que o primeiro atomo esta selecionado e estrutura toda a parte das ligacoes
function selecionaSegundoAtomo(_div) {

    if(saoVizinhos($(atomoSelecionado), $(_div)))
    {
        var atomo1 = null;
        var atomo2 = null;

        for(var i = 0; i < elementosNoJogo.length; i++)
        {
            if($(elementosNoJogo[i].div).attr('id') == $(atomoSelecionado).attr('id'))
            {
                atomo1 = elementosNoJogo[i];
            }
            if($(elementosNoJogo[i].div).attr('id') == $(_div).attr('id'))
            {
                atomo2 = elementosNoJogo[i];
            }
        }
        var valor = 0;
        switch (ligacaoAtual)
        {
            case 'ligacaosimples':
                valor = 1;
                break;
            case 'ligacaodupla':
                valor = 2;
                break;

            case 'ligacaotripla':
                valor = 3;
                break;
        }

        var lig = new Ligacao(ligacoesNoJogo.length, valor, 0, 0);


        if(lig.ligar(atomo1, atomo2))
        {
            ligacoesNoJogo[ligacoesNoJogo.length] = lig;
            desenharLigacao(atomo1, atomo2, lig);
            $(atomo1.div).draggable({ disabled: true,})
            $(atomo2.div).draggable({ disabled: true,})
        }
    }

    $(atomoSelecionado).removeClass('atomoSelecionado');
    atomoSelecionado = null;
    ligacaoAtual = null;
}

//Funcao que realiza a colisao entre um ponto(primeiro parametro) e um elemento(segundo parametro)
function testaColisaoPonto(p, e) {
    if((p.x >= e.position().left) && (p.x <= e.position().left + e.width()) && (p.y >= e.position().top) && (p.y <= e.position().top + e.height()))
        return true;
    else return false;
}

//Essa funcao retorna qualquer elemento para posicao original(antes de ser arrastado)
function voltarPosicaoInicial(_div) {

    _div.css({'top': posicaoInicial.top, 'left': posicaoInicial.left});
}

//Funcao que desenha na tela uma ligacao
//A ligacao realmente ja foi criada, aqui s?cuida da parte visual e comportamental da ligacao na tela
function desenharLigacao(atomo1, atomo2, lig) {

    var p = {};
    p.top = ($(atomo1.div).position().top + $(atomo2.div).position().top)/2 + 20;
    p.left = ($(atomo1.div).position().left + $(atomo2.div).position().left)/2;

    var angulo = calcularAngulo($(atomo1.div).position(), $(atomo2.div).position());

    var div = $('<div>').attr({'id': ligacaoAtual + '-' + ligacoesNoJogo.length, 'class': 'ligacaoEmEdicao'})
                        .css({
                            'z-index': 11,
                            'top': p.top,
                            'left': p.left,
                        })
                        .draggable({
                            containment: "#palco",
                            cursorAt: { top: 10, left: 20},
                            start: function(event, ui) {
                                posicaoInicial = $(this).position();
                            },

                            stop: function(event, ui) {

                                var n = this.id.split('-')[1];

                                $(this).css({'top': posicaoInicial.top, 'left': posicaoInicial.left});

                                $(ligacoesNoJogo[n-1].image).css({'top': $(this).position().top, 'left': $(this).position().left});

                            },

                            drag: function(event, ui) {
                                var n = $(this).attr('id').split('-')[1];
                                $(ligacoesNoJogo[n-1].image).css({'top': $(this).position().top, 'left': $(this).position().left});
                            }
                        })
                        .appendTo($('#areaCentral'));

    var image = $('<div>')
                .attr({'class': 'ligacaoEmEdicao'})
                .css({
                    'z-index': 0,
                    'top': $('#' + ligacaoAtual + '-' + ligacoesNoJogo.length).position().top,
                    'left': $('#' + ligacaoAtual + '-' + ligacoesNoJogo.length).position().left,
                    'background-image': 'url("' + imgPath + 'atomos/' + ligacaoAtual + '.png")',
                })
                .css({
                    /*'-webkit-rotation-point': '0% 50%',
                    '-moz-rotation-point': '0% 50%',
                    '-o-rotation-point': '0% 50%',
                    '-ms-rotation-point': '0% 50%',*/
                    '-webkit-transform': ' rotate(' + angulo + 'deg)',
                    '-moz-transform': ' rotate(' + angulo + 'deg)',
                    '-o-transform': ' rotate(' + angulo + 'deg)',
                    '-ms-transform': ' rotate(' + angulo + 'deg)',
                })
                .appendTo($('#areaCentral'));



    lig.div = div;
    lig.image = image;
}

//Funcao que troca a imagem dos carbonos pelo numero e vice versa
function numerarCarbonos() {
    if(!estaNumerado){
        for(var i = 0; i< elementosNoJogo.length; i++) {
            if(elementosNoJogo[i].nome == 'carbono') {
                $(elementosNoJogo[i].div).css({'background-image': 'url("' + imgPath +'atomos/C_preto.png")'});
                $('<p>').attr({'class': 'numCarbonos'})
                        .html(elementosNoJogo[i].numero)
                        .appendTo(elementosNoJogo[i].div);

                estaNumerado = true;
            }
        }
    }
    else {
        $('.numCarbonos').remove();
        for(var i = 0; i< elementosNoJogo.length; i++) {
            if(elementosNoJogo[i].nome == 'carbono') {
                $(elementosNoJogo[i].div).css({'background-image': 'url("' + imgPath + 'atomos/carbono.png")'});
            }
        }
        estaNumerado = false;
    }
}

//Funcao que atualiza a dica
function atualizarDica() {
    $('#textoDica').html(function(){
        if(dica[nivel].length > 180)
        {
            $(this).css({ 'height': '100px', 'padding-top': '0px' });
        }
        else
        {
            if(dica[nivel].length > 93)
            {
                $(this).css({ 'height': '92px', 'padding-top': '8px' });
            }
            else
            {
                $(this).css({ 'height': '85px', 'padding-top': '15px' });
            }
        }
        return dica[nivel];
    });
}

//Funcao que conta quantos carbonos tem na tela
function carbonosEmTela() {
    var aux = 0;
    for(var i = 0; i< elementosNoJogo.length;i++)
    {
        if(elementosNoJogo[i].nome == 'carbono')
        {
            aux++;
        }
    }

    return aux;
}

//Funcao chamada quando quermos trocar o numero de um determinado carbono
//Enviamos como parametro s?a div, porque o valor a ser colocado no carbono ser?pego da caixa de texto
function mudarNumeroCarbono(_div) {

    if($(_div).attr('id').split('-')[0] == 'carbono')
    {
        if(estaNumerado)
        {
            console.log('oi');
            var aux;

            for(var i = 0; i < elementosNoJogo.length; i++)
            {

                    if(elementosNoJogo[i].nome == 'carbono')
                    {
                        if($(_div).attr('id').split("-")[1] == elementosNoJogo[i].codigo)
                        {
                            aux = elementosNoJogo[i];
                        }
                    }
            }

                if($('#tb1').val() <= 0)
                {
                    aux.numero = 1;
                }
                else
                {
                    if($('#tb1').val() > carbonosEmTela())
                    {
                        aux.numero = carbonosEmTela();
                    }
                    else
                    {
                        aux.numero = $('#tb1').val();
                    }
                }
                numerarCarbonos();
                numerarCarbonos();


        }
    }
}

//Funcao que retorna o angulo entre duas divs.(O angulo ?multiplo de 45)
function calcularAngulo(_p1, _p2)   {

    if(Math.abs(_p1.left - _p2.left) <= 5)
    {
        var tangente = (_p1.top - _p2.top)/0;
    }
    else
    {
        var tangente = (_p1.top - _p2.top)/(_p1.left - _p2.left);
    }

    var angulo = Math.round(Math.atan(tangente));

    return (angulo*45);
}

//Funcao que le o xml e chama iniciarJogo
//Caso nao seja possivel ler o xml, retornamos ao menu
function lerXML(_nivel) {
       var file = xmlPath +_nivel + ".xml";
    $.ajax({
        type: "GET",
        url: file,
        dataType: "xml",
        async: false,
        success: function(xml) {

            atomos = new Array();
            moleculaAtual = {};
            var index = 0;

            $(xml).find('molecule').each(function() {
                moleculaAtual.nome = $(this).attr('name');

                var str = $(this).attr('formula');
                var formula = new Array();
                var closed = true;
                for (i = 0; i < str.length; i++) {
                    if (str[i] == '_') {
                        if (closed) {
                            closed = false;
                            formula += "<sub>";
                        } else {
                            closed = true;
                            formula += "</sub>";
                        }
                    } else {
                        formula += str[i];
                    }
                }
                moleculaAtual.formula = formula;
            });

            $(xml).find('atom').each(function(){
                var type = $(this).attr('type');
                var num = $(this).attr('number');
                atomos[index++] = new Data(type, num, new Array());
            });

            $(xml).find('bond').each(function(){
                var src = $(this).attr('source');
                var tgt = $(this).attr('target');
                var type = $(this).attr('type');
                for (i = 0; i < type; i++) {
                    atomos[src].add(atomos[tgt].tipo);
                    atomos[tgt].add(atomos[src].tipo);
                }
            });

            iniciarJogo();
        },

        error: function() {

            destruirJogo();
            criarMenu();
            alert('xml nao encontrado');
        }
    });
}

function criarJogo() {
    var pai = $('#ancora').parent();
    $('<div>').attr("id", "palco").appendTo(pai);
    $('<div>').attr({'id': 'camadaJogo', 'class': 'camada'}).appendTo($('#palco'));
    lerXML(nivel);
}

//Funcao que compara dois vetores(das ligacoes) e verifica se sao iguais
jQuery.fn.compare = function(t) {

    if (this.length != t.length)
    {
        return false;
    }
    var a = this.sort(),
    b = t.sort();
    for (var i = 0; t[i]; i++)
    {
        if (a[i] !== b[i])
        {
                return false;
        }
    }
    return true;
};

//Funcao chamada quando o botao de verificar ?clicado
//Essa funcao chamada todas as outras de verificacoes e compara com o gabarito
//Retorna true se molecula est?correte
function verificacaoFinal() {
    var vetorAtomos = [];
    for(var i=0;i<elementosNoJogo.length;i++)
    {
        var vetorLigas = [];
        for(var j=0;j<elementosNoJogo[i].ligacoesFeitas.length;j++)
        {
            //N? acessamos cada liga?o do elemento atrav? desse loop e para cada liga?o comparamos se o primeiro elementos ?o nosso elemento em quest?. Se for adicionamos o outro ao vetor de liga?es. Se for diferente adicionamos esse elemento ao vetor de liga?es
            for(var k =0;k<elementosNoJogo[i].ligacoesFeitas[j].valor;k++)
                if(elementosNoJogo[i].ligacoesFeitas[j].elementos[0].nome == elementosNoJogo[i].nome)
                    vetorLigas.push(elementosNoJogo[i].ligacoesFeitas[j].elementos[1].nome);
                else
                    vetorLigas.push(elementosNoJogo[i].ligacoesFeitas[j].elementos[0].nome);
        }
        vetorAtomos.push(new Data(elementosNoJogo[i].nome, elementosNoJogo[i].numero, vetorLigas));
    }

    return (compare(atomos.slice(), vetorAtomos));
}

//Funcao que compara dois vetores(sao os vetores finais) e verifica se eles sao iguais
function compare(a, b) {
    if(a.length != b.length)
    {
        return false;
    }
    else
    {
    var achou;
        while(a.length != 0)
        {
            achou = false;
            for(var j = 0; j < b.length; j++)
            {
                if(a[0].compare(b[j]))
                {
                    achou = true;
                    a.splice(0, 1);
                    b.splice(j, 1);
                    break;
                }
            }
            if(!achou)
            {
                return false;
            }
        }
    }

    return true;
}

//Funcao que espera as teclas serem precionadas
//'D' para criar nova  ligacao ou atomo
//'B' cria o xml para usar como gabarito(talvez nao esteja na versao final do jogo)
function debugKeyListeners(evt) {
    var D_UPPERCASE_KEY_CODE = 100

    var evt  = window.event? event : evt;
    var unicode = evt.keyCode? evt.keyCode : evt.charCode;
    if(unicode == D_UPPERCASE_KEY_CODE)
    {

        if(funcaoAtual == "atomo")
        {
            if(elementoSelecionado != null)
            {
                criarAtomo(elementoSelecionado.id);
            }
        }
        else if(funcaoAtual == "ligacao")
        {
            var atom = getAtomoEmPos();

            if(atom != null)
            {
                atomoAtual = atom.div;

                if(atomoSelecionado == null)
                {
                    atomoSelecionado = atomoAtual;
                    ligacaoAtual = elementoSelecionado.id;
                    $(atomoAtual).addClass('atomoSelecionado');
                }
                else if(atomoSelecionado != atomoAtual)
                {
                    selecionaSegundoAtomo(atomoAtual);
                }
            }
        }

    }
}

//Retorna o atomo sobre o qual o mouse esta
function getAtomoEmPos() {
    for(var i=0;i<elementosNoJogo.length;i++)
    {
        if(testaColisaoPonto(mouseObj, $(elementosNoJogo[i].div)))
        {
            return elementosNoJogo[i];
        }
    }
    return null;
}

//Funcao que retorna a posicao do mouse ajustada
function mouseMove(event) {
    var theEvent = event ? event : windown.event;
    var offset = $("#areaCentral").parent().offset();
    if(offset)
    {
        mouseObj.x = theEvent.clientX - offset.left-200;
        mouseObj.y = theEvent.clientY - offset.top;
    }
}