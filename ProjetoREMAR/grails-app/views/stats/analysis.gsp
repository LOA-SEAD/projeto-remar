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

    <!-- Aponta onde estão as funções javascript -->
    <g:javascript src="remar/stats/monta_graficos.js"></g:javascript>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <!-- script para chamar os construtores dos gráficos -->
    <script type="text/javascript">
      // Carregando a API de visualização e os pacotes de gráficos
      google.charts.load('current', {'packages':['corechart', 'table', 'line']});
    </script>

    <title>REMAR - Dashaboard</title>
  </head>
  <body style="overflow-x: hidden">
    <!-- container do título e botão voltar -->
    <div class="container-fluid">
      <div class="row">
        <div class="col s12 m1 l1">
          <p class="center-align"><a href="javascript:history.go(-1)"><< voltar</a></p>
        </div>
        <div class="col s12 m10 l10">
          <h2 class="center-align" style="margin:0">ESTATÍSTICAS</h2>
        </div>
        <div class="col s12 m1 l1">
          <p class="center-align">
            <a href="#" onclick="window.location.replace('http://alfa.remar.online/group/stats/' + grupo2 + '?exp=' + jogo2)" target="_self" alt="Versão em tabela">versão em tabela <img src="/images/tabela.png" alt="versão em tabela" width=11 height=11 /></a>
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
        <div class="row center-align">
          <div id="rankingDiv" class="col s12 m4 l4">
            <!-- Ranking de Pontuação -->
          </div>
          <div id="conclusionTimeDiv" class="col s12 m8 l8">
            <!-- Tempo de conclusão do jogo -->
          </div>
        </div>
      </div>

      <!-- container dos gráficos de número de alunos por nível e número de tentativas por nível -->
      <div class="container-fluid">
        <div class="row center-align">
          <div id="usersLevelsDiv" class="col s12 m4 l4">
            <!-- Número de alunos por nível -->
          </div>
          <div id="levelsAttemptsDiv" class="col s12 m4 l4">
            <!-- Número de tentativas por nível -->
          </div>
          <div id="avarageLevelTimeDiv" class="col s12 m4 l4">
            <!-- Tempo médio de conlusão por nível -->
          </div>
        </div>
      </div>

      <div style="border: 1px solid; border-color: gray; border-radius: 5px; margin-top: 5px; margin-right: 5px; margin-left: 5px">
        <!-- container da seleção de nível para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de níveis -->
          <form class="input-field col s12">
            <p class="center-align">
              <label for="cmbSelectLevel" style="font-size: 12pt">Escolha um nível para obter informações detalhadas:</label>
              <select id="cmbSelectLevel" style="display: inline; width: 300px" class="browser-default" required onchange="selectLevel()">
                <option id="defaultSelectLevel" disabled selected>Selecione...</option>
              </select>
            </p>
          </form>
        </div>

        <!-- container dos gráficos de número de erros, tentativas e tempo por desafio -->
        <div class="container-fluid" style="margin-bottom: -40px">
          <div class="row center-align" id="challengersDiv">
            <div id="levelDetailDiv" class="col s12 m5 l5" style="border-right-color: gray; border-right: 1px dotted">
            <!-- Número de alunos por nível, suas tentativas não concluídas e concluídas -->
            </div>
            <div class="col s7">
              <div class="row center-alignter">
                <div id="challengesErrorsDiv" class="col s12 m7 l7" style="margin-left: 25px; margin-right: -25px">
                <!-- Número de erros por desafio -->
                </div>
                <div id="challengesAttemptsDiv" class="col s12 m5 l5">
                  <!-- Número de tentativas por desafio -->
                </div>
              </div>
              <div class="row center-align">
                <div id="avarageChallengeTimeDiv" class="col s12 m12 l12">
                  <!-- Tempo de conlusão por desafio -->
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- container da seleção de desafio para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de desafios -->
          <form class="input-field col s12 m12 l12">
            <p class="center-align">
              <label for="cmbSelectChallenge" style="font-size: 12pt">Escolha um desafio para obter informações detalhadas:</label>
              <select id="cmbSelectChallenge" style="display: inline; width: 300px" class="browser-default" required onchange="selectChallenge()">
                <option id="defaultSelectChallenge" disabled selected>Selecione...</option>
              </select>
            </p>
          </form>
        </div>

        <!-- container dos gráficos de frequencia de escolhas por desafio -->
        <div class="container-fluid" style="margin-top: 10px">
          <div class="row center-align valign-wrapper" id="choicesChallengesDiv" style="margin-bottom: 10px">
            <div id="challengeDetailDiv" class="col s12 m5 l5" style="border-right-color: gray; border-right: 1px dotted">
              <!-- Número de alunos por desafio, quantos erros e acertos tiveram -->
            </div>
            <div id="frequenceChoiceDiv" class="col s12 m7 l7">
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
          <div id="legendDiv" class="col s12 m12 l12 center-align valign-wrapper">
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
        <div class="row center-alignenter">
          <div id="playerLevelAttemptDiv" class="col s12 m6 l6">
            <!-- Número de tentativas por nível -->
          </div>
          <div id="playerTimeLevelDiv" class="col s12 m6 l6">
            <!-- tempo de conclusão por nível -->
          </div>
        </div>
      </div>

      <div style="border: 1px solid; border-color: gray; border-radius: 5px; margin-top: 5px; margin-right: 5px; margin-left: 5px">
        <!-- container da seleção de nível para filtro -->
        <div class="container-fluid" style="justify-content: center; margin-top: 10px">
          <!-- inicio do formulário de níveis -->
          <form class="input-field col s12 m12 l12">
            <p class="center-align">
              <label for="defaultSelectLevelUser" style="font-size: 12pt">Escolha um nível para obter informações detalhadas:</label>
              <select style="width: 300px; display: inline;" class="browser-default" id="cmbSelectLevelUser" required onchange="selectLevelUser()">
                <option id="defaultSelectLevelUser" disabled selected>Selecione...</option>
              </select>
            </p>
          </form>
        </div>

        <div class="container-fluid">
          <!-- div dos gráficos de número de erros, tentativas e tempo por desafio de cada aluno -->
          <div class="row center-align valign-wrapper" id="challengersUserDiv">
            <div id="playerChallAttemptDiv" class="col s12 m4 l4">
              <!-- Número de tentativas por desafio -->
            </div>
            <div id="playerChallErrosDiv" class="col s12 m4 l4">
              <!-- Número de erros por desafio -->
            </div>
            <div id="playerChallTimeDiv" class="col s12 m4 l4">
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
        <div class="row center-align">
          <div id="legendUserDiv" class="col s12 m12 l12 center-align valign-wrapper">
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