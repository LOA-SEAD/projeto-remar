<%@ page import="br.ufscar.sead.loa.respondasepuder.remar.Question" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Responda Se Puder</title>
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

</head>
<body>

<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        <i class="small material-icons left">grid_on</i>Tabela de Questões
    </p>
</div>


<div class="row">
    <div class="col s3 offset-s9">
        <input  type="text" id="SearchLabel" placeholder="Buscar"/>
    </div>
</div>

<table class="highlight" id="table" style="margin-top: -30px;">
    <thead>
    <tr>
        <th>Selecionar
            <div class="row" style="margin-bottom: -10px;">

                <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnCheckAll" onclick="check_all()"><i  class="material-icons">check_box_outline_blank</i></button>
                <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnUnCheckAll" onclick="uncheck_all()"><i  class="material-icons">done</i></button>
            </div>
        </th>
        <th>Nível <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
        <th>Pergunta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
        <th>Respostas <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
        <th>Alternativa Correta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
        <th>Ações <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${questionInstanceList}" status="i" var="questionInstance">
        <tr class="selectable_tr" style="cursor: pointer;"
            data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}" data-level="${fieldValue(bean: questionInstance, field: "level")}"
            data-checked="false">

            <td class="_not_editable">
                <input style="background-color: #727272" id="checkbox-${questionInstance.id}" class="filled-in" type="checkbox">
                <label for="checkbox-${questionInstance.id}"></label>
            </td>

            <td class="level"  >${fieldValue(bean: questionInstance, field: "level")}</td>

            <td  >${fieldValue(bean: questionInstance, field: "title")}</td>

            <td >${fieldValue(bean: questionInstance, field: "answer")}</td>

            <td  >${questionInstance.correctAnswer}</td>

            <td> <i onclick="changeEditQuestion(${i})" style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil modal-trigger" data-target="editModal${i}" data-model="${questionInstance.id}"></i> <i style="color: #7d8fff " class="fa fa-trash-o" onclick="_delete($(this.closest('tr')))" > </i></td>



        </tr>


    </g:each>
    </tbody>
</table>

<div class="row">
    <div class="col s2">
        <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="submitButton">Enviar
            <i class="material-icons">send</i>
        </button>
    </div>
    <div class="col s1 offset-s8">
        <a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar questão"><i class="material-icons">add</i></a>
    </div>
    <div class="col s1">
        <a data-target="uploadModal" class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped" data-tooltip="Upload arquivo .csv"><i
                class="material-icons">file_upload</i></a>
    </div>
</div>

<!-- Modal Structure -->


<!-- Modal Structure -->

</body>
</html>

%{--<html>--}%
%{--<head>--}%
    %{--<meta name="layout" content="main">--}%
    %{--<title>Responda Se Puder</title>--}%
%{--</head>--}%

%{--<body>--}%
     %{--<div class="container">--}%
         %{--<table>--}%
             %{--<thead>--}%
             %{--<tr>--}%
                 %{--<g:sortableColumn property="title" title="${message(code: 'question.title.label', default: 'Title')}"/>--}%

                 %{--<g:sortableColumn property="answer" title="${message(code: 'question.answer.label', default: 'Answer')}"/>--}%

                 %{--<g:sortableColumn property="correctAnswer"--}%
                                   %{--title="${message(code: 'question.correctAnswer.label', default: 'Correct Answer')}"/>--}%

                 %{--<g:sortableColumn property="tip" title="${message(code: 'question.tip.label', default: 'Tip')}"/>--}%


                 %{--<g:sortableColumn property="ownerId"--}%
                                   %{--title="${message(code: 'question.ownerId.label', default: 'Owner Id')}"/>--}%

                 %{--<g:sortableColumn property="taskId" title="${message(code: 'question.taskId.label', default: 'Task Id')}"/>--}%



             %{--</tr>--}%
             %{--</thead>--}%
             %{--<tbody>--}%
             %{--<g:each in="${questionInstanceList}" status="i" var="questionInstance">--}%
                 %{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%

                     %{--<td>${fieldValue(bean: questionInstance, field: "title")}</td>--}%


                     %{--<td><g:link action="show"--}%
                                 %{--id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "answer")}</g:link></td>--}%

                     %{--<td>${fieldValue(bean: questionInstance, field: "correctAnswer")}</td>--}%

                     %{--<td>${fieldValue(bean: questionInstance, field: "tip")}</td>--}%

                     %{--<td>${fieldValue(bean: questionInstance, field: "ownerId")}</td>--}%

                     %{--<td>${fieldValue(bean: questionInstance, field: "taskId")}</td>--}%



                 %{--</tr>--}%
             %{--</g:each>--}%
             %{--</tbody>--}%
         %{--</table>--}%
    %{--</div>--}%


%{--</body>--}%
%{--</html>--}%
