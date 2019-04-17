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

    <title>REMAR - Dashaboard</title>
  </head>
  <body style="overflow-x: hidden">
    <!-- container do título e botão voltar -->
    <div class="content">
      <div class="row">
        <div class="col sm2">
          <a href="javascript:window.history.go(-1)"><< voltar</a>
        </div>
        <div class="col sm11">
          <h1 class="display-6 text-center font-weight-bold">ESTATÍSTICAS</h1>
        </div>
      </div>
    </div>

    <!-- container da seleção de usuários para filtro -->
    <div class="container-fluid" style="justify-content: center; /*margin-bottom: -20px*/">
      <!--<p style="text-align: center; font-size: 10pt">
        As informações carregadas incialmente, referem-se ao desempenho da turma em geral
      </p>-->
      <!-- inicio do formulário de alunos -->
      <form class="bd-example">
        <fieldset>
          <p style="text-align: center; font-size: 10pt;">
            <label for="selectUser">Escolha um aluno para obter informações individuais: </label>
            <select class="w-25" id="cmbSelectUser" required onchange="selectUser()">
              <option value="">Toda turma...</option>
            </select>
          </p>
        </fieldset>
      </form>
    </div>
    <!--
         div para agrupar todos os gŕaficos de estatísticas gerais
      -->
    <div id="estatisticasGeraisDiv">
      <!-- container dos gráficos de ranking e tempo de conclusão -->
      <div class="container-fluid" style="justify-content: center">
        <div class="row">
          <div id="rankingDiv" class="col sm4">
            <!-- Ranking de Pontuação -->
          </div>
          <div id="conclusionTimeDiv" class="col sm8">
            <!-- Tempo de conclusão do jogo -->
          </div>
        </div>
      </div>

      <!-- container dos gráficos de número de alunos por nível e número de tentativas por nível -->
      <div class="row">
        <div class="container-fluid">
          <div id="usersLevelsDiv" class="col sm4 text-white">
            <!-- Número de alunos por nível -->
          </div>
        </div>
        <div class="container-fluid">
          <div id="levelsAttemptsDiv" class="col sm4 text-white">
            <!-- Número de tentativas por nível -->
          </div>
        </div>
        <div class="container-fluid">
          <div id="avarageLevelTimeDiv" class="col sm4 text-white">
            <!-- Tempo médio de conlusão por nível -->
          </div>
        </div>
      </div>

      <div style="border: 1px solid; border-color: gray; border-radius: 5px; margin-top: 5px; margin-right: 5px; margin-left: 5px">
        <!-- container da seleção de nível para filtro -->
        <div class="container-fluid" style="justify-content: center; /*margin-bottom: -20px;*/ margin-top: 10px">
          <!-- inicio do formulário de níveis -->
          <form class="bd-example">
            <fieldset>
              <p style="text-align: center; font-size: 10pt">
                <label for="selectLevel">Escolha um nível para obter informações detalhadas:</label>
                <select class="w-25" id="cmbSelectLevel" required onchange="selectLevel()">
                  <option id="defaultSelectLevel">Selecione...</option>
                </select>
              </p>
            </fieldset>
          </form>
        </div>

        <!-- container dos gráficos de número de erros, tentativas e tempo por desafio -->
        <div class="container-fluid">
          <div class="row" id="challengersDiv">
            <div id="levelDetailDiv" class="col sm5" style="border-right-color: gray; border-right: 1px dotted">
            <!-- Número de alunos por nível, suas tentativas não concluídas e concluídas -->
            </div>
            <div class="col sm7">
              <div class="row">
                <div id="challengesErrorsDiv" class="col sm7" style="margin-left: 25px; margin-right: -25px">
                <!-- Número de erros por desafio -->
                </div>
                <div id="challengesAttemptsDiv" class="col sm5">
                  <!-- Número de tentativas por desafio -->
                </div>
              </div>
              <div class="row">
                <div id="avarageChallengeTimeDiv" class="col sm12">
                  <!-- Tempo de conlusão por desafio -->
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- container da seleção de desafio para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de desafios -->
          <form id="comboDesafio" class="bd-example">
            <fieldset>
              <p style="text-align: center; font-size: 10pt">
                <label for="selectChallenge">Escolha um desafio para obter informações detalhadas:</label>
                <select class="w-25" id="cmbSelectChallenge" required onchange="selectChallenge()">
                  <option id="defaultSelectChallenge" selected="selected">Selecione...</option>
                </select>
              </p>
            </fieldset>
          </form>
        </div>

        <!-- container dos gráficos de frequencia de escolhas por desafio -->
        <div class="container-fluid" style="margin-top: 10px">
          <div class="row" id="choicesChallengesDiv" style="margin-bottom: 10px">
            <div id="challengeDetailDiv" class="col sm5" style="border-right-color: gray; border-right: 1px dotted">
              <!-- Número de alunos por desafio, quantos erros e acertos tiveram -->
            </div>
            <div id="frequenceChoiceDiv" class="col sm7">
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
          <div id="legendDiv" class="col sm2">
             <!--Legenda dos desafios -->
          </div>
        </div>
      </div>
    </div>
    <!--
      --
      --
      --
         div para agrupar os gráficos de estatísticas por aluno
      --
      --
      --
      -->
    <div id="estatisticasAlunoDiv">
      <div class="container-fluid">
        <!-- div dos gráficos de número de tentativas e tempo por nível de cada aluno -->
        <div class="row">
          <div id="playerLevelAttemptDiv" class="col sm6">
            <!-- Número de tentativas por nível -->
          </div>
          <div id="playerTimeLevelDiv" class="col sm6">
            <!-- tempo de conclusão por nível -->
          </div>
        </div>
      </div>

      <div style="border: 1px solid; border-color: gray; border-radius: 5px; margin-top: 5px; margin-right: 5px; margin-left: 5px">
        <!-- container da seleção de nível para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de níveis -->
          <form class="bd-example">
            <fieldset>
              <p style="text-align: center; font-size: 10pt">
                <label for="selectLevel">Escolha um nível para obter informações detalhadas:</label>
                <select class="w-25" id="cmbSelectLevelUser" required onchange="selectLevelUser()">
                  <option id="defaultSelectLevelUser">Selecione...</option>
                </select>
              </p>
            </fieldset>
          </form>
        </div>

        <div class="container-fluid">
          <!-- div dos gráficos de número de erros, tentativas e tempo por desafio de cada aluno -->
          <div class="row" id="challengersUserDiv">
            <div id="playerChallAttemptDiv" class="col sm4">
              <!-- Número de tentativas por desafio -->
            </div>
            <div id="playerChallErrosDiv" class="col sm4">
              <!-- Número de erros por desafio -->
            </div>
            <div id="playerChallTimeDiv" class="col sm4">
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
          <div id="legendUserDiv" class="col sm2">
            <!-- Legenda dos desafios -->
          </div>
        </div>
      </div>
    </div>

    <!-- container para atribuir licença de uso da API -->
    <div class="container" style="background-color: #f7f7f7; margin: 30px auto; border-radius: 5px">
      <div class="row">
        <p style="color: darkgray; margin: 10px; font-size: 12px; text-align: center; width: 100%">
          Os gráficos apresentados nesta página são modificações baseadas no trabalho criado e <a href="https://developers.google.com/terms/site-policies" target="_blank">compartilhado pelo Google</a>, usados de acordo com os termos descritos na <a href="https://creativecommons.org/licenses/by/3.0/" target="_blank">Licença de Atribuição</a> da <a href="https://creativecommons.org/licenses/by/3.0/" target="_blank">Creative Commons 3.0</a>.
        </p>
      </div>
    </div>

    <!-- JavaScript (Opcional) -->
    <!-- Inclusão do Popper.js, depois Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js"></script>
    <script type="text/javascript"  src="https://www.gstatic.com/charts/loader.js"></script>

    <!-- Aponta onde estão as funções javascript -->
    <g:javascript src="remar/stats/monta_graficos.js"></g:javascript>

    <script type="text/javascript">
      // Carregando a API de visualização e os pacotes de gráficos
      google.charts.load('current', {'packages':['corechart', 'table', 'line']});
      google.charts.setOnLoadCallback(pegaDados);
    </script>
  </body>
</html>