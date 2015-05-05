function iniciar()
{	
	//Essa variavel vai conter todas as letras que o jogador ja tentou
	jogo.letrasTentadas = new Array();
	jogo.letrasTentadas = [" "];
	
	jogo.sorteio = parseInt((Math.random()*10000)%jogo.bdTamanho);
	
	jogo.botaoVoltar = document.createElement("div");
	jogo.botaoVoltar.setAttribute("id" , "btnVoltar");
	jogo.botaoVoltar.setAttribute("tabIndex" , "0");
	jogo.botaoVoltar.setAttribute("role" , "button");
	jogo.botaoVoltar.setAttribute("aria-label" , "Voltar");
	
	jogo.botaoVoltar.onclick = function() {
		ativarBotaoVoltar();		
	}
	jogo.botaoVoltar.onfocus = function() {		
		adicionarComandosEnterSpace(ativarBotaoVoltar, jogo.botaoVoltar);
	}
	jogo.botaoVoltar.onblur = function() {		
		removerComandosEnterSpace();
	}
	$("#camadaJogo").append(jogo.botaoVoltar);
	
	jogo.falador = document.createElement("div");
	jogo.falador.setAttribute("id", "falador");
	jogo.falador.setAttribute("aria-live", "polite");
	jogo.falador.setAttribute("role", "log");
	$("#camadaJogo").append(jogo.falador);
	
	
	jogo.dicaNaTela = document.createElement("div");
	jogo.dicaNaTela.setAttribute("id", "dicaNaTela");
	jogo.dicaNaTela.setAttribute("tabIndex", "1");
	jogo.dicaNaTela.setAttribute("role" , "textbox");
	
	var p = document.createElement("p");
	p.setAttribute("class", "customfont");
	p.innerHTML = jogo.bd[jogo.bdAux[jogo.sorteio]].dica;
	jogo.dicaNaTela.setAttribute("aria-label", jogo.bd[jogo.bdAux[jogo.sorteio]].dica);
	//jogo.dicaNaTela.setAttribute("role", "textbox");
	jogo.dicaNaTela.appendChild(p);

	if(jogo.bd[jogo.bdAux[jogo.sorteio]].contribuicao != "0") {
		jogo.contribuicaoNaTela = document.createElement("p");
		jogo.contribuicaoNaTela.setAttribute("id", "contribuicaoNaTela");
		jogo.contribuicaoNaTela.setAttribute("class", "customfont");
		jogo.contribuicaoNaTela.innerHTML = "Contribuição de: "+jogo.bd[jogo.bdAux[jogo.sorteio]].contribuicao;
		$("#camadaJogo").append(jogo.contribuicaoNaTela);

	}
	$("#camadaJogo").append(jogo.dicaNaTela);
	
	$('<p>').attr('id', 'pontosNaTela')
				.html('Pontos: ' + Math.round(jogo.pontos))
				.appendTo($('#camadaJogo'));
	
	//Pegamos uma palavra aleatoria
	

	jogo.palavraSorteada = jogo.bd[jogo.bdAux[jogo.sorteio]].palavra;
	
	jogo.aux = "";
	for(var i = 0; i < jogo.palavraSorteada.length; i++)
	{
		jogo.aux += jogo.palavraSorteada[i] + " ";
	}

	//Essa é a variavel que deve ser exibida na tela
	jogo.palavraNaTela = document.createElement("p");
	jogo.palavraNaTela.setAttribute("id", "palavraNaTela");
	jogo.palavraNaTela.setAttribute("tabIndex", "2");
	jogo.palavraNaTela.setAttribute("role", "textbox");
	$("#camadaJogo").append(jogo.palavraNaTela);

	jogo.erros = 0;
	jogo.emTransicao = false;
	
	//Aqui nós tiramos a palavra que ja foi sorteada, para ela nao ser sorteada novamente
	jogo.bdTamanho--;
	var ajuda = jogo.bdAux[jogo.bdTamanho];
	jogo.bdAux[jogo.bdTamanho] = jogo.bdAux[jogo.sorteio];
	jogo.bdAux[jogo.sorteio] = ajuda;
	
	colocarTecladoNaTela();
	colocarPersonagem();
	update();
}

