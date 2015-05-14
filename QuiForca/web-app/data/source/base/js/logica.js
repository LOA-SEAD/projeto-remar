function iniciar() {

    //Essa variavel vai conter todas as letras que o jogador ja tentou
    jogo.letrasTentadas = new Array();
    jogo.letrasTentadas = [" "];

    jogo.sorteio = parseInt((Math.random() * 10000) % jogo.bdTamanho);

    var p = document.getElementById('dicaNaTela');
    p.innerHTML = '<p class="customfont" >' + jogo.bd[jogo.bdAux[jogo.sorteio]].dica + "</p>";
    p.setAttribute('aria-label', jogo.bd[jogo.bdAux[jogo.sorteio]].dica);

    if (jogo.bd[jogo.bdAux[jogo.sorteio]].contribuicao != "0") {
        var contribuicao = document.getElementById('contribuicaoNaTela').style.display;
        contribuicao.innerHTML = "Contribuição de: " + jogo.bd[jogo.bdAux[jogo.sorteio]].contribuicao;
    }

    var pontos = document.getElementById('pontosNaTela');
    pontos.innerHTML = 'Pontos: ' + Math.round(jogo.pontos);
    pontos.setAttribute('aria-label', 'Pontos: ' + Math.round(jogo.pontos));

    //Pegamos uma palavra aleatoria

    jogo.palavraSorteada = jogo.bd[jogo.bdAux[jogo.sorteio]].palavra;
    //alert(jogo.palavraSorteada);
    jogo.aux = "";
    for (var i = 0; i < jogo.palavraSorteada.length; i++)
    {
        jogo.aux += jogo.palavraSorteada[i] + " ";
    }

    //Essa é a variavel que deve ser exibida na tela
    jogo.palavraNaTela = document.getElementById('palavraNaTela');

    jogo.erros = 0;
    jogo.emTransicao = false;

    //Aqui nós tiramos a palavra que ja foi sorteada, para ela nao ser sorteada novamente
    jogo.bdTamanho--;
    var ajuda = jogo.bdAux[jogo.bdTamanho];
    jogo.bdAux[jogo.bdTamanho] = jogo.bdAux[jogo.sorteio];
    jogo.bdAux[jogo.sorteio] = ajuda;

    reiniciar_teclado();

    reiniciar_personagem();

    $("#falador").text("");

    update();
}

function update()
{
    atualizarPalavra();

    switch (fimDeJogo())
    {
        case -1:
            //Continua o jogo normal
            setTimeout(update, 50);
            break;
        case 0:
            //Fim de jogo: jogador perdeu
            jogo.palavraNaTela.innerHTML = jogo.palavraSorteada;
            mostra_derrota();
            break;
        case 1:
            //Fim de jogo: jogador ganhou
            //var el = document.getElementById("camadaJogo");

            var aux = 5 * Math.pow(0.8, jogo.erros);

            jogo.pontos = jogo.pontos + aux;

            /*$('<div>').attr({'id': 'palavraCerta', })
             .appendTo(el);*/

            //el.onclick = function () {
            mostra_vitoria();
            //}
            break;
    }
}

