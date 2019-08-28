/**
 Adaptado da API Google Charts, por Frederico Cardoso
 Atualizado em: 26/08/2019
 **/

window.onload = function() {
    pegaDados()
};

var jogo = "";
var grupo = "";
var nivel = "";
var desafio = "";
var usuario = "";

var grupo2 = "";
var jogo2 = "";

///////////////////////////
//função para pegar o valor do jogo e grupo
///////////////////////////
function pegaDados() {
    var url   = window.location.search.replace("?", "");
    var items = url.split("&");
    var array = {
        'grupo' : items[0],
        'jogo' : items[1]
    }

    grupo = array.grupo;        //pega o valor do grupo passado na url
    jogo = array.jogo;          //pega o valor do jogo passado na url

    //definindo as variáveis para chamar a url de estátistica por tabela
    var teste = jogo.split("=");
    jogo2 = teste[1];

    var teste = grupo.split("=");
    grupo2 = teste[1];

    //chama função para montar combo de usuários
    montaComboUser();
    montaComboLevel();


    //chama as funções para montar os gráficos que não precisam de filtro
    drawRanking();
    drawConclusionTime();
    drawUsersInLevels();
    drawLevelsAttempts();
    drawAvarageLevels();

    //esconde a div de estatisticas por aluno
    document.getElementById("estatisticasAlunoDiv").style.display = "none";
    //load('index.html #estatisticasAlunoDiv');
}

///////////////////////////
//função para montar o combo de usuários
///////////////////////////
function montaComboUser() {
    $.getJSON("/stats/groupUsers?" + grupo, function(options) {
        var select = document.getElementById("cmbSelectUser");

        for(var i = 0; i < options.length; i++) {
            var opt = options[i];
            var el = document.createElement("option");
            el.textContent = opt;
            el.value = opt;

            select.appendChild(el);
        }
    });
}

///////////////////////////
//função para montar o combo de níveis
///////////////////////////
function montaComboLevel() {
    //bloqueia a primeira opção do combobox (Selecione...)
    document.getElementById('defaultSelectLevel').disabled = true;

    //bloqueia o combo de desafios
    document.getElementById('cmbSelectChallenge').disabled = true;
}

///////////////////////////
//função para montar o combo de níveis (por aluno)
///////////////////////////
function montaComboLevelUser() {
    //bloqueia a primeira opção do combobox (Selecione...)
    document.getElementById('defaultSelectLevelUser').disabled = true;

    document.getElementById('cmbSelectLevelUser').selectedIndex = 0
}

///////////////////////////
//função para montar o combo de desafios
///////////////////////////
function montaComboChallenge(nivel) {
    //limpa combobox
    document.getElementById('cmbSelectChallenge').options.length = 1;

    //preenche o combo de desafios
    $.getJSON("/stats/gameInfo?" + jogo, function(array) {
        var options = array[nivel];

        var select = document.getElementById("cmbSelectChallenge");

        for(var i = 0; i < options.length; i++) {
            var opt = options[i];
            var el = document.createElement("option");
            el.textContent = opt[0];
            el.value = opt[0];

            select.appendChild(el);
        }
    });

    //bloqueia a primeira opção do combobox (Selecione...)
    document.getElementById('defaultSelectChallenge').disabled = true;
}

///////////////////////////
//função para montar o combo de desafios por aluno
///////////////////////////
function montaComboChallengeUser(nivel) {
    //limpa combobox
    document.getElementById('cmbSelectChallengeUser').options.length = 1;

    //preenche o combo de desafios
    $.getJSON("/stats/gameInfo?" + jogo, function(array) {
        var options = array[nivel];

        var select = document.getElementById("cmbSelectChallengeUser");

        for(var i = 0; i < options.length; i++) {
            var opt = options[i];
            var el = document.createElement("option");
            el.textContent = opt[0];
            el.value = opt[0];

            select.appendChild(el);
        }
    });

    //bloqueia a primeira opção do combobox (Selecione...)
    document.getElementById('defaultSelectChallengeUser').disabled = true;
}

