function Ligacao(_numero, _valor, _div, _image) {
	this.elementos = new Array();
	this.valor = _valor;
	this.div = _div;
	this.image = _image;
	this.numero = _numero;

	this.ligar = function(_elemento1, _elemento2)
	{
		if(_elemento1 === _elemento2)
		{
			return false;
		}

		this.elementos[0] = _elemento1;
		this.elementos[1] = _elemento2;

		if(this.elementos[0].podeLigar(this, this.elementos[1]) && this.elementos[1].podeLigar(this, this.elementos[1]))
		{
			this.elementos[0].realizarLigacao(this);
			this.elementos[1].realizarLigacao(this);
			return true;
		}
		else
		{
			return false;
		}
	}

	this.desligar = function()
	{
		this.elementos[0].desfazerLigacao(this);
		this.elementos[1].desfazerLigacao(this);
		$(this.image).remove();
		$(this.div).remove();
	}
}

function Atomo(_nome, _maximoDeLigacoes, _codigo, _div, _numero) {
	this.nome = _nome;
	this.maximoDeLigacoes = _maximoDeLigacoes;
	this.codigo = _codigo;
	this.numero = _numero;
	this.div = _div;
	this.numeroDeLigacoesFeitas = 0;
	this.ligacoesFeitas = new Array();

	this.podeLigar = function(_ligacao, _atomo) {

		var auxLigacao;
		if(this.maximoDeLigacoes >= this.numeroDeLigacoesFeitas + _ligacao.valor)
			auxLigacao = true;
		else
			return false;


		for(var i = 0;i< this.ligacoesFeitas.length;i++)
		{

			if((this.ligacoesFeitas[i].elementos[0].codigo == _atomo.codigo
			&& this.ligacoesFeitas[i].elementos[1].codigo == this.codigo
			&& this.ligacoesFeitas[i].elementos[0].nome == _atomo.nome
			&& this.ligacoesFeitas[i].elementos[1].nome == this.nome)
			|| (this.ligacoesFeitas[i].elementos[1].codigo == _atomo.codigo
			&& this.ligacoesFeitas[i].elementos[0].codigo == this.codigo
			&& this.ligacoesFeitas[i].elementos[1].nome == _atomo.nome
			&& this.ligacoesFeitas[i].elementos[0].nome == this.nome))
			{
				auxLigacao = false;
			}

		}
		return auxLigacao;

	}

	this.realizarLigacao = function(_ligacao) 	{
		//Metodo deve verificar se a ligacao é possivel(elementos podem se ligar, numero maximo ainda nao passou)
		this.ligacoesFeitas[this.ligacoesFeitas.length] = _ligacao;
		this.numeroDeLigacoesFeitas += _ligacao.valor;
	}

	//Problema com a remocao
	//Remove varios elementos se forem iguais
	this.desfazerLigacao = function(_ligacao) 	{
		for(var i = 0; i < this.maximoDeLigacoes; i++)
		{
			if(this.ligacoesFeitas[i] == _ligacao)
			{
				this.numeroDeLigacoesFeitas -= _ligacao.valor;
				this.ligacoesFeitas.splice(i,1);
			}
		}
	}
}

function Data(_tipo, _num, _ligas) {
	this.tipo = _tipo;
	this.num = _num;
	this.ligas = _ligas;

	this.add = function(_liga) {
        var len = this.ligas.length;
        this.ligas[len] = _liga;
    }

	this.compare = function(_data)
	{
		if(_data.tipo == this.tipo && $(this.ligas).compare(_data.ligas) )
			if(this.num == -1)
				return true;
			else if(_data.num == this.num)
				return true;
			else
				return false;
		else
		{
			return false;
		}
	}
}