function reiniciar_teclado() {
    var i, botao;
    for (i = 65; i <= 90; i++) {
        botao = document.getElementById('botao' + String.fromCharCode(i));
        botao.setAttribute('style', 'color:black;');
        botao.setAttribute('onclick', 'click_botao("' + String.fromCharCode(i) + '")');
    }




    /*var linha1 = document.getElementById('linha1');
     linha1.innerHTML = '<div class="botaoJogo" id="botaoQ"><p class="letraTeclado">Q</p></div><div class="botaoJogo" id="botaoW"><p class="letraTeclado">W</p></div><div class="botaoJogo" id="botaoE"><p class="letraTeclado">E</p></div><div class="botaoJogo" id="botaoR"><p class="letraTeclado">R</p></div><div class="botaoJogo" id="botaoT"><p class="letraTeclado">T</p></div><div class="botaoJogo" id="botaoY"><p class="letraTeclado">Y</p></div><div class="botaoJogo" id="botaoU"><p class="letraTeclado">U</p></div><div class="botaoJogo" id="botaoI"><p class="letraTeclado">I</p></div><div class="botaoJogo" id="botaoO"><p class="letraTeclado">O</p></div><div class="botaoJogo" id="botaoP"><p class="letraTeclado">P</p></div>';
     
     var linha2 = document.getElementById('linha2');
     linha2.innerHTML = '<div class="botaoJogo" id="botaoA"><p class="letraTeclado">A</p></div><div class="botaoJogo" id="botaoS"><p class="letraTeclado">S</p></div><div class="botaoJogo" id="botaoD"><p class="letraTeclado">D</p></div><div class="botaoJogo" id="botaoF"><p class="letraTeclado">F</p></div><div class="botaoJogo" id="botaoG"><p class="letraTeclado">G</p></div><div class="botaoJogo" id="botaoH"><p class="letraTeclado">H</p></div><div class="botaoJogo" id="botaoJ"><p class="letraTeclado">J</p></div><div class="botaoJogo" id="botaoK"><p class="letraTeclado">K</p></div><div class="botaoJogo" id="botaoL"><p class="letraTeclado">L</p></div>';
     
     var linha3 = document.getElementById('linha3');
     linha3.innerHTML = '<div class="botaoJogo" id="botaoZ"><p class="letraTeclado">Z</p></div><div class="botaoJogo" id="botaoX"><p class="letraTeclado">X</p></div><div class="botaoJogo" id="botaoC"><p class="letraTeclado">C</p></div><div class="botaoJogo" id="botaoV"><p class="letraTeclado">V</p></div><div class="botaoJogo" id="botaoB"><p class="letraTeclado">B</p></div><div class="botaoJogo" id="botaoN"><p class="letraTeclado">N</p></div><div class="botaoJogo" id="botaoM"><p class="letraTeclado">M</p></div>';*/
}
//Funcao que verifica se o jogo terminou(erros > 5 ou palavra completa)
function fimDeJogo()
{
    if (jogo.aux == jogo.palavraNaTela.innerHTML)
    {
        return 1;
    }
    else
    {
        if (jogo.erros >= 5)
        {
            return 0;
        }
        else
        {
            return -1;
        }
    }
}

//Funcao que recebe uma letra e verifica se numero de erros deve subir
function verificarErro(_letra)
{
    var deuErro = true;

    for (var i = 0; i < jogo.letrasTentadas.length; i++)
    {
        if (_letra == jogo.letrasTentadas[i])
        {
            deuErro = false;
        }
    }

    for (var i = 0; i < jogo.palavraSorteada.length; i++)
    {
        if (_letra == jogo.palavraSorteada[i])
        {
            deuErro = false;
        }
        else
        {
            if (_letra == "I")
            {
                if ("Í" == jogo.palavraSorteada[i])
                {
                    deuErro = false;
                }
            }

            if (_letra == "E")
            {
                if (("É" == jogo.palavraSorteada[i]) || ("Ê" == jogo.palavraSorteada[i]))
                {
                    deuErro = false;
                }
            }

            if (_letra == "A")
            {
                if (("Ã" == jogo.palavraSorteada[i]) || ("Â" == jogo.palavraSorteada[i]) || ("Á" == jogo.palavraSorteada[i]))
                {
                    deuErro = false;
                }
            }

            if (_letra == "O")
            {
                if (("Ó" == jogo.palavraSorteada[i]) || ("Õ" == jogo.palavraSorteada[i]) || ("Ô" == jogo.palavraSorteada[i]))
                {
                    deuErro = false;
                }
            }

            if (_letra == "C")
            {
                if ("Ç" == jogo.palavraSorteada[i])
                {
                    deuErro = false;
                }
            }

            if (_letra == "U")
            {
                if ("Ú" == jogo.palavraSorteada[i])
                {
                    deuErro = false;
                }
            }
        }
    }
    if (!deuErro)
    {
        //$("#falador").text("Letra Certa");
        //document.getElementById('tada').play();
    }
    if (deuErro)
    {
        //$("#falador").text("Letra Errada");
        //document.getElementById('slap').play();
        jogo.erros++;
        mudarPersonagem();
    }
}