///////////////////////////
//função que pega o valor selecionado no comboBox de Usuários
///////////////////////////
function selectUser() {
    usuario = $("#cmbSelectUser option:selected").text();

    if (usuario != "Toda turma...") {
        //chama as funções para montar os gráficos
        drawUserLevelsAttempts(usuario);
        drawUserTimeLevels2(usuario);

        //desbloqueia a primeira opção do combobox (Selecione...)
        document.getElementById('defaultSelectLevelUser').disabled = false;

        montaComboLevelUser();

        //escondendo e mostrando div
        document.getElementById("estatisticasGeraisDiv").style.display = "none";
        document.getElementById("estatisticasAlunoDiv").style.display = "inline";
        document.getElementById("challengersUserDiv").style.display = "none";
        document.getElementById("legendUserDiv").style.display = "none";
    } else {
        document.getElementById("estatisticasGeraisDiv").style.display = "block";
        document.getElementById("estatisticasAlunoDiv").style.display = "none";
    }
}

///////////////////////////
//função que pega o valor selecionado no comboBox de Níveis
///////////////////////////
function selectLevel() {
    //escondendo gráficos de desafios
    document.getElementById("choicesChallengesDiv").style.display = "none";

    //definindo o valor da variável nível de acordo com a opção do combo selecionada
    nivel = $("#cmbSelectLevel option:selected").text();

    //chama as funções para montar os gráficos de desafios
    drawLevelDetail(nivel);
    drawChallengesErrors(nivel);
    drawChallengesAttempts(nivel);
    drawAvarageChallenges(nivel);
    drawLegends(nivel);

    //desbloqueia o combo de desafios
    document.getElementById('cmbSelectChallenge').disabled = false;

    //desbloqueia a primeira opção do combobox (Selecione...)
    document.getElementById('defaultSelectChallenge').disabled = false;

    //chama função para montar o combo de desafio
    montaComboChallenge(nivel);

    //atualizando a div onde está o gráfico
    load('index.html #estatisticasGeraisDiv');
}

///////////////////////////
//função que pega o valor selecionado no comboBox de Níveis na página de alunos
///////////////////////////
function selectLevelUser() {
    nivel = $("#cmbSelectLevelUser option:selected").text();

    //chama as funções para montar os gráficos de desafios
    drawUserChallengesAttempts(usuario, nivel);
    drawUserChallengesErrors(usuario, nivel);
    drawUserTimeChalls(usuario, nivel);
    drawLegendsUser(nivel);

    //desbloqueia o combo de desafios
    document.getElementById('cmbSelectChallengeUser').disabled = false;

    //desbloqueia a primeira opção do combobox (Selecione...)
    document.getElementById('defaultSelectChallengeUser').disabled = false;

    //chama função para montar o combo de desafio
    montaComboChallengeUser(nivel);

    //mostrando gráficos de desafios
    document.getElementById("challengersUserDiv").style.display = "block";
    document.getElementById("legendUserDiv").style.display = "flex";

    //atualizando a div onde está o gráfico
    load('index.html #challengersUserDiv');
}

///////////////////////////
//função que pega o valor selecionado no comboBox de Desafios
///////////////////////////
function selectChallenge() {
    //definindo o valor da variável nível de acordo com a opção do combo selecionada
    desafio = $("#cmbSelectChallenge option:selected").text();

    //chama as funções para montar os gráficos de desafios
    drawChallengeDetail(nivel, desafio);
    drawFrequenceChoice(nivel, desafio);

    //mostrando gráficos de desafios
    document.getElementById("choicesChallengesDiv").style.display = "block";

    //atualizando a div onde está o gráfico
    load('index.html #choicesChallengesDiv');
}

///////////////////////////
//função que pega o valor selecionado no comboBox de Desafios
///////////////////////////
function selectChallengeUser() {
    //definindo o valor da variável nível de acordo com a opção do combo selecionada
    desafio = $("#cmbSelectChallengeUser option:selected").text();

    //chama as funções para montar os gráficos de desafios
    drawUserFrequenceChoice(usuario, nivel, desafio);

    //mostrando gráficos de desafios
    document.getElementById("choicesChallengesUserDiv").style.display = "block";

    //atualizando a div onde está o gráfico
    load('index.html #choicesChallengesUserDiv');
}

