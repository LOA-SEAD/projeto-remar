
var tutorialAtual,
animando,
divTexto,
botao1,
botao2;

function iniciarTutorial() {
	//Crio a div popup e os dois botoes.
	$('<div>')
	.attr({ 'id': 'tutorial', 'class': 'camada' })
	.appendTo($('#palco'));

	$('<div>')
	.attr({ 'id': 'tutorial', 'class': 'popup' })
	.appendTo($('#tutorial.camada'));

	divTexto = $('<p>')
	.attr('class', 'textoTutorial')
	.html('Deseja ver o tutorial?')
	.appendTo($('#tutorial.popup'));

	botao2 = $('<div>')
	.attr({ 'id': 'continuar', 'class': 'botao' })
	.html('<p class="textoBotaoTutorial">Não</precisamos>')
	.click(function(){
		$(this).parent().fadeOut('slow', function(){
			terminarTutorial();
		})
	})
	.appendTo($('#tutorial.popup'));

	botao1 = $('<div>')
	.attr({ 'id': 'reiniciar', 'class': 'botao' })
	.html('<p class="textoBotaoTutorial">Sim</p>')
	.click(function(){
		abilitarBotao();
		tutorialAtual = -1;
		continuarTutorial();
	})
	.appendTo($('#tutorial.popup'));	
}

function continuarTutorial() {
	$('#reiniciar.botao')
	.html('<p class="textoBotaoTutorial">Próximo</p>')
	.unbind('click')
	.click(function() {
		if(!animando)
			proximoTutorial();
	});

	$('#continuar.botao')
	.html('<p class="textoBotaoTutorial">Pular</p>')
	.unbind('click')
	.click(function() {
		if(!animando)
			terminarTutorial();
	});

	proximoTutorial();
}

function terminarTutorial(){
	$('#tutorial.camada').remove();
	reiniciarJogo();
	moleculaCerta();
}

function fazerAnimacaoAtomo(nome) {
	$('#'+nome+'.atomoDisponivel').addClass('moverAtomo').addClass('manterAnimacaoAtomo');
	setTimeout(function(){
		criarAtomo(nome);	
		$('#'+nome).removeClass('moverAtomo').removeClass('manterAnimacaoAtomo');
	}, 1950);
}

function fazerAnimacaoLigacao(nome) {
	$('#ligacaosimples.ligacaoDisponivel').addClass('animacaoLigacao');
	setTimeout(function(){
		atomoSelecionado = $('#'+nome)[0];
		ligacaoAtual = 'ligacaosimples';
		$('#'+nome).addClass('atomoSelecionado');
		$('#ligacaosimples.ligacaoDisponivel').removeClass('animacaoLigacao');
	}, 1950);
}

function desabilitarBotao() {
	animando = true;
	botao1.addClass('desabilitado');
	botao2.addClass('desabilitado');
}

function abilitarBotao() {
	animando = false;
	botao1.removeClass('desabilitado');
	botao2.removeClass('desabilitado');
}

function proximoTutorial() {
	if(tutorialAtual < 21)
		tutorialAtual += 1;
	else
		terminarTutorial();
	
	desabilitarBotao();
	
	atualizarTexto();
	window['tutorial'+tutorialAtual]();
}

function atualizarTexto() {
	divTexto.html(textoTutorial[tutorialAtual]);
}

function tutorial0 () {
	abilitarBotao();
}

