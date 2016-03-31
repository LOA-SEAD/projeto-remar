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
        <th>Dica<div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
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

            <td >${fieldValue(bean: questionInstance, field: "answers")}</td>

            <td  >${questionInstance.answers[questionInstance.correctAnswer]} (Alternativa ${questionInstance.correctAnswer + 1})</td>

            <td  >${questionInstance.tip}</td>


            <td> <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil " onclick="_edit($(this.closest('tr')))" ></i> <i style="color: #7d8fff " class="fa fa-trash-o" onclick="_delete($(this.closest('tr')))" > </i></td>



        </tr>


    </g:each>
    </tbody>
</table>

<div class="row">
    <div class="col s2">
        <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="submitButton" onclick="submit()">Enviar
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

<div id="editModal" class="modal">
    <div class="modal-content">
        <h4>Editar Questão</h4>
        <div class="row">
          <g:form method="post"  action="update" resource="${questionInstance}">
                <div class="row">
                    <div class="input-field col s12">
                        <label id="labelTitle" class="active" for="editTitle">Pergunta</label>
                        <input id="editTitle" name="title" required=""  type="text" class="validate">
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label id="labelAnswer1" class="active" for="editAnswers0">Alternativa 1</label>
                        <input type="text" class="validate" id="editAnswers0" name="answers1" required="" />
                    </div>
                    <div class="col s2">
                        <input type="radio" id="editRadio0" name="correctAnswer" value="0" />
                        <label for="editRadio0">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label id="labelAnswer2" class="active" for="editAnswers1">Alternativa 2</label>
                        <input type="text" class="validate" id="editAnswers1" name="answers2" required="" />
                    </div>
                    <div class="col s2">
                        <input type="radio" id="editRadio1" name="correctAnswer" value="1" /> <label for="editRadio1">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label id="labelAnswer3" class="active" for="editAnswers2">Alternativa 3</label>
                        <input type="text" class="validate" id="editAnswers2" name="answers3" required=""/>
                    </div>
                    <div class="col s2">
                        <input type="radio" id="editRadio2" name="correctAnswer" value="2" /> <label for="editRadio2">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label id="labelAnswer4" class="active" for="editAnswers3">Alternativa 4</label>
                        <input type="text" class="form-control" id="editAnswers3" name="answers4" required="" />
                    </div>
                    <div class="col s2">
                        <input type="radio" id="editRadio3" name="correctAnswer" value="3" /> <label for="editRadio3">Alternativa correta</label>
                    </div>
                </div>

              <div class="row">
                  <div class="input-field col s12">
                      <input class="active" type="text" name="tip" id="editTip" required />
                      <label id="labelTip" for="editTip">Dica</label>
                  </div>
              </div>

                <div class="row" id="levelRow">
                    <div class="col s2 offset-s3">
                        <input type="radio" id="editLevel1" name="level" value="1"  />
                        <label for="editLevel1">Nível Fácil</label>

                    </div>

                    <div class="col s2">
                        <input type="radio" id="editLevel2" name="level" value="2" />
                        <label for="editLevel2">Nível Médio</label>
                    </div>

                    <input type="hidden" name="ownerId"  value="2" >
                    <input type="hidden" name="taskId"  value="2" >
                    <input type="hidden" id="questionID" name="questionID">


                    <div class="col s2">
                        <input type="radio" id="editLevel3" name="level" value="3" />
                        <label for="editLevel3">Nível Difícil</label>
                    </div>
                </div>

                <g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
            </g:form>
        </div>
    </div>
</div>

<div id="createModal" class="modal">
    <div class="modal-content">
        <h4>Criar Questão</h4>
        <div class="row">
            <g:form action="save" resource="${questionInstance}">
                <div class="row">
                    <div class="input-field col s12">
                        <label for="title">Pergunta</label>
                        <input id="title" name="title" required=""  type="text" class="validate">
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label for="answers[0]">Alternativa 1</label>
                        <input type="text" class="validate" id="answers[0]" name="answers1" required="" />
                    </div>
                    <div class="col s2">
                        <input type="radio" id="radio0" name="correctAnswer" value="0" />
                        <label for="radio0">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label for="answers[1]">Alternativa 2</label>
                        <input type="text" class="validate" id="answers[1]" name="answers2" required="" />
                    </div>
                    <div class="col s2">
                        <input type="radio" id="radio1" name="correctAnswer" value="1" /> <label for="radio1">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label for="answers[2]">Alternativa 3</label>
                        <input type="text" class="validate" id="answers[2]" name="answers3" required=""/>
                    </div>
                    <div class="col s2">
                        <input type="radio" id="radio2" name="correctAnswer" value="2" /> <label for="radio2">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s9">
                        <label for="answers[3]">Alternativa 4</label>
                        <input type="text" class="form-control" id="answers[3]" name="answers4" required="" />
                    </div>
                    <div class="col s2">
                        <input type="radio" id="radio3" name="correctAnswer" value="3" /> <label for="radio3">Alternativa correta</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" name="tip" id="tip" required />
                        <label for="tip">Dica</label>
                    </div>
                </div>

                <div class="row">
                    <div class="col s2 offset-s3">
                        <input type="radio" id="level1" name="level" value="1" />
                        <label for="level1">Nível Fácil</label>

                    </div>

                    <div class="col s2">
                        <input type="radio" id="level2" name="level" value="2" />
                        <label for="level2">Nível Médio</label>
                    </div>

                    <input type="hidden" name="ownerId"  value="2" >
                    <input type="hidden" name="taskId"  value="2" >


                    <div class="col s2">
                        <input type="radio" id="level3" name="level" value="3" />
                        <label for="level3">Nível Difícil</label>
                    </div>
                </div>

                <g:submitButton name="create" class="btn btn-success btn-lg my-orange" value="Criar" />
            </g:form>
        </div>
    </div>
</div>

<!-- Modal Structure -->
<div id="infoModal" class="modal">
    <div class="modal-content">
        <div id="totalQuestion">
            Este é o modal Informações

        </div>
    </div>
    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Entendi</button>
    </div>
</div>



<script type="text/javascript" src="../js/questions.js"></script>
</body>
</html>