///////////////////////////
//função para criar a tabela de ranking
///////////////////////////
function drawRanking() {
    $.get("/stats/ranking?" + grupo + "&" + jogo, function(array) {
        if (array.length == 0) {
            var div = document.getElementById("rankingDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno concluiu o jogo, por isso não tem ranking de pontuação.</p>";
        } else {
            array.unshift(['Nome', 'Pontuação']);

            var data = google.visualization.arrayToDataTable(array);
            var table = new google.visualization.Table(document.getElementById('rankingDiv'));

            table.draw(data, { showRowNumber: true,
                width: '100%',
                height: '300px'
            });
        }
    });
}

///////////////////////////
//função para criar o gráfico de tempo de conclusão
///////////////////////////
function drawConclusionTime() {
    $.get("/stats/conclusionTime?" + grupo + "&" + jogo, function(array) {
        if (array.length == 0) {
            var div = document.getElementById("conclusionTimeDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno concluiu o jogo, por isso não tem tempo de conclusão.</p>";
        } else {
            array.unshift(['Alunos', 'Menor']);
            var data = google.visualization.arrayToDataTable(array);

            var options = {
                title: 'Tempo mínimo de conclusão do jogo',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                legend: { position: 'right' },
                height: 350,
                vAxis: { title: 'Tempo (minutos)' },
                //connectSteps: false,
                //colors: ['#3568c9', '#ff7f27'],
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('conclusionTimeDiv'));

            chart.draw(data, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de usuários por nível
///////////////////////////
function drawUsersInLevels() {
    $.get("/stats/quantityLevel?" + grupo + "&" + jogo, function(array) {
        if (array.length == 0) {
            var div = document.getElementById("usersLevelsDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não houve alunos em nenhum nível.</p>";
        } else {
            array.unshift(['Nível', 'Quantidade']);

            var data = google.visualization.arrayToDataTable(array);
            var options = {
                title: 'Número de alunos por nível',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                //pieHole: 0.5,
                //is3D: true,
                //pieSliceText: 'value',
                /*slices: {  0: {offset: 0.1},
                           2: {offset: 0.2},
                           4: {offset: 0.1},
                           6: {offset: 0.2},
                        },*/
                height: 300,
                vAxis: { title: 'Número de alunos', minValue: 0 },
                legend: { position: 'none' },
                //colors: ['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6']
                //colors: ['#1E90FF', '#00BFFF', '#87CEFA', '#87CEEB', '#ADD8E6']
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('usersLevelsDiv'));

            chart.draw(data, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de tentativas por nível
///////////////////////////
function drawLevelsAttempts() {
    $.get("/stats/levelAttempt2?" + grupo + "&" + jogo, function(array) {
        if (array.length == 0) {
            var div = document.getElementById("levelsAttemptsDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não houve tentativas em nenhum nível.</p>";
        } else {
            array.unshift(['Nível', 'Total', 'Concluída']);

            var data = google.visualization.arrayToDataTable(array);
            var options = {
                title: 'Número de tentativas por nível',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 300,
                vAxis: { title: 'Número de tentativas' },
                legend: { position: 'bottom' },
                colors: ['#3366cc', '#008000']
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('levelsAttemptsDiv'));

            chart.draw(data, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de média de tempo por nível
///////////////////////////
function drawAvarageLevels() {
    $.get("/stats/levelTime?" + grupo + "&" + jogo, function(array) {
        if (array.length == 0) {
            var div = document.getElementById("avarageLevelTimeDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Os alunos não concluíram nenhum nível, por isso não tem tempo de conclusão por nível.</p>";
        } else {
            array.unshift(['Nível', 'Menor', 'Maior', 'Média', 'Mediana']);

            var data = google.visualization.arrayToDataTable(array);
            var options = {
                title: 'Tempo de conclusão por nível',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 300,
                legend: { position: 'bottom' },
                vAxis: { title: 'Tempo (minutos)'
                },
                colors: ['#1d9623', '#f75858', '#3568c9', '#ff7f27'],
                curveType: 'function'
            };
            var chart = new google.visualization.LineChart(document.getElementById('avarageLevelTimeDiv'));

            chart.draw(data, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de detalhes do nível
///////////////////////////
/*function drawLevelDetail(nivel) {
    $.get("/stats/levelAttemptRatio?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("levelDetailDiv");
            div.innerHTML = "<p style='color: red; text-align: center'>Não houve alunos neste nível.</p>";
        } else {
            var data = array[nivel];
            data.unshift(['ID', 'Erros', 'Acertos', 'Desafio', 'Tentativas']);
            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Progresso da turma no nível',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 450,
                //chartArea: {width: '50%'},
                legend: { position: 'right' },
                hAxis: { title: 'Número de erros',
                         minValue: 0 },
                vAxis: { title: 'Número de acertos',
                         minValue: 0 },
                bubble: { textStyle: {fontSize: 11 } },
            };
            var chart = new google.visualization.BubbleChart(document.getElementById('levelDetailDiv'));
            chart.draw(dados, options);
        }
    });
}*/

function drawLevelDetail(nivel) {
    $.get("/stats/levelAttemptRatio?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("levelDetailDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não houve alunos neste nível.</p>";
        } else {
            var data = array[nivel];

            data.unshift(['Aluno', 'Não concluída', 'Concluída']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Número de tentativas no nível por aluno',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 450,
                chartArea: {width: '50%'},
                legend: { position: 'right' },
                vAxis: { title: 'Número de tentativas' },
                isStacked: true,
                colors: ['#dc3912', '#008000'],
                //colors: ['#f96969', '#12b21b'],
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('levelDetailDiv'));

            chart.draw(dados, options);
        }
    });
}


///////////////////////////
//função para criar o gráfico de desafios com maior taxa de erro
///////////////////////////
function drawChallengesErrors(nivel) {
    $.get("/stats/challMistake?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("challengesErrorsDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não houve nenhum erro cometido nos desafios deste nível.</p>";
        } else {
            var data = array[nivel];

            data.unshift(['Desafio', 'Número de erros']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Taxa de erro por desafio',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 200,
                legend: { position: 'none',
                    maxLines: 3
                },
                vAxis: { title: 'Número de erros',
                    minValue: 0
                },
                connectSteps: true,
                colors: ['red']
            };
            var chart = new google.visualization.SteppedAreaChart(document.getElementById('challengesErrorsDiv'));

            chart.draw(dados, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de tentativas por desafio
///////////////////////////
function drawChallengesAttempts(nivel) {
    $.get("/stats/challAttempt?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("challengesAttemptsDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não houve nenhuma tentativa nos desafios deste nível.</p>";
        } else {
            var data = array[nivel];

            data.unshift(['Desafio', 'Número de tentativas']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Tentativas por desafio',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                //pieHole: 0.5,
                pieSliceText: 'value',
                height: 200,
                legend: { position: 'bottom',
                    maxLines: 3
                },
                //is3D: true,
                //colors: ['#1E90FF', '#00BFFF', '#87CEFA', '#87CEEB', '#ADD8E6']
            };
            var chart = new google.visualization.PieChart(document.getElementById('challengesAttemptsDiv'));

            chart.draw(dados, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de média de tempo por desafio
///////////////////////////
function drawAvarageChallenges(nivel) {
    $.get("/stats/challTime?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("avarageChallengeTimeDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Os alunos não concluíram nenhum desafio, por isso não tem tempo de conclusão por desafio.</p>";
        } else {
            var data = array[nivel];

            data.unshift(['Nível', 'Menor', 'Maior', 'Média', 'Mediana']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Tempo de conclusão por desafio',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 250,
                width: '100%',
                legend: { position: 'right' },
                vAxis: { title: 'Tempo (segundos)',
                    //minValue: 0
                },
                //colors: ['#109619', '#dc3812'],
                colors: ['#1d9623', '#f75858', '#3568c9', '#ff7f27'],
                isStacked: 'false'
            };

            var chart = new google.visualization.AreaChart(document.getElementById('avarageChallengeTimeDiv'));

            chart.draw(dados, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico com detalhes do desafio
///////////////////////////
function drawChallengeDetail(nivel, desafio) {
    $.get("/stats/challMistakeRatio?" + grupo + "&" + jogo, function(array) {
        if (nivel in array) {
            var data = array[nivel];

            if (!(desafio in data)) {
                var div = document.getElementById("challengeDetailDiv");

                div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno tentou responder esse desafio.</p>";
            } else {
                var data2 = data[desafio];

                data2.unshift(['Aluno', 'Erros', 'Acertos']);

                var dados = google.visualization.arrayToDataTable(data2);
                var options = {
                    title: 'Número de tentativas no desafio por aluno',
                    titleTextStyle: { color: "orange",
                        bold: true
                    },
                    height: 300,
                    chartArea: { width: '50%' },
                    legend: { position: 'right' },
                    vAxis: { title: 'Número de tentativas' },
                    isStacked: true,
                    colors: [ '#dc3912', '#008000'],
                };
                var chart = new google.visualization.ColumnChart(document.getElementById('challengeDetailDiv'));

                chart.draw(dados, options);
            }
        } else {
            var div = document.getElementById("challengeDetailDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno tentou responder esse desafio.</p>";
        }
    });
}

///////////////////////////
//função para criar o gráfico de frequência de escolhas por desafio
///////////////////////////
function drawFrequenceChoice(nivel, desafio) {
    $.get("/stats/choiceFrequency?" + grupo + "&" + jogo, function(array) {
        if (nivel in array) {
            var data = array[nivel];

            if (!(desafio in data)) {
                var div = document.getElementById("frequenceChoiceDiv");

                div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno tentou responder esse desafio.</p>";
            } else {
                var data2 = data[desafio];

                data2.unshift(['Desafio', 'Quantidade', { role: 'style' }]);

                var dados = google.visualization.arrayToDataTable(data2);
                var options = {
                    title: 'Frequência de respostas por desafio',
                    titleTextStyle: { color: "orange",
                        bold: true,
                        fontSize: 11
                    },
                    legend: { position: 'none' },
                    height: 300,
                    vAxis: {
                        title: 'Número de escolhas',
                        //textPosition: 'in',
                    },
                    hAxis: {
                        title: 'Resposta escolhida',
                    },
                    //colors: ['#1E90FF']
                };
                var chart = new google.visualization.ColumnChart(document.getElementById('frequenceChoiceDiv'));

                chart.draw(dados, options);
            }
        } else {
            var div = document.getElementById("frequenceChoiceDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno tentou responder esse desafio.</p>";
        }
    });
}

///////////////////////////
//função para criar o gráfico de tentativas por nível, filtrado por aluno
///////////////////////////
function drawUserLevelsAttempts(usuario) {
    $.get("/stats/playerAttemptRatio?" + grupo + "&" + jogo, function(array) {
        if (!(usuario in array)) {
            var div = document.getElementById("playerLevelAttemptDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Este aluno não tentou jogar nenhum nível deste jogo.</p>";
        } else {
            var data = array[usuario];

            data.unshift(['Nível', 'Não concluída', 'Concluída']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Número de tentativas por nível',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 300,
                chartArea: { width: '50%' },
                legend: { position: 'right' },
                vAxis: { title: 'Número de tentativas' },
                isStacked: true,
                colors: ['#109618', '#dc3912'],
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('playerLevelAttemptDiv'));

            chart.draw(dados, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de tempo gasto por nível, filtrado por aluno
///////////////////////////
function drawUserTimeLevels2(usuario) {
    $.get("/stats/playerLevelTime2?" + grupo + "&" + jogo, function(array) {
        if (!(usuario in array)) {
            var div = document.getElementById("playerTimeLevelDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>O aluno não concluiu nenhum nível, por isso não tem tempo de conslusão.</p>";
        } else {
            var data = array[usuario];

            data.unshift(['Nível', 'Menor', 'Maior']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Tempo de conclusão por nível',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                height: 300,
                legend: { position: 'bottom' },
                vAxis: { title: 'Tempo (minutos)',
                    //minValue: 0
                },
                curveType: 'function',
                colors: ['#3568c9', '#ff7f27'],
                isStacked: 'true'
            };
            var chart = new google.visualization.LineChart(document.getElementById('playerTimeLevelDiv'));

            chart.draw(dados, options);
        }
    });
}

///////////////////////////
//função para criar o gráfico de erros por desafio, filtrado por aluno
///////////////////////////
function drawUserChallengesErrors(usuario, nivel) {
    $.get("/stats/playerChallMistake?" + grupo + "&" + jogo, function(array) {
        if (usuario in array) {
            var data = array[usuario];

            if (!(nivel in data)) {
                var div = document.getElementById("playerChallErrosDiv");

                div.innerHTML = "<p style='color: red; text-align: center'>O usuário não tem erros registrados nos desafios deste nível.</p>";
            } else {
                var data2 = data[nivel];

                data2.unshift(['Desafio', 'Número de erros']);

                var dados = google.visualization.arrayToDataTable(data2);
                var options = {
                    title: 'Total de erros por desafio',
                    titleTextStyle: { color: "orange",
                        bold: true
                    },
                    height: 300,
                    legend: { position: 'none',
                        maxLines: 3
                    },
                    vAxis: { title: 'Número de erros',
                        //minValue: 0
                    },
                    connectSteps: true,
                    colors: ['red']
                };
                var chart = new google.visualization.SteppedAreaChart(document.getElementById('playerChallErrosDiv'));

                chart.draw(dados, options);
            }
        } else {
            var div = document.getElementById("playerChallErrosDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>O usuário não tem erros registrados nos desafios deste nível.</p>";
        }
    });
}

///////////////////////////
//função para criar o gráfico de tentativas por desafio, filtrado por aluno
///////////////////////////
function drawUserChallengesAttempts(usuario, nivel) {
    $.get("/stats/playerChallAttempt?" + grupo + "&" + jogo, function(array) {
        if (usuario in array) {
            var data = array[usuario];

            if (!(nivel in data)) {
                var div = document.getElementById("playerChallAttemptDiv");

                div.innerHTML = "<p style='color: red; text-align: center'>O usuário não tentou responder esse desafio.</p>";
            } else {
                var data2 = data[nivel];

                data2.unshift(['Desafio', 'Número de tentativas']);

                var dados = google.visualization.arrayToDataTable(data2);
                var options = {
                    title: 'Tentativas por desafio',
                    titleTextStyle: { color: "orange",
                        bold: true,
                    },
                    //pieHole: 0.5,
                    pieSliceText: 'value',
                    height: 300,
                    legend: { position: 'bottom',
                        maxLines: 3
                    },
                    is3D: true,
                    //colors: ['#1E90FF', '#00BFFF', '#87CEFA', '#87CEEB', '#ADD8E6']
                };
                var chart = new google.visualization.PieChart(document.getElementById('playerChallAttemptDiv'));

                chart.draw(dados, options);
            }
        } else {
            var div = document.getElementById("playerChallAttemptDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>O usúario não tentou responder nenhum desafio deste nível.</p>";
        }
    });
}

///////////////////////////
//função para criar o gráfico de tempo gasto por desafio, filtrado por aluno
///////////////////////////
function drawUserTimeChalls(usuario, nivel) {
    $.get("/stats/playerChallTime?" + grupo + "&" + jogo, function(array) {
        if (usuario in array) {
            var data = array[usuario];

            if (!(nivel in data)) {
                var div = document.getElementById("playerChallTimeDiv");

                div.innerHTML = "<p style='color: red; text-align: center'>Este aluno não concluiu nenhum desafio deste nível, por isso não tem tempo de conclusão.</p>";
            } else {
                var data2 = data[nivel];

                data2.unshift(['Desafio', 'Menor', 'Maior']);

                var dados = google.visualization.arrayToDataTable(data2);
                var options = {
                    title: 'Tempo de conclusão de cada desafio',
                    titleTextStyle: { color: "orange",
                        bold: true
                    },
                    height: 300,
                    legend: { position: 'bottom' },
                    vAxis: { title: 'Tempo (segundos)',
                        //minValue: 0
                    },
                    //curveType: 'function',
                    colors: ['#3568c9', '#ff7f27'],
                    isStacked: false
                };
                var chart = new google.visualization.AreaChart(document.getElementById('playerChallTimeDiv'));

                chart.draw(dados, options);
            }
        } else {
            var div = document.getElementById("playerChallTimeDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Este aluno não concluiu nenhum desafio deste nível, por isso não tem tempo de conclusão.</p>";
        }
    });
}

///////////////////////////
//função para criar o gráfico de frequência de escolhas por desafio de cada aluno
///////////////////////////
function drawUserFrequenceChoice(usuario, nivel, desafio) {
    $.get("/stats/playerChoiceFrequency?" + grupo + "&" + jogo, function(array) {
        if (usuario in array) {
            var data = array[usuario];

            if (nivel in data) {
                var data2 = data[nivel];

                if (!(desafio in data2)) {
                    var div = document.getElementById("playerFrequenceChoiceDiv");

                    div.innerHTML = "<p style='color: red; text-align: center'>O aluno não tentou responder esse desafio.</p>";
                } else {
                    var data3 = data2[desafio];

                    data3.unshift(['Desafio', 'Quantidade', { role: 'style' }]);

                    var dados = google.visualization.arrayToDataTable(data3);
                    var options = {
                        title: 'Frequência de respostas dada por desafio',
                        titleTextStyle: { color: "orange",
                            bold: true,
                            fontSize: 11
                        },
                        legend: { position: 'none' },
                        height: 300,
                        vAxis: {
                            title: 'Número de escolhas',
                            //textPosition: 'in',
                        },
                        hAxis: {
                            title: 'Resposta escolhida',
                        },
                        //colors: ['#1E90FF']
                    };
                    var chart = new google.visualization.ColumnChart(document.getElementById('playerFrequenceChoiceDiv'));

                    chart.draw(dados, options);
                }
            } else {
                var div = document.getElementById("playerFrequenceChoiceDiv");

                div.innerHTML = "<p style='color: red; text-align: center'>O aluno não tentou responder esse desafio.</p>";
            }
        } else {
            var div = document.getElementById("playerFrequenceChoiceDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>O aluno não tentou responder esse desafio.</p>";
        }
    });
}

///////////////////////////
//função para criar a tabela de legendas
///////////////////////////
function drawLegends(nivel) {
    $.get("/stats/gameInfo?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("legendDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não há desafios neste nível ou os desafios não possuem questões, por isso não possui legenda.</p>";
        } else {
            var data = array[nivel];

            data.unshift(['Desafio', 'Questão', 'Resposta correta']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Legendas',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                showRowNumber: false,
                width: '100%',
                backgroundColor: 'transparent',
            };
            var table = new google.visualization.Table(document.getElementById('legendDiv'));

            table.draw(dados, options);
        }
    });
}

///////////////////////////
//função para criar a tabela de legendas nas estatísticas dos alunos
///////////////////////////
function drawLegendsUser(nivel) {
    $.get("/stats/gameInfo?" + grupo + "&" + jogo, function(array) {
        if (!(nivel in array)) {
            var div = document.getElementById("legendUserDiv");

            div.innerHTML = "<p style='color: red; text-align: center'>Não há desafios neste nível ou os desafios não possuem questões, por isso não possui legenda.</p>";
        } else {
            var data = array[nivel];

            data.unshift(['Desafio', 'Questão', 'Resposta correta']);

            var dados = google.visualization.arrayToDataTable(data);
            var options = {
                title: 'Legendas',
                titleTextStyle: { color: "orange",
                    bold: true
                },
                showRowNumber: false,
                width: '100%',
                backgroundColor: 'transparent',
            };
            var table = new google.visualization.Table(document.getElementById('legendUserDiv'));

            table.draw(dados, options);
        }
    });
}

//função para criar o gráfico de tempo gasto por nível, filtrado por aluno
/*function drawUserTimeLevels(usuario, nivel) {
  $.get("/stats/playerLevelTime?" + grupo + "&" + jogo, function(array) {
    if (usuario in array) {
      var data = array[usuario];
      if (!(nivel in data)) {
        var div = document.getElementById("playerTimeLevelDiv");
        div.innerHTML = "<p style='color: red; text-align: center'>O aluno não concluiu este desafio, por isso não tem tempo de conslusão.</p>";
      } else {
        var data2 = data[nivel];
        data2.unshift(['Tentativa', 'Tempo']);
        var dados = google.visualization.arrayToDataTable(data2);
        var options = {
          title: 'Tempo de conclusão do nível para cada tentativa',
          titleTextStyle: { color: "orange",
                            bold: true
                          },
          height: 300,
          legend: { position: 'bottom' },
          vAxis: { title: 'Tempo (min)',
                   //minValue: 0
                 },
          curveType: 'function'
          //colors: ['green', 'red'],
        };
        var chart = new google.visualization.LineChart(document.getElementById('playerTimeLevelDiv'));
        chart.draw(dados, options);
      }
    } else {
      var div = document.getElementById("playerTimeLevelDiv");
      div.innerHTML = "<p style='color: red; text-align: center'>Este aluno não concluiu nenhum nível deste jogo, por isso não tem tempo de conclusão.</p>";
    }
  });
}*/

//EXEMPLO DE FUNÇÃO QUE MOSTRA RANKING USANDO A API DO AnyChart
/*function drawTeste() {
  $.get("/stats/ranking?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
    //array.unshift(['Alunos', 'Tempo']);
    var data = anychart.data.set(array);
    // create a chart
    chart = anychart.column();
    // create a column series and set the data
    var series = chart.column(data);
    // configure tooltips on the chart
    chart.title("Ranking de Pontuação");
    // enable the legend
    chart.legend(false);
    // configure tooltips on the chart
    //chart.tooltip().title("Information");
    chart.tooltip().format("Pontos: {%value}");
    // set the titles of the axes
    //chart.xAxis().title("Usuários");
    chart.yAxis().title("Pontuação");
    // set the container id
    chart.container("timeConclusionDiv");
    // initiate drawing the chart
    chart.draw();
  });
}*/

//EXEMPLO DE GRÁFICO DUPLO (UM GRÁFICO DE PIZZA DENTRO DO OUTRO - Doughnut) USANDO A API DO AnyChart
/*function drawDoubleGraph() {
  $.get("/stats/ranking?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
    //array.unshift(['Alunos', 'Tempo']);
    var data = anychart.data.set(array);
  });
  $.get("/stats/ranking?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
    //array.unshift(['Alunos', 'Tempo']);
    var data2 = anychart.data.set(array);
  });
  // create and configure a pie chart
  var chart1 = anychart.pie(data);
  chart1.innerRadius("75%");
  // create a bar chart
  var chart2 = anychart.pie(data2);
  chart2.legend(false);
  // set bar chart as the center content of a pie chart
  chart1.center().content(chart2);
  //chart1.title("Donut Chart: Chart in the center");
  chart1.container("timeConclusionDiv");
  chart1.draw();
}*/

//função para criar o gráfico de tentativas por nível
/*function drawAvarageLevels() {
  $.get("/stats/levelTime?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
    array.unshift(['Nível', 'Média de tempo (min)']);
    var data = google.visualization.arrayToDataTable(array);
    var options = {
      title: 'Tempo médio de conclusão por nível',
      titleTextStyle: { color: "orange",
                        bold: true
                      },
      height: 320,
      legend: { position: 'none' },
      vAxis: { title: 'Tempo (min)',
               minValue: 0
             },
      hAxis: { title: 'Nível' },
      colors: ['#1E90FF'],
    };
    var chart = new google.visualization.ScatterChart(document.getElementById('avarageLevelsDiv'));
    chart.draw(data, options);
  });
}*/