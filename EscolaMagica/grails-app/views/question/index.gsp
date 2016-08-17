<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="questions.js" />
        <g:javascript src="../assets/js/jquery.min.js"/>
        <g:javascript src="../js/materialize.min.js"/>
        <g:javascript src="iframeResizer.contentWindow.min.js"/>


        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="/escolamagica/css/materialize.css"  media="screen,projection"/>
        <link rel="stylesheet" type="text/css" href="/escolamagica/css/style.css" >
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    </head>
    <body>

    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            <i class="small material-icons left">grid_on</i>Escola Mágica - Tabela de Questões
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
            <th>Selecionar %{--<div class="row">--}%
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
            <tr id="tr${questionInstance.id}" class="selectable_tr" style="cursor: pointer;"
                data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}" data-level="${fieldValue(bean: questionInstance, field: "level")}"
                data-checked="false">

                <td class="_not_editable">
                    <input style="background-color: #727272" id="checkbox-${questionInstance.id}" class="filled-in" type="checkbox">
                    <label for="checkbox-${questionInstance.id}"></label>
                </td>

                <td class="level"  >${fieldValue(bean: questionInstance, field: "level")}</td>

                <td  >${fieldValue(bean: questionInstance, field: "title")}</td>

                <td >${fieldValue(bean: questionInstance, field: "answers")}</td>

                <td  >${questionInstance.answers[questionInstance.correctAnswer]} (${questionInstance.correctAnswer + 1}ª Alternativa)</td>

                <td> <i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil" ></i></td>

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
        <div class="col s1 offset-s6">
            <a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar questão"><i class="material-icons">add</i></a>
        </div>
        <div class="col s1 m1 l1">
            <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir questão" ><i class="material-icons">delete</i></a>
        </div>
        <div class="col s1">
            <a data-target="uploadModal" class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped" data-tooltip="Upload arquivo .csv"><i
                    class="material-icons">file_upload</i></a>
        </div>
        <div class="col s1">
            <a class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exportar questões para .csv"><i
                    class="material-icons" onclick="exportQuestions()">file_download</i></a>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="createModal" class="modal">
        <div class="modal-content">
            <h4>Criar Questão</h4>
            <div class="row">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${questionInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${questionInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form action="save" resource="${questionInstance}">

                    <div class="row">
                        <div class="input-field col s12">
                            <label for="title">Pergunta</label>
                            <input id="title" name="title" required="" value="${questionInstance?.title}" type="text" class="validate">
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s9">
                            <label for="answers[0]">Alternativa 1</label>
                            <input type="text" class="validate" id="answers[0]" name="answers[0]" required="" value="${questionInstance?.answers}"/>
                        </div>
                        <div class="col s2">
                            <input type="radio" id="radio0" name="correctAnswer" value="0" />
                            <label for="radio0">Alternativa correta</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s9">
                            <label for="answers[1]">Alternativa 2</label>
                            <input type="text" class="validate" id="answers[1]" name="answers[1]" required="" value="${questionInstance?.answers}"/>
                        </div>
                        <div class="col s2">
                            <input type="radio" id="radio1" name="correctAnswer" value="1" /> <label for="radio1">Alternativa correta</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s9">
                            <label for="answers[2]">Alternativa 3</label>
                            <input type="text" class="validate" id="answers[2]" name="answers[2]" required="" value="${questionInstance?.answers}"/>
                        </div>
                        <div class="col s2">
                            <input type="radio" id="radio2" name="correctAnswer" value="2" /> <label for="radio2">Alternativa correta</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s9">
                            <label for="answers[3]">Alternativa 4</label>
                            <input type="text" class="form-control" id="answers[3]" name="answers[3]" required="" value="${questionInstance?.answers}"/>
                        </div>
                        <div class="col s2">
                            <input type="radio" id="radio3" name="correctAnswer" value="3" /> <label for="radio3">Alternativa correta</label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col s2 offset-s3">
                            <input type="radio" id="level1" name="level" value="1" />
                            <label for="level1">Nível 1</label>

                        </div>

                        <div class="col s2">
                            <input type="radio" id="level2" name="level" value="2" />
                            <label for="level2">Nível 2</label>
                        </div>

                        <div class="col s2">
                            <input type="radio" id="level3" name="level" value="3" />
                            <label for="level3">Nível 3</label>
                        </div>
                    </div>


                    <g:submitButton name="create" class="btn btn-success btn-lg my-orange" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </g:form>
            </div>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="row">
                <div class="col s12"></div>
                <h4>Editar Questão</h4>
            </div>
            <div class="row">
                <div class="col s12">

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

                        <div class="row" id="levelRow">
                            <div class="col s2 offset-s3">
                                <input type="radio" id="editLevel1" name="level" value="1"  />
                                <label for="editLevel1">Nível 1</label>

                            </div>

                            <div class="col s2">
                                <input type="radio" id="editLevel2" name="level" value="2" />
                                <label for="editLevel2">Nível 2</label>
                            </div>

                            <input type="hidden" name="taskId"  value="1" >
                            <input type="hidden" id="questionID" name="questionID">


                            <div class="col s2">
                                <input type="radio" id="editLevel3" name="level" value="3" />
                                <label for="editLevel3">Nível 3</label>
                            </div>
                        </div>

                        <g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />

                    </g:form>
                </div>
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

    <div id="uploadModal" class="modal">
        <div class="modal-content">
            <h4>Enviar arquivo .csv</h4>
            <div class="row">
                <g:uploadForm action="generateQuestions">
                    <div class="file-field input-field">
                        <div class="btn my-orange">
                            <span>File</span>
                            <input type="file" accept="text/csv" id="csv" name="csv">
                        </div>
                        <div class="file-path-wrapper">
                            <input class="file-path validate" type="text">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s1 offset-s10">
                            <g:submitButton class="btn my-orange" name="csv" value="Enviar"/>
                        </div>
                    </div>
                </g:uploadForm>
            </div>

            <blockquote>Formatação do arquivo .csv</blockquote>
            <div class="row">
                <div class="col s12">
                    <ol>
                        <li>O separador do arquivo .csv deve ser <b> ';' (ponto e vírgula)</b>  </li>
                        <li>O arquivo deve ser composto apenas por <b>dados</b></li>
                        <li>O arquivo deve representar a estrutura da tabela de exemplo</li>
                    </ol>
                    <ul>
                        <li><a href="/escolamagica/samples/exemploEscolaMagica.csv">Download do arquivo exemplo</a></li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <table class="center" style="font-size: 12px;">
                        <thead>
                        <tr>
                            <th>Nível</th>
                            <th>Pergunta</th>
                            <th>Resposta1</th>
                            <th>Resposta2</th>
                            <th>Resposta3</th>
                            <th>Resposta4</th>
                            <th>Alternativa Correta</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td>Pergunta 1</td>
                            <td>Alternativa 1</td>
                            <td>Alternativa 2</td>
                            <td>Alternativa 3</td>
                            <td>Alternativa 4</td>
                            <td>1</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Pergunta 2</td>
                            <td>Alternativa 1</td>
                            <td>Alternativa 2</td>
                            <td>Alternativa 3</td>
                            <td>Alternativa 4</td>
                            <td>3</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Pergunta 3</td>
                            <td>Alternativa 1</td>
                            <td>Alternativa 2</td>
                            <td>Alternativa 3</td>
                            <td>Alternativa 4</td>
                            <td>4</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    </body>
</html>
