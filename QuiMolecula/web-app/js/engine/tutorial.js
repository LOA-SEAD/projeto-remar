
// All interface message constants.
var NEXT_BUTTON_MSG = "Próximo";
var SKIP_BUTTON_MSG = "Pular";
var YES_BUTTON_MSG = "Sim";
var NO_BUTTON_MSG = "Não";

var currentTutorialStep,
	animationIsRunning,
	textDiv,
	leftButton,
	rightButton;

function iniciarTutorial() {
	//Crio a div popup e os dois botoes.
	$('<div>')
	.attr({ 'id': 'tutorial', 'class': 'camada' })
	.appendTo($('#palco'));

	$('<div>')
	.attr({ 'id': 'tutorial', 'class': 'popup' })
	.appendTo($('#tutorial.camada'));

	textDiv = $('<p>')
	.attr('class', 'textoTutorial')
	.html('Deseja ver o tutorial?')
	.appendTo($('#tutorial.popup'));

	rightButton = $('<div>')
	.attr({ 'id': 'continuar', 'class': 'botao' })
	.html('<p class="textoBotaoTutorial">' + NO_BUTTON_MSG + '</p>')
	.click(function(){
		$(this).parent().fadeOut('slow', function(){
			terminarTutorial();
		})
	})
	.appendTo($('#tutorial.popup'));

	leftButton = $('<div>')
	.attr({ 'id': 'reiniciar', 'class': 'botao' })
	.html('<p class="textoBotaoTutorial">' + YES_BUTTON_MSG + '</p>')
	.click(function(){
		habilitarBotao();
		currentTutorialStep = -1;
		continuarTutorial();
	})
	.appendTo($('#tutorial.popup'));
}

function continuarTutorial() {
	$('#reiniciar.botao')
	.html('<p class="textoBotaoTutorial">' + NEXT_BUTTON_MSG + '</p>')
	.unbind('click')
	.click(function() {
		if(!animationIsRunning)
			proximoTutorial();
	});

	$('#continuar.botao')
	.html('<p class="textoBotaoTutorial">' + SKIP_BUTTON_MSG + '</p>')
	.unbind('click')
	.click(function() {
		if(!animationIsRunning)
			terminarTutorial();
	});

	proximoTutorial();
}

function terminarTutorial(){
	$('#tutorial.camada').remove();
	resetEditor();
}

function fazerAnimacaoAtomo(nome) {
	$('#'+nome+'.atomoDisponivel').addClass('moverAtomo').addClass('manterAnimacaoAtomo');
	setTimeout(function(){
		criarAtomo(nome);
		$('#'+nome).removeClass('moverAtomo').removeClass('manterAnimacaoAtomo');
	}, 1950);
}

function fazerAnimacaoSegundoAtomo(nome) {
	$('#'+nome+'.atomoDisponivel').addClass('moverAtomo').addClass('manterAnimacaoAtomo2');
	setTimeout(function(){
		criarAtomo(nome);
		$('#'+nome).removeClass('moverAtomo').removeClass('manterAnimacaoAtomo2');
	}, 1950);
}

function fazerAnimacaoLigacao(nome) {
	$('#ligacaosimples.ligacaoDisponivel').addClass('animacaoLigacao');
	setTimeout(function(){
		selectedAtom = $('#'+nome)[0];
		ligacaoAtual = 'ligacaosimples';
		$('#'+nome).addClass('atomoSelecionado');
		$('#ligacaosimples.ligacaoDisponivel').removeClass('animacaoLigacao');
	}, 1950);
}

function desabilitarBotao() {
	animationIsRunning = true;
	leftButton.addClass('desabilitado');
	rightButton.addClass('desabilitado');
}

function habilitarBotao() {
	animationIsRunning = false;
	leftButton.removeClass('desabilitado');
	rightButton.removeClass('desabilitado');
}

function proximoTutorial() {
	if(currentTutorialStep < 16)
		currentTutorialStep += 1;
	else
		terminarTutorial();

	desabilitarBotao();

	atualizarTexto();
	window['tutorial'+currentTutorialStep]();
}

function atualizarTexto() {
	textDiv.html(textoTutorial[currentTutorialStep]);
}

function tutorial0 () {
	habilitarBotao();
}

function tutorial1 () {
	setTimeout(function() {
		fazerAnimacaoAtomo('hidrogenio');

		setTimeout(function() {
			habilitarBotao();
		}, 2000);
	}, 2000);
}

function tutorial2 () {
	setTimeout(function () {
		$('#hidrogenio-0')
		.addClass('moverAtomo')
		.addClass('manterPrimeiroAtomo');

		setTimeout(function() {
			habilitarBotao();
		}, 2000);
	}, 2000);
}

function tutorial3 () {
	$('#hidrogenio-0')
	.removeClass('moverAtomo')

	setTimeout(function () {
		fazerAnimacaoAtomo('hidrogenio');

		setTimeout(function () {
			habilitarBotao();
		}, 2000)
	}, 2000);
}

function tutorial4 () {
	setTimeout(function() {
		fazerAnimacaoLigacao('hidrogenio-1');

		setTimeout(function () {
			habilitarBotao();
		}, 2000)
	}, 2000);
}

