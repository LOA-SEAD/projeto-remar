/*
	O html do jogo é simplesmente um body com uma div chamada "palco"
	Quando a pagina carrega, ela carrega as tags <script> que contém os arquivos de javascript que geram o jogo
	Quando os scripts são carregados é criado uma div "menu" e seu conteudo
	Através das interações com os botões o html é gerado e destruido dinamicamente pelo javscript
	
	O css está sendo usado de maneira mista tanto inline (dentro do html) como por arquivos externos (css)
*/


function criarCamadaMenu()
{	
	var el = document.createElement("div");
	el.setAttribute("id", "camadaMenu");
	$("#palco").append(el);
	
	var caixaBotoes = document.createElement("div");
	caixaBotoes.setAttribute("id", "caixaBotoes");
	el.appendChild(caixaBotoes);
	
	
	var botaoJogar = document.createElement("div");
	botaoJogar.setAttribute("id" , "btnJogar");
	botaoJogar.setAttribute("tabIndex" , "1");
	botaoJogar.setAttribute("role" , "button");
	botaoJogar.setAttribute("aria-label" , "Jogar");
	botaoJogar.setAttribute("class" , "botao");
	caixaBotoes.appendChild(botaoJogar);
	
	botaoJogar.onfocus = function() {		
		adicionarComandosEnterSpace(ativarBotaoJogar, botaoJogar);
	}
	botaoJogar.onblur = function() {		
		removerComandosEnterSpace();
	}	
	botaoJogar.onclick = function()
	{
		ativarBotaoJogar();
	}
	
	var botaoRank = document.createElement("div");
	botaoRank.setAttribute("id" , "btnRanking");
	botaoRank.setAttribute("tabIndex" , "0");
	botaoRank.setAttribute("role" , "button");
	botaoRank.setAttribute("aria-label" , "Ranking");
	botaoRank.setAttribute("class" , "botao");
	caixaBotoes.appendChild(botaoRank);	
	
	botaoRank.onfocus = function() {		
		adicionarComandosEnterSpace(ativarBotaoRanking, botaoRank);
	}
	botaoRank.onblur = function() {		
		removerComandosEnterSpace();
	}	
	botaoRank.onclick = function()
	{
		ativarBotaoRanking();
	}
}

function ativarBotaoJogar()
{
	destruirCamadaMenu();
	criarCamadaJogo();
}
function ativarBotaoRanking()
{
	destruirCamadaMenu();
	obtemRanking(jogo.nome);
}

function destruirCamadaMenu()
{
	
	$("#camadaMenu").remove();
}

function criarCamadaJogo()
{
	var el = document.createElement("div");
	el.setAttribute("id", "camadaJogo");
	$("#palco").append(el);
    
	iniciar();
}

function destruirCamadaJogo()
{
	$("#camadaJogo").remove();
}

function criarCamadaCreditos()
{
	var el = document.createElement("div");
	el.setAttribute("id", "camadaCreditos");
	$("#palco").append(el);	


	var para = $('<br>').appendTo(el);		
	var para = $('<br>').appendTo(el);	
	var para = $('<br>').appendTo(el);	
	var para = $('<br>').appendTo(el);	
	var para = $('<br>').appendTo(el);	
	
	var para = document.createElement("p");
	para.innerHTML = "Equipe";
	el.appendChild(para);	
	
	var para = document.createElement("br");
	el.appendChild(para);
	var para = document.createElement("br");
	el.appendChild(para);
	
	var colLeft = document.createElement("div");
	colLeft.setAttribute("style", "width: 250px; float: left;  text-align: center;");
	el.appendChild(colLeft);
	
	var para = document.createElement("p");
	para.innerHTML = "Marcelo";
	colLeft.appendChild(para);
	
	var para = document.createElement("p");
	para.innerHTML = "Murilo";
	colLeft.appendChild(para);
	
	var para = document.createElement("p");
	para.innerHTML = "Valério";
	colLeft.appendChild(para);
	
	var para = document.createElement("p");
	para.innerHTML = "Henrique";
	colLeft.appendChild(para);
	
	var colRight = document.createElement("div");
	colRight.setAttribute("style", "width: 250px; float: right; text-align: center;");
	el.appendChild(colRight);
	
	var para = document.createElement("p");
	para.innerHTML = "Katia";
	colRight.appendChild(para);
	var para = document.createElement("p");
	para.innerHTML = "Rafaela";
	colRight.appendChild(para);
	var para = document.createElement("p");
	para.innerHTML = "Diana";
	colRight.appendChild(para);
	var para = document.createElement("p");
	para.innerHTML = "Catarine";
	colRight.appendChild(para);
	
	el.onmousedown = function()
	{
		destruirCamadaCreditos();
		criarCamadaMenu();
	}
}

