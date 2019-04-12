/**
  Adaptado da API Google Charts, por Frederico Cardoso
  **/

windows.onload = function() {
  pegaDados();
};

var jogo = "";
var grupo = "";
var nivel = "";
var desafio = "";
var usuario = "";

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

  //chama função para montar combo de usuários
  montaComboUser();

  //chama função para montar combo de níveis
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
  $.getJSON("http://alfa.remar.online/stats/groupUsers?" + grupo, function(options) {
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
  //preenche o combo de níveis
  $.getJSON("http://alfa.remar.online/stats/gameInfo?" + jogo, function(array) {
    var options = Object.keys(array);

    var select = document.getElementById("cmbSelectLevel");

    for(var i = 0; i < options.length; i++) {
      var opt = options[i];
      var el = document.createElement("option");
      el.textContent = opt;
      el.value = opt;

      select.appendChild(el);
    }
  });

  //bloqueia a primeira opção do combobox (Selecione...)
  document.getElementById('defaultSelectLevel').disabled = true;

  //bloqueia o combo de desafios
  document.getElementById('cmbSelectChallenge').disabled = true;
}

///////////////////////////
//função para montar o combo de níveis
///////////////////////////
function montaComboLevelUser() {
  //limpa combobox
  document.getElementById('cmbSelectLevelUser').options.length = 1;

  //preenche o combo de níveis
  $.getJSON("http://alfa.remar.online/stats/gameInfo?" + jogo, function(array) {
    var options = Object.keys(array);

    var select = document.getElementById("cmbSelectLevelUser");

    for(var i = 0; i < options.length; i++) {
      var opt = options[i];
      var el = document.createElement("option");
      el.textContent = opt;
      el.value = opt;

      select.appendChild(el);
    }
  });

  //bloqueia a primeira opção do combobox (Selecione...)
  document.getElementById('defaultSelectLevelUser').disabled = true;
}

///////////////////////////
//função para montar o combo de desafios
///////////////////////////
function montaComboChallenge(nivel) {
  //limpa combobox
  document.getElementById('cmbSelectChallenge').options.length = 1;

  //preenche o combo de desafios
  $.getJSON("http://alfa.remar.online/stats/gameInfo?" + jogo, function(array) {
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

    //monta combo de níveis
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

  //mostrando gráficos de desafios
  document.getElementById("challengersUserDiv").style.display = "flex";
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
  document.getElementById("choicesChallengesDiv").style.display = "flex";

  //atualizando a div onde está o gráfico
  load('index.html #choicesChallengesDiv');
}

///////////////////////////
//função para criar a tabela de ranking
///////////////////////////
function drawRanking() {
  $.get("http://alfa.remar.online/stats/ranking?" + grupo + "&" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/conclusionTime?" + grupo + "&" + jogo, function(array) {
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
        legend: { position: 'none' },
        height: 350,
        vAxis: { title: 'Tempo (min)' },
        connectSteps: false,
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
  $.get("http://alfa.remar.online/stats/quantityLevel?" + grupo + "&" + jogo, function(array) {
    if (array.length == 0) {
      var div = document.getElementById("usersLevelsDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Não houve alunos em nenhum nível.</p>";
    } else {
      array.unshift(['Nível', 'Quantidade']);

      var data = google.visualization.arrayToDataTable(array);
      var options = {
        title: 'Total de alunos por nível',
        titleTextStyle: { color: "orange",
                          bold: true
                        },
        pieHole: 0.5,
        //is3D: true,
        pieSliceText: 'value',
        /*slices: {  0: {offset: 0.1},
                   2: {offset: 0.2},
                   4: {offset: 0.1},
                   6: {offset: 0.2},
                },*/
        height: 300,
        legend: { position: 'bottom' },
        //colors: ['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6']
        //colors: ['#1E90FF', '#00BFFF', '#87CEFA', '#87CEEB', '#ADD8E6']
      };
      var chart = new google.visualization.PieChart(document.getElementById('usersLevelsDiv'));

      chart.draw(data, options);
    }
  });
}

///////////////////////////
//função para criar o gráfico de tentativas por nível
///////////////////////////
function drawLevelsAttempts() {
  $.get("http://alfa.remar.online/stats/levelAttempt2?" + grupo + "&" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/avgLevelTime?" + grupo + "&" + jogo, function(array) {
    if (array.length == 0) {
      var div = document.getElementById("avarageLevelTimeDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Os alunos não concluíram nenhum nível, por isso não tem tempo de conclusão por nível.</p>";
    } else {
      array.unshift(['Nível', 'Menor', "Maior"]);

      var data = google.visualization.arrayToDataTable(array);
      var options = {
        //title: 'Tempo médio de conclusão por nível (menor tempo de cada jogador)',
        title: 'Média de tempo por nível',
        titleTextStyle: { color: "orange",
                          bold: true
                        },
        height: 300,
        legend: { position: 'bottom' },
        vAxis: { title: 'Tempo (min)'
               },
        colors: ['#3568c9', '#ff7f27'],
        //isStacked: 'true',
        curveType: 'function'
      };
      var chart = new google.visualization.LineChart(document.getElementById('avarageLevelTimeDiv'));

      chart.draw(data, options);

      /*var chart = new google.charts.Line(document.getElementById('avarageLevelTimeDiv'));
      chart.draw(data, google.charts.Line.convertOptions(options));*/
    }
  });
}

///////////////////////////
//função para criar o gráfico de detalhes do nível
///////////////////////////
function drawLevelDetail(nivel) {
  $.get("http://alfa.remar.online/stats/levelAttemptRatio?" + grupo + "&" + jogo, function(array) {
    if (!(nivel in array)) {
      var div = document.getElementById("levelDetailDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Não houve alunos neste nível.</p>";
    } else {
      var data = array[nivel];

      data.unshift(['Aluno', 'Concluída', 'Não concluída']);

      var dados = google.visualization.arrayToDataTable(data);
      var options = {
        title: 'Tentativas de conclusão do nível por aluno',
        titleTextStyle: { color: "orange",
                          bold: true
                        },
        height: 400,
        chartArea: {width: '50%'},
        legend: { position: 'right' },
        vAxis: { title: 'Tentativas' },
        isStacked: true,
        colors: ['#008000', '#dc3912'],
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
  $.get("http://alfa.remar.online/stats/challMistake?" + grupo + "&" + jogo, function(array) {
    if (!(nivel in array)) {
      var div = document.getElementById("challengesErrorsDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Não houve nenhum erro cometido nos desafios deste nível.</p>";
    } else {
      var data = array[nivel];

      data.unshift(['Desafio', 'Número de erros']);

      var dados = google.visualization.arrayToDataTable(data);
      var options = {
        title: 'Taxa de erros por desafio',
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
  $.get("http://alfa.remar.online/stats/challAttempt?" + grupo + "&" + jogo, function(array) {
    if (!(nivel in array)) {
      var div = document.getElementById("challengesAttemptsDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Não houve nenhuma tentativa nos desafios deste nível.</p>";
    } else {
      var data = array[nivel];

      data.unshift(['Desafio', 'Número de tentativas']);

      var dados = google.visualization.arrayToDataTable(data);
      var options = {
        title: 'Total de tentativas por desafio',
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
  $.get("http://alfa.remar.online/stats/avgChallTime?" + grupo + "&" + jogo, function(array) {
    if (!(nivel in array)) {
      var div = document.getElementById("avarageChallengeTimeDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Os alunos não concluíram nenhum desafio, por isso não tem tempo de conclusão por desafio.</p>";
    } else {
      var data = array[nivel];

      data.unshift(['Nível', 'Menor', 'Maior']);

      var dados = google.visualization.arrayToDataTable(data);
      var options = {
        //title: 'Tempo médio de conclusão por nível (menor tempo de cada jogador)',
        title: 'Média de tempo por desafio',
        titleTextStyle: { color: "orange",
                          bold: true
                        },
        height: 250,
        width: '100%',
        legend: { position: 'right' },
        vAxis: { title: 'Tempo (seg)',
                 //minValue: 0
               },
        //colors: ['#109619', '#dc3812'],
        colors: ['#3568c9', '#ff7f27'],
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
  $.get("http://alfa.remar.online/stats/challMistakeRatio?" + grupo + "&" + jogo, function(array) {
    if (nivel in array) {
      var data = array[nivel];

      if (!(desafio in data)) {
        var div = document.getElementById("challengeDetailDiv");

        div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno tentou responder esse desafio.</p>";
      } else {
        var data2 = data[desafio];

        data2.unshift(['Aluno', 'Acertos', 'Erros']);

        var dados = google.visualization.arrayToDataTable(data2);
        var options = {
          title: 'Número de acertos e erros por aluno',
          titleTextStyle: { color: "orange",
                            bold: true
                          },
          height: 300,
          chartArea: { width: '50%' },
          legend: { position: 'right' },
          vAxis: { title: 'Quantidade' },
          isStacked: true,
          colors: ['#008000', '#dc3912'],
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
  $.get("http://alfa.remar.online/stats/choiceFrequency?" + grupo + "&" + jogo, function(array) {
    if (nivel in array) {
      var data = array[nivel];

      if (!(desafio in data)) {
        var div = document.getElementById("frequenceChoiceDiv");

        div.innerHTML = "<p style='color: red; text-align: center'>Nenhum aluno tentou responder esse desafio.</p>";
      } else {
        var data2 = data[desafio];

        data2.unshift(['Desafio', 'Quantidade de escolhas']);

        var dados = google.visualization.arrayToDataTable(data2);
        var options = {
          title: 'Frequência de escolhas por desafio',
          titleTextStyle: { color: "orange",
                            bold: true,
                            fontSize: 11
                          },
          legend: { position: 'none' },
          height: 300,
          vAxis: {
            title: 'Quantidade de escolhas',
            //textPosition: 'in',
          },
          hAxix: {
            title: 'Repostas do aluno',
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
  $.get("http://alfa.remar.online/stats/playerAttemptRatio?" + grupo + "&" + jogo, function(array) {
    if (!(usuario in array)) {
      var div = document.getElementById("playerLevelAttemptDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>Este aluno não tentou jogar nenhum nível deste jogo.</p>";
    } else {
      var data = array[usuario];

      data.unshift(['Nível', 'Concluída', 'Não concluída']);

    var dados = google.visualization.arrayToDataTable(data);
      var options = {
        title: 'Número de tentativas por Nível',
        titleTextStyle: { color: "orange",
                          bold: true
                        },
        height: 300,
        chartArea: { width: '50%' },
        legend: { position: 'right' },
        vAxis: { title: 'Quantidade' },
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
  $.get("http://alfa.remar.online/stats/playerLevelTime2?" + grupo + "&" + jogo, function(array) {
    if (!(usuario in array)) {
      var div = document.getElementById("playerTimeLevelDiv");

      div.innerHTML = "<p style='color: red; text-align: center'>O aluno não concluiu nenhum nível, por isso não tem tempo de conslusão.</p>";
    } else {
      var data = array[usuario];

      data.unshift(['Nível', 'Menor', 'Maior']);

      var dados = google.visualization.arrayToDataTable(data);
      var options = {
        title: 'Tempo de conclusão do nível',
        titleTextStyle: { color: "orange",
                          bold: true
                        },
        height: 300,
        legend: { position: 'bottom' },
        vAxis: { title: 'Tempo (min)',
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
  $.get("http://alfa.remar.online/stats/playerChallMistake?" + grupo + "&" + jogo, function(array) {
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
          //pieHole: 0.5,
          pieSliceText: 'value',
          height: 300,
          legend: { position: 'bottom',
                    maxLines: 3,
                  },
          is3D: false,
          //colors: ['#1E90FF', '#00BFFF', '#87CEFA', '#87CEEB', '#ADD8E6']
        };
        var chart = new google.visualization.PieChart(document.getElementById('playerChallErrosDiv'));

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
  $.get("http://alfa.remar.online/stats/playerChallAttempt?" + grupo + "&" + jogo, function(array) {
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
          title: 'Total de tentativas por desafio',
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
  $.get("http://alfa.remar.online/stats/playerChallTime?" + grupo + "&" + jogo, function(array) {
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
          vAxis: { title: 'Tempo (seg)',
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
//função para criar a tabela de legendas
///////////////////////////
function drawLegends(nivel) {
  $.get("http://alfa.remar.online/stats/gameInfo?" + grupo + "&" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/gameInfo?" + grupo + "&" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/playerLevelTime?" + grupo + "&" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/ranking?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/ranking?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
    //array.unshift(['Alunos', 'Tempo']);

    var data = anychart.data.set(array);
  });

  $.get("http://alfa.remar.online/stats/ranking?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
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
  $.get("http://alfa.remar.online/stats/levelTime?groupId=" + grupo + "&exportedResourceId=" + jogo, function(array) {
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