//Simplesmente coloca a variavel que recebe como parametro no vetor de letras tentadas
function colocarLetraEmLetrasTentadas(_letra)
{
    var naoEstavaAinda = true;
    for (var i = 0; i < jogo.letrasTentadas.length; i++)
    {
        if (jogo.letrasTentadas[i] == _letra)
        {
            naoEstavaAinda = false;
        }
    }

    if (naoEstavaAinda)
    {
        //I acentuado
        if (_letra == "I")
        {
            jogo.letrasTentadas[i + 1] = "Í";
        }

        //E acentuado
        if (_letra == "E")
        {
            jogo.letrasTentadas[i + 1] = "É";
            jogo.letrasTentadas[i + 2] = "Ê";
        }

        //A acentuado
        if (_letra == "A")
        {
            jogo.letrasTentadas[i + 1] = "Ã";
            jogo.letrasTentadas[i + 2] = "Â";
            jogo.letrasTentadas[i + 3] = "Á";
        }

        //Ç
        if (_letra == "C")
        {
            jogo.letrasTentadas[i + 1] = "Ç";
        }

        //O acentuado
        if (_letra == "O")
        {
            jogo.letrasTentadas[i + 1] = "Ó";
            jogo.letrasTentadas[i + 2] = "Õ";
            jogo.letrasTentadas[i + 3] = "Ô";
        }

        if (_letra == "U")
        {
            jogo.letrasTentadas[i + 1] = "Ú";
        }

        jogo.letrasTentadas[i] = _letra;
        mudarCor(_letra);
    }


}

function mudarCor(_letra)
{
    $("#botao" + _letra).attr("style", 'color: red;');
}

//Logica para ver se palavra foi atualizada
function atualizarPalavra()
{
    var ariaLabel = "";
    jogo.palavraNaTela.innerHTML = "";
    for (var i = 0; i < jogo.palavraSorteada.length; i++)
    {
        jogo.achou = false;
        for (var j = 0; j < jogo.letrasTentadas.length; j++)
        {
            if (jogo.palavraSorteada[i] == jogo.letrasTentadas[j])
            {
                jogo.achou = true;
            }
        }
        if (jogo.achou)
        {
            jogo.palavraNaTela.innerHTML += jogo.palavraSorteada[i];
            ariaLabel += jogo.palavraSorteada[i];
        }
        else
        {
            jogo.palavraNaTela.innerHTML += "_"
            ariaLabel += "_";
        }
        jogo.palavraNaTela.innerHTML += " ";

    }
    jogo.palavraNaTela.setAttribute("aria-label", ariaLabel);

}

function reiniciar_personagem()
{
    var personagem = document.getElementById('personagem');
    personagem.setAttribute('style', 'display: block;');
}

function colocarPersonagem()
{
    jogo.personagem = document.createElement("div");
    jogo.personagem.setAttribute("id", "personagem");
    jogo.personagem.setAttribute("class", "personagem");
    $("#camadaJogo").append(jogo.personagem);


    jogo.personagemAnt = document.createElement("div");
    jogo.personagemAnt.setAttribute("id", "personagemAnt");
    jogo.personagemAnt.setAttribute("class", "personagem");
    $("#camadaJogo").append(jogo.personagemAnt);
}

function mudarPersonagem()
{
    jogo.emTransicao = true;

    $('#personagemAnt').fadeIn(1, function () {
    }).attr('style', 'background-position: -' + (jogo.erros - 1) * 317 + 'px 0px;').css("z-index", 12);
    $('#personagem').attr('style', 'background-position: -' + jogo.erros * 317 + 'px 0px;').fadeOut(0, 00001, function () {
    });
    $('#personagem').fadeIn(500, function () {
    });
    $('#personagemAnt').fadeOut(1000, function () {
        $(this).css("z-index", "10");
        jogo.emTransicao = false;
    });
}

function iniciarNovoJogo()
{
    jogo.pontos = 0;

    jogo.bdAux = new Array;
    jogo.bdTamanho = jogo.bd.length;

    for (var i = 0; i < jogo.bd.length; i++)
    {
        jogo.bdAux[i] = i;
    }
}


var funcaoBotao;
var objetoBotao;

function adicionarComandosEnterSpace(funcao, objBotao)
{
    funcaoBotao = funcao;
    objetoBotao = objBotao;
    window.addEventListener("keydown", keyDown);
}

function removerComandosEnterSpace()
{
    funcaoBotao = null;
    objetoBotao = null;
    window.removeEventListener("keydown", keyDown);
}

function keyDown(event)
{
    event.preventDefault();

    switch (event.which)
    {
        case 13:
        case 32:
            funcaoBotao();
            break;
        case 9:

            var jobj = $(objetoBotao);
            if (event.shiftKey)
            {
                $('[tabIndex=' + (jobj.attr("tabIndex") + 1) + ']').focus();
            }
            else
            {
                $('[tabIndex=' + (jobj.attr("tabIndex") - 1) + ']').focus();
            }
            objetoBotao.blur();
            break;
    }
}
