
var ranking;

var maquina = 'localhost';

var server = 'http://'+maquina+':8080/REMAR/pontuacao/';

function salvaPontuacao(nomeJogo, pontos) {

    var jogador = prompt("Qual seu nome?");

    console.log(server+'save/?jogo=' + nomeJogo + '&jogador=' + jogador+'&pontos='+pontos);

    $.ajax({
        url: server + 'save',
        type: 'POST',
        async: false,
        data: 'jogo=' + nomeJogo + '&jogador=' + jogador +'&pontos='+pontos,
        success: function(data) {            
            //if (data == "true") {
            //    destruirCamadaMenu();
            //    obtemRanking(nomeJogo)
            //}
        }
    });
}

function obtemRanking(nomeJogo){

    ranking = null;

console.log(server + 'show/?jogo=' + nomeJogo);

    var jqxhr = $.get(server + 'show/?jogo=' + nomeJogo)
    .error(function() {
        alert("error");
    })
    .complete(function(data) {
        ranking = eval ('(' + data.responseText + ')');
        var pages = (ranking.length - 1)/ 5;
        criarCamadaRanking(0, parseInt(pages));
    });
}
