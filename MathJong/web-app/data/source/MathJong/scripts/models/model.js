define(["./checagemLigacao2",  "./tabelaDeDados"],  function (checagem,  tabela) 
{
	
	var CUSTO_DA_DICA = 150, 
	PONTOS_POR_ACERTO = 50, 
	NUM_DE_LINHAS, 
	NUM_DE_COLUNAS, 
	matrizDePecas, 
	tempoRestante, 
	tempoDoNivel, 
	pontuacao = 0, 
	estadoDoJogo = "parado",  //venceu,  perdeu,  impossivel,  jogando,  parado,  pausado
	gravidadeLigada, 
	nivel = 0, 
	cronometro;

	/**
	 * Essa fun��o � chamada no come�o do jogo � gera aleatoriamente a matriz com todas as pe�as do jogo
	 */
	function gerarNovaMatriz()
	{
		NUM_DE_LINHAS  = tabela.obterTamanhoDoNivel(nivel)[0];
		NUM_DE_COLUNAS = tabela.obterTamanhoDoNivel(nivel)[1];
		
		var i, j;
		var vetorAuxiliarParaPegarTexto;
		var vetorAuxiliarParaGerarMatrizAleatoria = new Array(NUM_DE_COLUNAS*NUM_DE_LINHAS);
		var contador = 0;
		var textosDoNivel = tabela.obterTexto(nivel);
		var numeroDeGruposDoNivel = textosDoNivel.length;
		
		for(i=0; i<numeroDeGruposDoNivel; i++)
		{
			vetorAuxiliarParaPegarTexto = textosDoNivel[i]; 			
			for(j=0; j<vetorAuxiliarParaPegarTexto.length; j++)
			{
				vetorAuxiliarParaGerarMatrizAleatoria[contador] = {grupo:i,  texto:vetorAuxiliarParaPegarTexto[j]};
				contador++; 				
			}
		}

		matrizDePecas = new Array(NUM_DE_COLUNAS);
		for ( i = 0;  i < NUM_DE_LINHAS;  i++ )
		{
			matrizDePecas[i] = new Array(NUM_DE_LINHAS);
			for( j = 0;  j < NUM_DE_COLUNAS;  j++ )
			{
				var aux = Math.floor(Math.random()*vetorAuxiliarParaGerarMatrizAleatoria.length);
				var aux2 = vetorAuxiliarParaGerarMatrizAleatoria.splice(aux, 1)[0];
				var grupo = aux2.grupo;
				var texto = aux2.texto;
				
				matrizDePecas[i][j] = {
					pos:	[i,  j], 
					id:		i * NUM_DE_LINHAS + j, 
					valor:	grupo, 
					texto:	texto
				};
			}
		}
	}
	function validarLigacao(peca1,  peca2,  trocarCaminho)
	{
		//Essa fun��o � chamada para checar se as duas pe�as se ligam
		if(peca1.valor == peca2.valor)
		{
			return checarConexao(peca1.pos,  peca2.pos,  trocarCaminho); 			
		}
		else
			return false;
	}
	function checarConexao(pos1,  pos2,  trocarCaminho)
	{
		return checagem.verificar(matrizDePecas,  pos1,  pos2,  [NUM_DE_LINHAS,  NUM_DE_COLUNAS],  trocarCaminho);
	}
	function tratarPecasLigadas(peca1,  peca2)
	{		
		//Tiramos as pe�as da matriz
		matrizDePecas[peca1.pos[0]].splice(peca1.pos[1], 1, null);
		matrizDePecas[peca2.pos[0]].splice(peca2.pos[1], 1, null);
		
		pontuacao += PONTOS_POR_ACERTO;
		
		//Se tiver gravidade n�s a aplicamos
		if(gravidadeLigada)
		{
			aplicarGravidade(peca1.pos);
			aplicarGravidade(peca2.pos);
		}
		
		if(checarFimPorVitoria())
		{
			if(nivel >= tabela.obterNumeroDeNiveis())
			{
				estadoDoJogo = 'finalizado';
			}
			else
			{
				estadoDoJogo = "venceu";
			}
			clearInterval(cronometro);
			return true;
		}
		else if(checarFimPorImpossibilidade())
		{
			estadoDoJogo = "impossivel";
			return true;
		}
	}
	function aplicarGravidade(pos)
	{
		var j = pos[1]; 	
		var acabou = false;
		while(!acabou)
		{
			acabou = true;
			for(i=pos[0]; i>0; i--)
			{
				if(matrizDePecas[i][j] == null && matrizDePecas[i-1][j] != null)
				{
					acabou = false;
					matrizDePecas[i][j] = matrizDePecas[i-1][j];
					matrizDePecas[i][j].pos[0] += 1;  //atualizamos a posi��o da pe�a na matriz
					matrizDePecas[i-1][j] = null;
				}
			}
			pos[1]--;
		}				
	}

	/**
	 * Searches for pieces in the matrix.
	 *
	 * @return @true if matrix is empty. @false,  otherwise.
	 */
	function matrizVazia()
	{
		for( var i = 0;  i < NUM_DE_LINHAS;  i++ )
			for( var j = 0;  j < NUM_DE_COLUNAS;  j++ )
				if(matrizDePecas[i][j])
					return false;

		return true;
	}
	function resetarPontuacao()
	{
		if(nivel == 0)
		{
			pontuacao = 0;
		}
	}
	function ajustarPontuacao(valor)
	{
		pontuacao += valor;
	}

	/**
	 * Obtains maximum time to finish current level.
	 *
	 */
	function resetarCronometro()
	{
		tempoRestante = tempoDoNivel = tabela.obterTempo(nivel);
	}
	function atualizar()
	{
		ajustarCronometro();
		if(checarFinalDeJogo())
			clearInterval(cronometro);
	}
	function ajustarCronometro()
	{
		tempoRestante--;
	}
	function checarFinalDeJogo()
	{
		//Essa fun��o checa se o jogo j� acabou
		//O jogo acaba quando n�o existem mais pe�as em jogo,  n�o existem mais liga��es ou o tempo acabou
		if(checarFimPorTempo())
		{
			estadoDoJogo = "perdeu";
			clearInterval(cronometro);
			return true;
		}else
			return false;
	}
	function checarFimPorVitoria()
	{
		return matrizVazia();
	}
	function checarFimPorTempo()
	{
		return tempoRestante<=0;
	}
	function checarFimPorImpossibilidade()
	{
		return checarPossivelLigacao() == false;
	}
	function checarPossivelLigacao()
	{
		//algoritmo de checagem de combina��o
		var i, j, x, y;
		for ( i = NUM_DE_LINHAS -1; i >= 0; i-- )
		{
			for ( j = NUM_DE_COLUNAS -1; j >= 0; j-- )
			{
				if(matrizDePecas[i][j] == null)
					continue;
				else
				{
					for ( x = NUM_DE_LINHAS -1; x >= 0; x-- )
						for ( y = NUM_DE_COLUNAS -1; y >= 0; y-- )
						{
							if ( matrizDePecas[x][y] == null || matrizDePecas[i][j] == matrizDePecas[x][y] )
								continue;
							else
							{
								var peca1 = matrizDePecas[i][j];
								var peca2 = matrizDePecas[x][y]; 								
								if(validarLigacao(peca1,  peca2,  false))
								{
									return [peca1, peca2];
								}
								else
									continue;
							}
						}
				}
			}
		}
		return false;
	}
	function reordenarMatriz()
	{
		var i, j; 		
		var vetorPos = new Array();
		var vetorPecas = new Array();
		var vetorMudancas = new Array();
			
		for ( i = 0;  i < NUM_DE_LINHAS;  i++ )
			for ( j = 0;  j < NUM_DE_COLUNAS;  j++ )
				if ( matrizDePecas[i][j] != null )
				{
					vetorPos.push([i, j]);
					vetorPecas.push(matrizDePecas[i].splice(j, 1, null)[0]);
				}
				
		
		for ( i = 0;  i < vetorPos.length;  i++ )
		{
			var x = vetorPos[i][0];
			var y = vetorPos[i][1];
			matrizDePecas[x][y] = vetorPecas.splice(Math.floor(Math.random()*vetorPecas.length), 1)[0];
			var mudanca = {x0:matrizDePecas[x][y].pos[0],  y0:matrizDePecas[x][y].pos[1],  x1:vetorPos[i][0],  y1:vetorPos[i][1]}; 	
			matrizDePecas[x][y].pos = vetorPos[i];
			vetorMudancas.push(mudanca);
		}

		return vetorMudancas;
	}
	
	
	return		{	
		checarFimPorImpossibilidade: function()
		{
			if(checarFimPorImpossibilidade())
			{
				estadoDoJogo = "impossivel";
				return true;
			}else
			{
				return false;
			}
		}, 	
		iniciarJogo:function()
		{	
			if(estadoDoJogo == "perdeu")
				estadoDoJogo = 'parado';
			
			//Ajusta cronometro,  gera matriz,  incia pontua��o
			if(estadoDoJogo == "parado")
			{				
				resetarCronometro();
				resetarPontuacao();
				gerarNovaMatriz();
				estadoDoJogo = "jogando";
				cronometro = setInterval(atualizar,  1000); 				
			}
		}, 
		obterNivel: function()
		{
			return nivel;
		},
		obterNumeroDeNiveis: function() {
			return tabela.obterNumeroDeNiveis();
		},
		proximoNivel:function()
		{
			clearInterval(cronometro);
			estadoDoJogo = "parado";
			
			if(nivel<tabela.obterNumeroDeNiveis())
			{
				nivel++;
			}
			else
			{
				estadoDoJogo = "finalizado";
			}
		},
		fazerPossivel:function()
		{
			if(estadoDoJogo == "impossivel")
			{
				estadoDoJogo = "jogando";
				return reordenarMatriz();
			}
		}, 
		sairJogo:function()
		{			
			estadoDoJogo = "parado";
			nivel = 0;
			clearInterval(cronometro);
		}, 	
		retornarPecasQueSeLigam: function ()
		{			
			if(pontuacao >= CUSTO_DA_DICA)
			{
				pontuacao -= CUSTO_DA_DICA;
				return checarPossivelLigacao();
			}
			else
			{
				
				return false;
			}
		}, 
		checarPossivelLigacao: checarPossivelLigacao, 
		tentarLigar: function(pos1,  pos2)
		{
			if(estadoDoJogo == 'jogando')
			{
				var peca1 = matrizDePecas[pos1[0]][pos1[1]];
				var peca2 = matrizDePecas[pos2[0]][pos2[1]];
				
				if(validarLigacao(peca1,  peca2,  true))
				{
					tratarPecasLigadas(peca1,  peca2);
					return true;
				}
				else
					return false;
			}
			else
			{
				return false;
			}
		}, 
		obterTempoDoNivel: function()
		{
			return tempoDoNivel;
		}, 
		obterTempoRestante:function()
		{
			return tempoRestante;
		}, 
		obterCaminho:function()
		{
			return checagem.obterCaminho();
		}, 
		obterPontuacao:function()
		{
			return pontuacao;
		}, 
		obterMatrizDePecas:function()
		{			
			return matrizDePecas;
		}, 
		obterEstadoDeJogo:function()
		{
			return estadoDoJogo;
		}, 
		obterNumeroDeLinhas: function()
		{
			return NUM_DE_LINHAS;
		}, 
		obterNumeroDeColunas: function()
		{
			return NUM_DE_COLUNAS;
		}, 
		obterCustoDaDica: function() {
			return CUSTO_DA_DICA;
		}, 
		ajustarGravidade:function(valor)
		{
			gravidadeLigada = valor;
		}, 	
		obterGravidade: function()
		{
			return gravidadeLigada;
		}, 
		tratarFinalDoJogo: function()
		{
			nivel = 0;
			estadoDoJogo = 'parado';
		}, 
		pausarCronometro: function() {
			estadoDoJogo = 'pausado';
			clearInterval(cronometro);
		}, 
		continuarCronometro: function() {
			estadoDoJogo = 'jogando';
			cronometro = setInterval(atualizar,  1000); 	
		}, 
	};
}); 