function tutorial5 () {
	//Coloca um circulo vermelho ao redor do atomo selecionado
	$('#hidrogenio-1')
	.css({ 'border-radius': '25px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	habilitarBotao();
}

function tutorial6 () {
	//Remove selecao do atomo selecionado
	$('#hidrogenio-1')
	.css({ 'border-radius': '0px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	//Efetivamente realiza a ligacao
	setTimeout(function() {
		selecionaSegundoAtomo($('#hidrogenio-0')[0]);
		habilitarBotao();
	}, 2000)
}

function tutorial7 () {
	habilitarBotao();
}

function tutorial8 () {
	setTimeout(function() {
		fazerAnimacaoSegundoAtomo('carbono');
	}, 2000)

	setTimeout(function() {
		$('#carbono-0')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 4000);


	setTimeout(function() {
		$('#carbono-0').remove();
		habilitarBotao();
	}, 6000);
}

function tutorial9 () {
	setTimeout(function() {
		$('#ligacaosimples-1').parent().children('.ligacaoEmEdicao')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 2000);

	setTimeout(function() {
		$('#ligacaosimples-1').parent().children('.ligacaoEmEdicao').remove();
	}, 4000);

	setTimeout(function() {
		$('#hidrogenio-1')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 6000);


	setTimeout(function() {
		$('#hidrogenio-1').remove();
	}, 8000);

	setTimeout(function() {
		$('#hidrogenio-0')
		.addClass('moverAtomo')
		.addClass('manterLixeiraAtomo');
	}, 10000);


	setTimeout(function() {
		$('#hidrogenio-0').remove();
		resetEditor();
		habilitarBotao();
	}, 12000);
}

function tutorial10 () {
	habilitarBotao();
}

function tutorial11 () {
	setTimeout(function() {
		$('#iodo.atomoDisponivel').addClass('moverAtomo').addClass('manterAnimacaoAtomo');
	}, 2000);

	setTimeout(function() {
		criarAtomo('iodo');
		habilitarBotao();
	}, 4000);
}

function tutorial12 () {
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

		habilitarBotao();
	}, 6000);
}

function tutorial13 () {
	$('#btnVerifica')
	.css({ 'border-radius': '15px', 'height': '54px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	habilitarBotao();
}

function tutorial14 () {
	$('#btnVerifica')
	.css({ 'border-radius': '0px', 'height': '60px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	$('#btnMenu')
	.css({ 'border-radius': '15px', 'height': '54px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	habilitarBotao();
}

function tutorial15 () {
	$('#btnMenu')
	.css({ 'border-radius': '0px', 'height': '60px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	$('#btnLixeira')
	.css({ 'border-radius': '15px', 'height': '54px', 'border': 'solid 3px red', 'margin-top': '-3px', 'margin-left': '-3px' });

	habilitarBotao();
}

function tutorial16 () {
	$('#btnLixeira')
	.css({ 'border-radius': '0px', 'height': '60px', 'border': 'solid 0px red', 'margin-top': '0px', 'margin-left': '0px' });

	habilitarBotao();
}

var textoTutorial = [
	'Bem vindo ao editor do QuiMol&eacute;cula. O objetivo montar mol\&eacute;culas org\&acirc;nicas.',
	'Para pegar os \&aacute;tomos, clique e segure com o botão esquerdo do mouse no \&aacute;tomos que desejar e arraste at\&eacute; o tabuleiro. Solte para que ele encaixe na área apropriada.',
	'Caso queira mov\&ecirc;-los, voc&ecirc; tamb\&eacute; pode clicar e arrastar para outra posi\&ccedil;\&atilde;o.',
	'Para formar liga\&ccedil;\&otilde;es, precisamos de pelos menos dois \&aacute;tomos',
	'Agora arraste a ligação para cima de um dos \&aacute;tomos que deseja ligar.',
	'Este, ao ser ativado, ficar\&aacute; maior de modo a se destacar.',
	'Basta clicar no outro \&aacute;tomos vizinho entre os quais queira firmar uma ligação.',
	'Lembre-se que há um limite de ligações para cada \&aacute;tomo, respeitando suas respectivas Camadas de Valência.',
	'Para excluir um \&aacute;tomos ou uma ligao, basta arrast\&aacute;-lo para a Lixeira.',
	'Se o \&aacute;tomos tiver uma ligao, necessio excluir a ligao primeiro e sdepois excluir o \&aacute;tomos.',
	'O jogo conta com um mecanismo de repetição. Toda vez que precisar colocar mais de um \&aacute;tomos ou ligação no campo, pressione o botão esquerdo do mouse para pegar o \&aacute;tomo/ligação que deseja mover.',
	'Posicione o \&aacute;tomos no local desejado, e, mantendo o bot esquerdo do mouse pressionado, tecle D. Um \&aacute;tomo aparecerá no local escolhido.',
 	'Com o botão esquerdo ainda pressionado, e clicando D em diferentes pontos do tabuleiro, você fará cópias do \&aacute;tomo selecionado em cada lugar sobre o qual você teclou D.',
	'Clique aqui para inserir informações adicionais e salvar a molécula no banco.',
	'Clique aqui para voltar à tela inicial.',
	'Clique aqui para limpar a tela excluindo todos os elementos do tabuleiro.'
];
