define([], function () 
{
	var matriz,
	NUM_DE_LINHAS,
	NUM_DE_COLUNAS,
	posInicial,
	posFinal,
	noInicial,
	noFinal,
	caminho;
	
	function node(_x, _y)
	{
		this.x = _x;
		this.y = _y;
		
		this.cameFrom = null;
		this.custo = 100;		
	}
	function checkIfEmpty(pos)
	{
		if((pos[0] == noInicial.x && pos[1] == noInicial.y )|| (pos[0] == noFinal.x && pos[1] == noFinal.y))
			return true;
		if(pos[0] <0 || pos[0] > NUM_DE_LINHAS-1)
			return false;
		if(pos[1] <0 || pos[1] > NUM_DE_COLUNAS-1)
			return false;
		if(pos[0] == 0 || pos[0] == NUM_DE_LINHAS-1)
			return true;
		if(pos[1] == 0 || pos[1] == NUM_DE_COLUNAS-1)
			return true;
		if(matriz[pos[0]-1][pos[1]-1] == null)
			return true;
		else
			return false;
	}
	/*
	function estaNaLista(pos, lista)
	{
		var i;
		for(i=0;i<lista.length;i++)
			if(pos[0] == lista[i].x && pos[1] == lista[i].y)
				return true;
		
		return false;
	}
	*/

	function noMenor(lista)
	{
		var i;
		var menor = 0;
		for(i=1;i<lista.length;i++)
			menor =(lista[menor].custo < lista[i].custo) ? menor : i;
		
		return menor;		
	}
	function checarVizinhos(noAtual)
	{
		
		var pos = [noAtual.x, noAtual.y];	
		var posCima = [pos[0],pos[1]];
		var posBaixo = [pos[0],pos[1]];
		var posDireita = [pos[0],pos[1]];
		var posEsquerda = [pos[0],pos[1]];
		posCima[1]-=1;
		posBaixo[1]+=1;
		posDireita[0]+=1;
		posEsquerda[0]-=1;
		
		var cima = checkIfEmpty(posCima);	
		var direita = checkIfEmpty(posDireita); 
		var baixo = checkIfEmpty(posBaixo);
		var esquerda = checkIfEmpty(posEsquerda);
		
		if(noAtual.cameFrom != null)
		{
			if(noAtual.cameFrom.x == posCima[0] && noAtual.cameFrom.y == posCima[1])
				cima = false;
			else if(noAtual.cameFrom.x == posBaixo[0] && noAtual.cameFrom.y == posBaixo[1])
				baixo = false;
			else if(noAtual.cameFrom.x == posEsquerda[0] && noAtual.cameFrom.y == posEsquerda[1])
				esquerda = false;
			else if(noAtual.cameFrom.x == posDireita[0] && noAtual.cameFrom.y == posDireita[1])
				direita = false;
		}
		
		
		return [cima ? posCima : false, direita ? posDireita : false, baixo ? posBaixo : false, esquerda ? posEsquerda : false];	
	}

	function direcao (noa, nob)
	{
		if(nob == null)
			return 0;

		disx = Math.abs(noa.x - nob.x);
		disy = Math.abs(noa.y - nob.y);

		

		if(disx==1 && disy == 1)
		{
			return 1;
		}else
		{
			return 0;
		}
	}
	
	function modDjkistra(trocarCaminho)
	{
		var i;
		
		var nos = new Array(NUM_DE_LINHAS);
		for(i=0;i<NUM_DE_LINHAS;i++)
		{	
			nos[i] = new Array(NUM_DE_COLUNAS);
			for(j=0;j<NUM_DE_COLUNAS;j++)
				nos[i][j] = new node(i,j);
		}		
		
		noInicial = nos[posInicial[0]+1][posInicial[1]+1];
		noFinal = nos[posFinal[0]+1][posFinal[1]+1];
		
		var conjunto = Array();
		
		for(i=0;i<NUM_DE_LINHAS;i++)
		{				
			for(j=0;j<NUM_DE_COLUNAS;j++)
				conjunto.push(nos[i][j]);
		}

		noInicial.custo = 0;
		
		it = 0;
		while(conjunto.length > 0)
		{
			if(noFinal.custo < 3)
				break;

			it++;
			var index = noMenor(conjunto);
			var vertice = conjunto[index];
			
			if(vertice.custo == 100)
				break;


			conjunto.splice(index, 1);


			if(vertice.custo > 2)
			{
				continue;
			}else
			{
				var vizinhos = checarVizinhos(vertice);
				//console.log("Atual: ", vertice, "Vizinhos :", vizinhos);
				for(i in vizinhos)
				{
					if(vizinhos[i] != false)
					{
						var vizinho = nos[vizinhos[i][0]][vizinhos[i][1]];

						var distuv = vertice.custo + direcao(vizinho, vertice.cameFrom);
						if(distuv < vizinho.custo)
						{
							vizinho.custo = distuv;
							vizinho.cameFrom = vertice;						
						}
						else if(distuv == vizinho.custo)
						{
							var novoNo = new node(vizinho.x, vizinho.y);
							novoNo.custo = distuv;
							novoNo.cameFrom = vertice;

							conjunto.push(novoNo);
						}
					}
				}
			}			
		}	

		if(trocarCaminho)
		{
			caminho = new Array();
			var noAuxRetorno;
			noAuxRetorno = noFinal;

			while(noAuxRetorno != noInicial && noAuxRetorno != null)
			{
				caminho.push({x:noAuxRetorno.x, y:noAuxRetorno.y,});
				noAuxRetorno = noAuxRetorno.cameFrom;
			}
			caminho.push({x:noInicial.x, y:noInicial.y,});
		}

		return noFinal.custo < 3;
	}


	return		{		
		verificar: function(_matriz, inicio, fim, tamanho, trocarCaminho)
		{
			matriz = _matriz;
			NUM_DE_LINHAS = tamanho[0]+2;
			NUM_DE_COLUNAS = tamanho[1]+2;

			posInicial = inicio;
			posFinal = fim;

			var achou = modDjkistra(trocarCaminho);
			return achou;
		},

		obterCaminho: function()
		{
			return caminho;
		}
	};

});