<%@ page import="br.ufscar.sead.loa.forcaacessivel.remar.Question" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="/forca_acessivel/css/materialize.css" media="screen,projection"/>
    <link rel="stylesheet" type="text/css" href="/forca_acessivel/css/question.css">

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="utf-8">


    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>

</head>

<body>
<!-- Cabeçalho da página -->
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        Forca - Tabela de Questões
    </p>
</div>

<!-- Caixa de busca -->
<div class="row">
    <div class="col s3 offset-s9">
        <input type="text" id="SearchLabel" class="remar-input" placeholder="Buscar"/>
    </div>
</div>

<!-- Tabela de questões com a opção de editar de acordo com o usuário -->
<table class="highlight" id="table" style="margin-top: -30px;">
    <!-- Cabeçalho da tabela com os índices de cada coluna-->
    <thead>
    <tr>
        <th>Selecionar
            <!-- Definição dos botões de "check all" e "uncheck all" da lista de seleção (coluna "Selecionar") -->
            <div class="row" style="margin-bottom: -10px;">

                <button style="margin-left: 3px; background-color: #795548;" class="btn-floating" id="BtnCheckAll"
                        onclick="check_all()"><i class="material-icons">check_box_outline_blank</i></button>
                <button style="margin-left: 3px; background-color: #795548;" class="btn-floating" id="BtnUnCheckAll"
                        onclick="uncheck_all()"><i class="material-icons">done</i></button>
            </div>
        </th>
        <th>Pergunta <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                            style="visibility: hidden"></button></div>
        </th>
        <th>Resposta <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                            style="visibility: hidden"></button></div>
        </th>
        <th>Tema <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div>
        </th>
        <th>Ação <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div>
        </th>
    </tr>
    </thead>

    <!-- Corpo da tabela com as questões (as questões que não são do usuário da sessão não são editáveis) -->
    <tbody>
        <!-- Preenchimento das linhas da tabela -->
        <!-- Para cada item da lista de questões, cria uma linha na tabela -->
        <g:each in="${questionInstanceList}" status="i" var="questionInstance">

        <tr id="tr${questionInstance.id}" class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
            data-id="${fieldValue(bean: questionInstance, field: "id")}"
            data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
            data-checked="false">

            <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label>
            </td>

            <td name="question_label">
                ${fieldValue(bean: questionInstance, field: "statement")}
                <audio controls>
                    <source src="data/${questionInstance.ownerId}/audios/${questionInstance.id}/statement.mp3" type="audio/mpeg">
                    Your browser does not support the audio tag.
                </audio>
            </td>


            <td>${fieldValue(bean: questionInstance, field: "answer")}
                <audio controls>
                    <source src="data/${questionInstance.ownerId}/audios/${questionInstance.id}/answer.mp3" type="audio/mpeg">
                    Your browser does not support the audio tag.
                </audio>
            </td>

            <td name="theme" id="theme">${fieldValue(bean: questionInstance, field: "category")}
            </td>

            <g:if test="${questionInstance.author == userName}">
                <td>
                    <a href="${createLink(action: "edit")}/${questionInstance.id}">
                        <i style="color: #7d8fff; margin-right:10px;" class="fa fa-pencil"></i>
                    </a>
                </td>
            </g:if>
            <g:else>
                <td>
                    <i style="color: gray; margin-right:10px;" class="fa fa-pencil"></i>
                </td>
            </g:else>
        </tr>

        </g:each>
    </tbody>
</table>





<!-- edit question label? -->
<!-- pra que serve? -->
<input type="hidden" id="editQuestionLabel" value=""> <label for="editQuestionLabel"></label>

<!-- Botões da base da tabela -->
<div class="row" style="margin-top:2em;">
    <!-- Botão de submissão; submete as perguntas selecionadas -->
    <div class="col s2">
        <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="save">Enviar</button>
    </div>


    <!-- Botão de criação de perguntas; chama NOVA PÁGINA para criação da pergunta -->
    <div class="col s1 offset-s8">
        <a href="${createLink(action: "create", controller: "question")}"
           class="btn-floating btn-success btn-large waves-effect waves-light remar-orange tooltipped" action="create" data-tooltip="Criar novo par">
            <i class="material-icons">add</i>
        </a>
    </div>


    <!-- Botão de deleção; deleta as perguntas selecionadas -->
    <div class="col s1 m1 l1">
          <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped"
             data-tooltip="Exluir questão" >
              <i class="material-icons">delete</i>
          </a>
    </div>

    <!-- A versão acessível não contem importação e exportação
    // Botão para importação de perguntas (arquivo .csv); envia um arquivo para submeter perguntas
    <div class="col s1">
        <a data-target="uploadModal" class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped"
           data-tooltip="Upload de arquivo .csv">
            <i class="material-icons">file_upload</i>
        </a>
    </div>

    // Botão para exportação de perguntas (arquivo .csv)
    <div class="col s1">
        <a class="btn-floating btn-large waves-effect waves-light my-orange tooltipped"
           data-tooltip="Exportar questões para .csv">
            <i class="material-icons" onclick="exportQuestions()">file_download</i>
        </a>
    </div>
    -->
</div>



<!-- Javascript -->
<g:javascript src="editableTable.js"/>
<g:javascript src="scriptTable.js"/>
<g:javascript src="validate.js"/>
<g:javascript src="question.js"/>
<script type="text/javascript" src="/forca_acessivel/js/materialize.min.js"></script>
<script type="text/javascript">

    function changeEditQuestion(variable) {
        var editQuestion = document.getElementById("editQuestionLabel");
        editQuestion.value = variable;

        console.log(editQuestion.value);
        //console.log(variable);
    }
</script>
</body>
</html>

