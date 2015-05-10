define([], function () 
{
	var matriz,
	NUM_DE_LINHAS,
	NUM_DE_COLUNAS;
	
	function node(_x, _y)
	{
		this.x = _x;
		this.y = _y;
		
		this.cameFrom = null;
		this.G;	
		this.F;
		this.dir = 1;
		
	}
	function checkIfEmpty(pos, ini, fim)
	{
		if((pos[0] == ini.x && pos[1] == ini.y )|| (pos[0] == fim.x && pos[1] == fim.y))
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
	function estaNaLista(pos, lista)
	{
		var i;
		for(i=0;i<lista.length;i++)
			if(pos[0] == lista[i].x && pos[1] == lista[i].y)
				return true;
		
		return false;
	}
	function distancia(a,b)
	{
		return (Math.abs(a[0]-b[0])+Math.abs(a[1]-b[1])-1);
	}
	function heuristic(noa, nob)
	{
		return 10*(Math.abs(noa.x-nob.x)+Math.abs(noa.y-nob.y)-1);
	}
	function noMenor(lista)
	{
		var i;
		var menor = lista[0];
		for(i=1;i<lista.length;i++)
			menor =(menor.F < lista[i].F) ? menor : lista[i];
		
		return i-1;		
	}
	function checarVizinhos(noAtual, ini, fim)
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
		
		var cima = checkIfEmpty(posCima, ini, fim) && checkIfDir(noAtual, posCima);	
		var direita = checkIfEmpty(posDireita, ini, fim) && checkIfDir(noAtual, posDireita); 
		var baixo = checkIfEmpty(posBaixo, ini, fim) && checkIfDir(noAtual, posBaixo);
		var esquerda = checkIfEmpty(posEsquerda, ini, fim) && checkIfDir(noAtual, posEsquerda);
		
		
		
		return [cima ? posCima : false, direita ? posDireita : false, baixo ? posBaixo : false, esquerda ? posEsquerda : false];	
	}

	function checkIfDir(noAtual, nextPos)
	{	
		if(noAtual.cameFrom != null)	
		{
			if(noAtual.cameFrom.cameFrom != null)
			{
				disx = Math.abs(nextPos[0] - noAtual.cameFrom.x);
				disy = Math.abs(nextPos[1] - noAtual.cameFrom.y);
				if(disx==1 && disy == 1)
				{
					if(noAtual.dir+1 >3)
					{					
						return false;
						
					}
				}
			}
		}
		else
		{
			noAtual.dir = 1;
		}
		return true;
	}	
	function astar(inicio, fim)
	{
		var i;
		
		var nos = new Array(NUM_DE_LINHAS);
		for(i=0;i<NUM_DE_LINHAS;i++)
		{	
			nos[i] = new Array(NUM_DE_COLUNAS);
			for(j=0;j<NUM_DE_COLUNAS;j++)
				nos[i][j] = new node(i,j);
		}		
		
		var noInicial = nos[inicio[0]+1][inicio[1]+1];
		var noFinal = nos[fim[0]+1][fim[1]+1];
		var fechado = new Array();
		var aberto = [noInicial];
		var caminho = new Array();	
		
		noInicial.G = 0;
		noInicial.F = noInicial.G + heuristic(noInicial, noFinal);
		
		var it = 0;
		while(aberto.length > 0)
		{
			it++;		
			atual = noMenor(aberto);			
			noAtual = aberto[atual];		
			if(noAtual.x == noFinal.x && noAtual.y == noFinal.y)
			{
				return true;
			}
			
			fechado.push(aberto.splice(atual,1)[0]);
			
			vizinhos = checarVizinhos(noAtual, noInicial, noFinal);				
			for(i=0;i<4;i++)
			{
				if(vizinhos[i] != false)
				{
					if(estaNaLista(vizinhos[i], fechado))
						continue;
					tentative_g_score = noAtual.G + 10;
					leno = nos[vizinhos[i][0]][vizinhos[i][1]];
					if(!estaNaLista(vizinhos[i], aberto) || tentative_g_score < leno.G)
					{
						if(!estaNaLista(vizinhos[i], aberto))
							aberto.push(leno);
						leno.cameFrom = noAtual;
						
						
						if(leno.cameFrom!=null)
							if(leno.cameFrom.cameFrom!=null)
							{							
								disx = Math.abs(leno.x - leno.cameFrom.cameFrom.x);
								disy = Math.abs(leno.y - leno.cameFrom.cameFrom.y);							
								if(disx==1 && disy == 1)
								{
									leno.dir = leno.cameFrom.dir+1;								
								}
								else
								{
									leno.dir = leno.cameFrom.dir;
								}
							}
						
						leno.G = tentative_g_score;
						leno.F = leno.G + heuristic(leno, noFinal);
					}
				}
			}
		}
		return false;
	}

	return		{		
		verificar: function(_matriz, inicio, fim, tamanho)
		{
			matriz = _matriz;
			NUM_DE_LINHAS = tamanho[0]+2;
			NUM_DE_COLUNAS = tamanho[1]+2;
			var achou = astar(inicio, fim);
			console.log("Achou: ", achou);
			return achou;
		}		
	};

});