function destruirCamadaCreditos()
{
	$("#camadaCreditos").remove();
}

function criarCamadaVitoria()
{
	var el = $('<div>').attr("id", "camadaVitoria").appendTo($("#palco"));	
	if((jogo.bdTamanho) == 0) {
          $('<p>').attr('id', 'pontosNaTela')
              .html('Pontos: ' + parseInt(jogo.pontos))
              .appendTo($('#camadaVitoria'));
	}
	$('<div>').css({
					'position': 'absolute',
					'width': '800px',
					'height': '600px',
					'background-image': 'url("imgs/vitoria.png")'})
			.click(function(){
        if(jogo.bdTamanho != 0) {
            destruirCamadaVitoria();
            criarCamadaJogo();
        }
        else
        {
            destruirCamadaVitoria();            
            criarCamadaMenu();
            iniciarNovoJogo();
        }
            
             
			})
			.appendTo(el);
	
}

function destruirCamadaVitoria()
{
	$("#camadaVitoria").remove();
}

function criarCamadaDerrota()
{
	var pontos = jogo.pontos;
	iniciarNovoJogo();
	
	$('<div>').attr('id', 'camadaDerrota')
				.css({
					'width': '800px',
					'height': '600px',
					'position': 'absolute',
					'top': '0px',})
				.click(function(){
					destruirCamadaDerrota();
					destruirCamadaJogo();
					salvaPontuacao(jogo.nome, pontos);
					criarCamadaMenu();
				})
				.appendTo($('#palco'));
}

function destruirCamadaDerrota()
{
	$("#camadaDerrota").remove();
}

function criarCamadaRanking()
{
    $('<div>').attr('id', 'camadaRanking')
    .css({
        'width': '800px',
        'height': '600px',
        'position': 'absolute',
        'top': '0px'
    })
    .click(function(){
        destruirCamadaRanking();
        criarCamadaMenu();
    })
    .appendTo($('#palco'));

    var colRank = $('<div>').css({
        'width': '250px',
        'position': 'absolute',
        'text-align': 'center',
        'top': '36%',
        'left': '1%'
    })
    .appendTo($('#camadaRanking'));

    $('<p>').html('Ranking').appendTo(colRank);

    for (i = 0; i < ranking.length; i++) {
        $('<p>').html((i+1) + '.').appendTo(colRank);
    }
    
    var colNome = $('<div>').css({
        'width': '340px',
        'position': 'absolute',
        'text-align': 'center',
        'top': '36%',
        'left': '15%'
    })
    .appendTo($('#camadaRanking'));

    $('<p>').html('Nome').appendTo(colNome);

    for (i = 0; i < ranking.length; i++) {
        $('<p>').html(ranking[i]["jogador"]).appendTo(colNome);
    }
    
    var colPontuacao = $('<div>').css({
        'width': '100px',
        'position': 'absolute',
        'text-align': 'center',
        'top': '36%',
        'left': '400px'
    })
    .appendTo($('#camadaRanking'));

    $('<p>').html('Pontuação').appendTo(colPontuacao);

    for (i = 0; i < ranking.length; i++) {
        $('<p>').html(ranking[i]["pontos"]).appendTo(colPontuacao);
    }

    var colData = $('<div>').css({
        'width': '210px',
        'position': 'absolute',
        'text-align': 'center',
        'top': '36%',
        'left': '530px'
    })
    .appendTo($('#camadaRanking'));

    $('<p>').html('Data').appendTo(colData);

    for (i = 0; i < ranking.length; i++) {
        $('<p>').html(formataData(ranking[i]["data"])).appendTo(colData);
    }
}

function formataData(strData)
{
    var data = new Date(strData);
    var v = data.getDate();
    var s = (v < 10 ? '0' + v : v) + "/";
    v = data.getMonth() + 1;
    s += (v < 10 ? '0' + v: v) + "/";
    s += data.getFullYear() + " ";
    v = data.getHours();
    s += (v < 10 ? '0' + v: v) + ":";
    v = data.getMinutes();
    s += (v < 10 ? '0' + v: v) + ":";
    v = data.getSeconds();
    s += (v < 10 ? '0' + v: v);
    return s;
}

function destruirCamadaRanking()
{
    $("#camadaRanking").remove();
}

jogo.palco = new Palco();
jogo.palco.criar();
iniciarNovoJogo();
criarCamadaMenu();