function update()
{
	atualizarPalavra();
	
	switch(fimDeJogo())
	{
		case -1:
		//Continua o jogo normal
		setTimeout(update, 50);
		break;
		case 0:
		//Fim de jogo: jogador perdeu
		jogo.palavraNaTela.innerHTML = jogo.palavraSorteada;
		criarCamadaDerrota();
		break;
		case 1:
		//Fim de jogo: jogador ganhou
		var el = document.getElementById("camadaJogo");
		
		var aux = 5*Math.pow(0.8, jogo.erros);

		jogo.pontos = jogo.pontos + aux;
		
		
		
		$('<div>').attr({'id': 'palavraCerta',})
				.appendTo(el);
		
		el.onclick = function() {
			destruirCamadaJogo();
			criarCamadaVitoria();
		}
		break;
	}	
}

//Funcao que verifica se o jogo terminou(erros > 5 ou palavra completa)
function fimDeJogo()
{
	if(jogo.aux == jogo.palavraNaTela.innerHTML)
	{		
		return 1;
	}
	else
	{
		if(jogo.erros >= 5)
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

	for(var i = 0; i < jogo.letrasTentadas.length; i++)
	{
		if(_letra == jogo.letrasTentadas[i])
		{
			deuErro = false;
		}
	}
	
	for(var i = 0; i < jogo.palavraSorteada.length; i++)
	{
		if(_letra == jogo.palavraSorteada[i])
		{
			deuErro = false;
		}		
		else
		{
			if(_letra == "I")
			{
				if("Í" == jogo.palavraSorteada[i])
				{
					deuErro = false;
				}
			}
				
			if(_letra == "E")
			{
				if(("É" == jogo.palavraSorteada[i]) || ("Ê" == jogo.palavraSorteada[i]))
				{
					deuErro = false;
				}
			}

			if(_letra == "A")
			{
				if(("Ã" == jogo.palavraSorteada[i]) || ("Â" == jogo.palavraSorteada[i]) || ("Á" == jogo.palavraSorteada[i]))
				{
					deuErro = false;
				}
			}
				
			if(_letra == "O")
			{
				if(("Ó" == jogo.palavraSorteada[i]) || ("Õ" == jogo.palavraSorteada[i]) || ("Ô" == jogo.palavraSorteada[i]))
				{
					deuErro = false;
				}
			}
			
			if(_letra == "C")
			{
				if("Ç" == jogo.palavraSorteada[i])
				{
					deuErro = false;
				}
			}
			
			if(_letra == "U")
			{
				if("Ú" == jogo.palavraSorteada[i])
				{
					deuErro = false;
				}
			}
		}
	}
	if(!deuErro)
	{
		$("#falador").text("Letra Certa");
	}
	if(deuErro)
	{
		$("#falador").text("Letra Errada");
		jogo.erros++;
		mudarPersonagem();
	}
}

//Coloca os botoes do teclado na tela
function colocarTecladoNaTela()
{
	var botoes = document.createElement("div");
	botoes.setAttribute("id", "botoes");
	$("#camadaJogo").append(botoes);
	
	var linha1 = new Linha(1);
	var linha1 = new Linha(2);
	var linha1 = new Linha(3);
	
	var btQ = new Botao("Q", 1);
	var btW = new Botao("W", 1);
	var btE = new Botao("E", 1);
	var btR = new Botao("R", 1);
	var btT = new Botao("T", 1);
	var btY = new Botao("Y", 1);
	var btU = new Botao("U", 1);
	var btI = new Botao("I", 1);
	var btO = new Botao("O", 1);
	var btP = new Botao("P", 1);
	var btA = new Botao("A", 2);
	var btS = new Botao("S", 2);
	var btD = new Botao("D", 2);
	var btF = new Botao("F", 2);
	var btG = new Botao("G", 2);
	var btH = new Botao("H", 2);
	var btJ = new Botao("J", 2);
	var btK = new Botao("K", 2);
	var btL = new Botao("L", 2);
	var btZ = new Botao("Z", 3);
	var btX = new Botao("X", 3);
	var btC = new Botao("C", 3);
	var btV = new Botao("V", 3);
	var btB = new Botao("B", 3);
	var btN = new Botao("N", 3);
	var btM = new Botao("M", 3);	
}

//Simplesmente coloca a variavel que recebe como parametro no vetor de letras tentadas
function colocarLetraEmLetrasTentadas(_letra)
{
	var naoEstavaAinda = true;
	for(var i = 0; i < jogo.letrasTentadas.length; i++)
	{
		if(jogo.letrasTentadas[i] == _letra)
		{
			naoEstavaAinda = false;
		}
	}
	
	if(naoEstavaAinda)
	{
		//I acentuado
		if(_letra == "I")
		{
			jogo.letrasTentadas[i+1] = "Í";
		}
		
		//E acentuado
		if(_letra == "E")
		{
			jogo.letrasTentadas[i+1] = "É";
			jogo.letrasTentadas[i+2] = "Ê";
		}
		
		//A acentuado
		if(_letra == "A")
		{
			jogo.letrasTentadas[i+1] = "Ã";
			jogo.letrasTentadas[i+2] = "Â";
			jogo.letrasTentadas[i+3] = "Á";
		}
		
		//Ç
		if(_letra == "C")
		{
			jogo.letrasTentadas[i+1] = "Ç";
		}
		
		//O acentuado
		if(_letra == "O")
		{
			jogo.letrasTentadas[i+1] = "Ó";
			jogo.letrasTentadas[i+2] = "Õ";
			jogo.letrasTentadas[i+3] = "Ô";
		}
		
		if(_letra == "U")
		{
			jogo.letrasTentadas[i+1] = "Ú";
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
	for(var i = 0; i < jogo.palavraSorteada.length; i++)
	{
		jogo.achou = false;
		for(var j = 0; j < jogo.letrasTentadas.length; j++)
		{
			if(jogo.palavraSorteada[i] == jogo.letrasTentadas[j])
			{
				jogo.achou = true;
			}
		}	
		if(jogo.achou)
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
	
	$('#personagemAnt').fadeIn(1, function() {}).attr('style', 'background-position: -' + (jogo.erros-1)*317 + 'px 0px;').css("z-index", 12);
	$('#personagem').attr('style', 'background-position: -' + jogo.erros*317 + 'px 0px;').fadeOut(0,00001, function() {});
	$('#personagem').fadeIn(500, function() {});
	$('#personagemAnt').fadeOut(1000, function() {$(this).css("z-index", "10"); jogo.emTransicao = false;});
}

function iniciarNovoJogo()
{   
	jogo.pontos = 0;

	jogo.bdAux = new Array;
	jogo.bdTamanho = jogo.bd.length;
	
	for(var i = 0; i < jogo.bd.length; i++)
	{
		jogo.bdAux[i] = i;
	}
}


var funcaoBotao;
var objetoBotao;

function ativarBotaoVoltar ()
{
	destruirCamadaJogo();
	iniciarNovoJogo();
	criarCamadaMenu();
}

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
	
	switch(event.which) 
	{		
		case 13:
		case 32:
			funcaoBotao();
		break;
		case 9:
			
			var jobj = $(objetoBotao);			
			if(event.shiftKey)
			{
				$('[tabIndex='+(jobj.attr("tabIndex")+1)+']').focus();
			}
			else
			{
				$('[tabIndex='+(jobj.attr("tabIndex")-1)+']').focus();			
			}
			objetoBotao.blur();
		break;
	}
}
