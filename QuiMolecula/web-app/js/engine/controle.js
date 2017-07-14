


function criarPalco() {
	var pai = $('#ancora').parent();
	$('<div>').attr("id", "palco").appendTo(pai);

	criarMenu();
}

function criarMenu() {
	$('<div>').attr({'id': 'camadaMenu', 'class': 'camada'}).appendTo($('#palco'));

	$('<div>').attr({'id': 'textoMenu', 'class': 'texto'}).appendTo($('#camadaMenu'));

	$('<div>').attr({'id': 'btnJogar', 'class': 'botaoMenu'})
			.click(function(){
						destruirMenu();
						criarJogo();})
			.appendTo($('#camadaMenu'));

	$('<div>').attr({'id': 'btnNiveis', 'class': 'botaoMenu'})
			.click(function(){
						destruirMenu();
						criarNiveis();})
			.appendTo($('#camadaMenu'));

	$('<div>').attr({'id': 'btnRanking', 'class': 'botaoMenu'})
			.click(function(){
						destruirMenu();
						criarRanking();})
			.appendTo($('#camadaMenu'));

	$('<div>').attr({'id': 'btnCreditos', 'class': 'botaoMenu'})
			.click(function() {
						destruirMenu();
						criarCreditos();})
			.appendTo($('#camadaMenu'));
}

function destruirMenu() {
	$("#camadaMenu").remove();
}

function criarJogo() {
	$('<div>').attr({'id': 'camadaJogo', 'class': 'camada'}).appendTo($('#palco'));
	lerXML(nivel);
}

function destruirJogo() {

	backgroundI = 0;
	elementosNoJogo = [];
	atomoSelecionado = null;
	ligacaoAtual = null;
	ligacoesNoJogo = [];
	estaNumerado = false;
	posicaoInicial = 0;
	document.onmousemove = null;
	document.onkeypress = null;
	$('#camadaJogo').remove();
}

function criarCreditos() {
	$('<div>').attr({'id': 'camadaCreditos', 'class': 'camada'})
			.click(function(){
					destruirCreditos();
					criarMenu();
			})
			.appendTo($('#palco'));
}

function destruirCreditos() {
	$('#camadaCreditos').remove();
}

function criarRanking() {

	$('<div>').attr({'id': 'camadaRanking', 'class': 'camada'})
			.click(function(){
					destruirRanking();
					criarMenu();
			})
			.appendTo($('#palco'));
}

function destruirRanking() {
	$('#camadaRanking').remove();
}

function criarNiveis() {

	$('<div>').attr({'id': 'camadaNiveis', 'class': 'camada'})
			.appendTo($('#palco'));

	$('<div>').attr('id', 'btnNiveisMenu')
			.click(function(){
				destruirNiveis();
				criarMenu();
			})
			.appendTo($('#camadaNiveis.camada'));

	var pagina = 0;

	redesenharNiveis(pagina);
}

function redesenharNiveis(_pagina) {

	$('#botoesNivel').remove();

	$('<div>').attr('id', 'botoesNivel').css('overflow', 'visible').appendTo($('#camadaNiveis'));
	if(_pagina <= parseInt(maxNivel/16) - 1)
	{
		$('<div>').attr('id', 'proximo')
				.click(function() {
					if(_pagina <= parseInt(maxNivel/16) - 1)
					{
						_pagina++;
						redesenharNiveis(_pagina);
					}
				})
				.appendTo($('#botoesNivel'));
	}

	if(_pagina >= 1)
	{
		$('<div>').attr('id', 'anterior')
				.click(function() {
					if(_pagina >= 1)
					{
						_pagina--;
						redesenharNiveis(_pagina);
					}
				})
				.appendTo($('#botoesNivel'));
	}

	for(var i = 16*_pagina; i < 16*(_pagina+1); i++)
	{
		if(i <= maxNivel)
		{
			$('<div>').attr({'id': i,
							'class': 'btnNivel'})
						.css({'top': parseInt((i%16)/4)*70 + 250,
								'left': (i%4)*124 + 157})
						.click(function(){
							destruirNiveis();
							nivel = $(this).attr('id');
							criarJogo();
						})
						.appendTo($('#botoesNivel'));

			var b = $('<p>').attr('class', 'textoBtnNivel').html(function(){

				if(fases[i].length > 17)
						$(this).css({ 'padding-top': '10px' });
					else
						$(this).css({ 'padding-top': '20px' });

					return fases[i];
			})
			.appendTo($('#' + i));
		}
	}
}

function destruirNiveis() {
	$('#camadaNiveis').remove();
}

$(document).ready(function() {
	criarPalco();
});