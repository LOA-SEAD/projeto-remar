<!--
    Desenvolvido por Frederico Cardoso
  -->

<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <!-- Meta tags Obrigatórias -->
    <meta charset="utf-8">
    <meta name="layout" content="materialize-layout">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="/assets/favicon-3b33691d9fab5d6485becec8667d7307.png">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


    <!-- Aponta onde estão as funções javascript -->
    <g:javascript src="remar/stats/monta_graficos.js"></g:javascript>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <!-- script para chamar os construtores dos gráficos -->
    <script type="text/javascript">
      // Carregando a API de visualização e os pacotes de gráficos
      google.charts.load('current', {'packages':['corechart', 'table', 'line']});
    </script>

    <title>REMAR - Dashboard</title>
  </head>
  <body style="overflow-x: hidden">
    <!-- container do título e botão voltar -->
    <div class="container-fluid" style="margin-top:10px;">
      <div class="row">
        <div class="col s12 m1 l1">
          <p class="center-align"><a href="javascript:history.go(-1)"><< voltar</a></p>
        </div>
        <div class="col s12 m9 l9">
          <h3 class="center-align" style="margin:0; font-weight:bold">ESTATÍSTICAS</h3>
        </div>
        <div class="col s12 m2 l2" style="text-align: right;">
          <p class="center-align">
            <a href="/group/stats/${groupId}?exp=${exportedResource.id}" alt="Versão em tabela">Versão em tabela </a>
            <!--
            <a class="btn btn-floating pulse orange" href="/group/stats/${groupId}?exp=${exportedResource.id}"><img style="margin-top: 10px" src="/images/tabela.png" alt="versão em tabela" width=20 height=20 /></a>
            -->
            <a class="btn btn-floating pulse orange" href="/group/stats/${groupId}?exp=${exportedResource.id}"><i class="material-icons">grid_on</i></a>

          </p>
        </div>
      </div>
    </div>

    <!-- container da seleção de usuários para filtro -->
    <div class="container-fluid" style="justify-content: center">
      <!-- inicio do formulário de alunos -->
      <p class="center-align">
        <label for="cmbSelectUser" style="font-size: 12pt">Escolha um aluno para obter informações individuais: </label>
        <select id="cmbSelectUser" class="browser-default" style="width: 300px; display: inline;" required onchange="selectUser()">
          <option value="" selected>Toda turma...</option>
        </select>
      </p>
    </div>
    <!--
      --
      --
      --
         div para agrupar todos os gŕaficos de estatísticas gerais
      --
      --
      --
      -->
    <div id="estatisticasGeraisDiv">
      <!-- container dos gráficos de ranking e tempo de conclusão -->
      <div class="container-fluid">
        <div class="row">
          <div id="rankingDiv" class="col s12 m12 l4 center-align">
            <!-- Ranking de Pontuação -->
          </div>
          <div id="conclusionTimeDiv" class="col s12 m12 l8 center-align">
            <!-- Tempo de conclusão do jogo -->
          </div>
        </div>
      </div>

      <!-- container dos gráficos de número de alunos por nível e número de tentativas por nível -->
      <div class="container-fluid">
        <div class="row">
          <div id="usersLevelsDiv" class="col s12 m12 l4 center-align">
            <!-- Número de alunos por nível -->
          </div>
          <div id="levelsAttemptsDiv" class="col s12 m12 l4 center-align">
            <!-- Número de tentativas por nível -->
          </div>
          <div id="avarageLevelTimeDiv" class="col s12 m12 l4 center-align">
            <!-- Tempo médio de conlusão por nível -->
          </div>
        </div>
      </div>

      <div style="border: 1px solid; border-color: gray; border-radius: 5px; margin-top: 5px; margin-right: 5px; margin-left: 5px">
        <!-- container da seleção de nível para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de níveis -->
          <p class="center-align">
            <label for="cmbSelectLevel" style="font-size: 12pt">Escolha um nível para obter informações detalhadas:</label>
            <select id="cmbSelectLevel" style="display: inline; width: 300px" class="browser-default" required onchange="selectLevel()">
              <option id="defaultSelectLevel" selected>Selecione...</option>
              <g:each in="${exportedResource.getLevels()}" var="it">
                <option value="${it.number}">${it.name}</option>
              </g:each>
            </select>
          </p>
        </div>

        <!-- container dos gráficos de número de erros, tentativas e tempo por desafio -->
        <div class="container-fluid" style="margin-bottom: -20px">
          <div class="row">
            <div id="levelDetailDiv" class="col s12 m12 l5" style="border-right-color: gray; border-right: 1px dotted">
            <!-- Número de alunos por nível, suas tentativas não concluídas e concluídas -->
            </div>
            <div class="col s12 m12 l7">
              <div class="row">
                <div id="challengesErrorsDiv" class="col s12 m12 l7 center-align" style="margin-left: 25px; margin-right: -25px">
                <!-- Número de erros por desafio -->
                </div>
                <div id="challengesAttemptsDiv" class="col s12 m12 l5 center-align">
                  <!-- Número de tentativas por desafio -->
                </div>
              </div>
              <div class="row">
                <div id="avarageChallengeTimeDiv" class="col s12 m12 l12 center-align">
                  <!-- Tempo de conlusão por desafio -->
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- container da seleção de desafio para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de desafios -->
          <p class="center-align">
            <label for="cmbSelectChallenge" style="font-size: 12pt">Escolha um desafio para obter informações detalhadas:</label>
            <select id="cmbSelectChallenge" style="display: inline; width: 300px" class="browser-default" required onchange="selectChallenge()">
              <option id="defaultSelectChallenge" selected>Selecione...</option>
            </select>
          </p>
        </div>

        <!-- container dos gráficos de frequencia de escolhas por desafio -->
        <div class="container-fluid" id="choicesChallengesDiv" style="margin-top: 10px">
          <div class="row" style="margin-bottom: 10px">
            <div id="challengeDetailDiv" class="col s12 m12 l5 center-align" style="border-right-color: gray; border-right: 1px dotted">
              <!-- Número de alunos por desafio, quantos erros e acertos tiveram -->
            </div>
            <div id="frequenceChoiceDiv" class="col s12 m12 l7 center-align">
              <!-- Frequência de escolhas por desafio -->
            </div>
          </div>
        </div>
      </div>

      <!-- container das legendas dos desafios -->
      <div class="container-fluid" style="margin: 10px">
        <div class="row">
          <p style="color: orange; font-weight: bold; font-size: 14pt">Legendas <font size="1">(Escolha um nível para visualizar as legendas)</font></p>
        </div>
        <div class="row">
          <div id="legendDiv" class="col s12 m12 l12 center-align">
             <!--Legenda dos desafios -->
          </div>
        </div>
      </div>
    </div>
    <!--
      --
      --
         div para agrupar os gráficos de estatísticas por aluno
      --
      --
      -->
    <div id="estatisticasAlunoDiv">
      <div class="container-fluid">
        <!-- div dos gráficos de número de tentativas e tempo por nível de cada aluno -->
        <div class="row">
          <div id="playerLevelAttemptDiv" class="col s12 m12 l6 center-align">
            <!-- Número de tentativas por nível -->
          </div>
          <div id="playerTimeLevelDiv" class="col s12 m12 l6 center-align">
            <!-- tempo de conclusão por nível -->
          </div>
        </div>
      </div>

      <div style="border: 1px solid; border-color: gray; border-radius: 5px; margin-top: 5px; margin-right: 5px; margin-left: 5px">
        <!-- container da seleção de nível para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de níveis -->
          <p class="center-align">
            <label for="defaultSelectLevelUser" style="font-size: 12pt">Escolha um nível para obter informações detalhadas:</label>
            <select style="width: 300px; display: inline;" class="browser-default" id="cmbSelectLevelUser" required onchange="selectLevelUser()">
              <option id="defaultSelectLevelUser" selected>Selecione...</option>
              <g:each in="${exportedResource.getLevels()}" var="it">
                <option value="${it.number}">${it.name}</option>
              </g:each>
            </select>
          </p>
        </div>

        <div class="container-fluid">
          <!-- div dos gráficos de número de erros, tentativas e tempo por desafio de cada aluno -->
          <div class="row" id="challengersUserDiv">
            <div id="playerChallAttemptDiv" class="col s12 m12 l4 center-align">
              <!-- Número de tentativas por desafio -->
            </div>
            <div id="playerChallErrosDiv" class="col s12 m12 l4 center-align">
              <!-- Número de erros por desafio -->
            </div>
            <div id="playerChallTimeDiv" class="col s12 m12 l4 center-align">
              <!-- Tempo de conlusão por desafio -->
            </div>
          </div>
        </div>
      </div>

      <!-- container das legendas dos desafios -->
      <div class="container-fluid" style="margin: 10px">
        <div class="row">
          <p style="color: orange; font-weight: bold; font-size: 14pt">Legendas <font size="1">(Escolha um nível para visualizar as legendas)</font></p>
        </div>
        <div class="row">
          <div id="legendUserDiv" class="col s12 m12 l12 center-align">
            <!-- Legenda dos desafios -->
          </div>
        </div>
      </div>
    </div>

    <!-- container para atribuir licença de uso da API -->
    <div class="container" style="background-color: #f7f7f7; margin: 30px auto; border-radius: 5px;">
        <p style="color: darkgray; font-size: 12px; text-align: center;">
          Os gráficos apresentados nesta página são modificações baseadas no trabalho criado e <a href="https://developers.google.com/terms/site-policies" target="_blank">compartilhado pelo Google</a>, usados de acordo com os termos descritos na <a href="https://creativecommons.org/licenses/by/3.0/" target="_blank">Licença de Atribuição</a> da <a href="https://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons 3.0</a>.
        </p>
    </div>
  </body>
</html>