function tutorial1 () {
	//Fazer 1	
	$('#nomeDaMolecula')
	.css({ 'border-radius': '15px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	abilitarBotao();
}

function tutorial2 () {
	//Desfaz 1
	$('#nomeDaMolecula')
	.css({ 'border-radius': '0px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	$('#formulaDaMolecula')
	.css({ 'border-radius': '15px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	//Desce aba da 
	setTimeout(function() {		
		$('#formulaDaMolecula').css('top', '84px');
		setTimeout(function() {
			abilitarBotao();
		}, 1000);
	}, 2000);
}

function tutorial3 () {
	//Desfazer 2
	$('#formulaDaMolecula')
	.css({ 'border-radius': '0px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	//Fazer 3
	setTimeout(function() {
		fazerAnimacaoAtomo('hidrogenio');

		setTimeout(function() {
			abilitarBotao();
		}, 2000);
	}, 2000);
}

function tutorial4 () {
	setTimeout(function () {
		$('#hidrogenio-0')
		.addClass('moverAtomo')
		.addClass('manterPrimeiroAtomo');

		setTimeout(function() {
			abilitarBotao();
		}, 2000);	
	}, 2000);
}

function tutorial5 () {	
	$('#hidrogenio-0')
	.removeClass('moverAtomo')

	setTimeout(function () {
		fazerAnimacaoAtomo('hidrogenio');
	
		setTimeout(function () {
			abilitarBotao();
		}, 2000)
	}, 2000);
}

function tutorial6 () {
	setTimeout(function() {
		fazerAnimacaoLigacao('hidrogenio-1');

		setTimeout(function () {
			abilitarBotao();
		}, 2000)
	}, 2000);
}

function tutorial7 () {
	//Coloca um circulo vermelho ao redor do atomo selecionado
	$('#hidrogenio-1')
	.css({ 'border-radius': '25px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	abilitarBotao();
}

function tutorial8 () {
	//Remove selecao do atomo selecionado
	$('#hidrogenio-1')
	.css({ 'border-radius': '0px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	//Efetivamente realiza a ligacao
	setTimeout(function() {
		selecionaSegundoAtomo($('#hidrogenio-0')[0]);
		abilitarBotao();
	}, 2000)
}

function tutorial9 () {
	abilitarBotao();
}

function tutorial10 () {
	//Remove os hidrogenios
	reiniciarJogo();

	setTimeout(function() {
		fazerAnimacaoAtomo('carbono');
	}, 2000)

	setTimeout(function() {
		$('#carbono-0')
		.addClass('moverAtomo')
		.addClass('manterSegundoAtomo');
	}, 4000);

	setTimeout(function () {
		fazerAnimacaoAtomo('carbono');
	}, 6000);

	setTimeout(function() {
		$('#carbono-1')
		.addClass('moverAtomo')
		.addClass('manterPrimeiroAtomo');
	}, 8000);

	setTimeout(function () {
		fazerAnimacaoAtomo('carbono');
	}, 10000);

	setTimeout(function() {
		fazerAnimacaoLigacao('carbono-2');
	}, 12000);

	setTimeout(function() {
		selecionaSegundoAtomo($('#carbono-1')[0]);
		abilitarBotao();
	}, 15000);
}

function tutorial11 () {
	//Seleciona o botao de numerar carbonos
	$('#btnNumCarbonos')
	.css({ 'border-radius': '15px', 'height': '49px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	setTimeout(function() {
		numerarCarbonos();
		abilitarBotao();
	}, 2000);
}

function tutorial12 () {
	$('#btnNumCarbonos')
	.css({ 'border-radius': '0px', 'height': '56px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	setTimeout(function() {
		$('#tb1')
		.css({ 'border': 'solid 3px red', 'margin-top': '-1px', 'margin-left': '-1px' });

		$('#tb1').val(2);
	}, 2000);

	setTimeout(function() {
		$('#tb1')
		.css({ 'border-radius': '10px', 'border': 'solid 2px black', 'margin-top': '0px', 'margin-left': '0px' })

		$('#carbono-2')
		.css({ 'border-radius': '25px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });
	}, 4000);

	setTimeout(function() {
		mudarNumeroCarbono($('#carbono-2')[0])

		$('#carbono-2')
		.css({ 'border-radius': '0px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });
	}, 6000);

	setTimeout(function() {
		$('#tb1').val(3);

		$('#carbono-1')
		.css({ 'border-radius': '25px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });
	}, 8000);

	setTimeout(function() {
		mudarNumeroCarbono($('#carbono-1')[0])
		
		$('#carbono-1')
		.css({ 'border-radius': '0px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

		abilitarBotao();
	}, 10000);	
}

function tutorial13 () {
	setTimeout(function() {
		$('#carbono-0')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 2000);
	

	setTimeout(function() {
		$('#carbono-0').remove();
		abilitarBotao();
	}, 4000);
}

function tutorial14 () {
	setTimeout(function() {
		$('#ligacaosimples-1').parent().children('.ligacaoEmEdicao')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 2000);

	setTimeout(function() {
		$('#ligacaosimples-1').parent().children('.ligacaoEmEdicao').remove();
	}, 4000);	

	setTimeout(function() {
		$('#carbono-1')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 6000);
	

	setTimeout(function() {
		$('#carbono-1').remove();
	}, 8000);

	setTimeout(function() {
		$('#carbono-2')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 10000);
	

	setTimeout(function() {
		$('#carbono-2').remove();
		reiniciarJogo();
		abilitarBotao();
	}, 12000);
}

function tutorial15 () {
	abilitarBotao();
}

function tutorial16 () {
	setTimeout(function() {
		$('#iodo.atomoDisponivel').addClass('moverAtomo').addClass('manterAnimacaoAtomo');
	}, 2000);

	setTimeout(function() {
		criarAtomo('iodo');
		abilitarBotao();
	}, 4000);
}

function tutorial17 () {
	setTimeout(function() {
		$('#iodo.atomoDisponivel')
		.removeClass('manterAnimacaoAtomo')
		.addClass('moverAtomo')
		.addClass('manterAnimacaoAtomo2');
	}, 2000);

	setTimeout(function() {
		criarAtomo('iodo');

		$('#iodo.atomoDisponivel')
		.removeClass('manterAnimacaoAtomo2')
		.addClass('moverAtomo')
		.addClass('manterAnimacaoAtomo3');
	}, 4000);

	setTimeout(function() {
		criarAtomo('iodo');

		$('#iodo.atomoDisponivel')
		.removeClass('moverAtomo')
		.removeClass('manterAnimacaoAtomo3');

		abilitarBotao();
	}, 6000);	
}

function tutorial18 () {
	$('#btnVerifica')
	.css({ 'border-radius': '15px', 'height': '54px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	abilitarBotao();
}

function tutorial19 () {
	$('#btnVerifica')
	.css({ 'border-radius': '0px', 'height': '60px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	$('#btnMenu')
	.css({ 'border-radius': '15px', 'height': '54px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	abilitarBotao();
}

function tutorial20 () {
	$('#btnMenu')
	.css({ 'border-radius': '0px', 'height': '60px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	$('#btnLixeira')
	.css({ 'border-radius': '15px', 'height': '54px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	abilitarBotao();
}

function tutorial21 () {
	$('#btnLixeira')
	.css({ 'border-radius': '0px', 'height': '60px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	abilitarBotao();
}

var textoTutorial = [
	'Bem vindo ao QuiMolécula. O objetivo é montar moléculas orgânicas.',
	'Você deve formar uma molécula que tenha esse nome.',
	'Caso necessite de ajuda, clique na aba preta para ver a fórmula química da molécula.',
	'Para pegar os átomos, clique e segure com o botão esquerdo do mouse no átomo que desejar e arraste até o tabuleiro. Solte para que ele encaixe na área apropriada.',
	'Caso queira movê-los, você também pode clicar e arrastar para outra posição.',
	'Para formar ligações, precisamos de pelos menos dois átomos',
	'Agora arraste a ligação para cima de um dos átomos que deseja ligar.',
	'Este, ao ser ativado, ficará maior de modo a se destacar.',
	'Basta clicar no outro átomo vizinho entre os quais queira firmar uma ligação.',
	'Lembre-se que há um limite de ligações para cada átomo, respeitando suas respectivas Camadas de Valência.',
	'Em algumas moléculas, precisamos enumerar os carbonos. Vamos colocar alguns carbonos para ver como enumerá-los.',
	'Para enumerar carbonos, use esse painel.',
	'Digite o valor que deseja na caixa de texto e clique sobre algum carbono para atribuir esse valor a ele.',
	'Para excluir um átomo ou uma ligação, basta arrastá-lo para a Lixeira.',
	'Se o átomo tiver uma ligação, é necessário excluir a ligação primeiro e só depois excluir o átomo.',
	'O jogo conta com um mecanismo de repetição. Toda vez que precisar colocar mais de um átomo ou ligação no campo, pressione o botão esquerdo do mouse para pegar o átomo/ligação que deseja mover.',
	'Posicione o átomo no local desejado, e, mantendo o botão esquerdo do mouse pressionado, tecle D. Um átomo aparecerá no local escolhido.',
 	'Com o botão esquerdo ainda pressionado, e clicando D em diferentes pontos do tabuleiro, você fará cópias do átomo selecionado em cada lugar sobre o qual você teclou D.',
	'Clique aqui para verificar se a molécula que você montou está correta.',
	'Clique aqui para voltar ao menu inicial.',
	'Clique aqui para limpar a tela excluindo todos os elementos do tabuleiro.',	
	'Boa sorte!'	
];