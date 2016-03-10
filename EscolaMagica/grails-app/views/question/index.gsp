<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="questions.js" />
        <g:javascript src="../assets/js/jquery.min.js"/>
        <g:javascript src="../js/materialize.min.js"/>


        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="../css/materialize.css"  media="screen,projection"/>
        <link rel="stylesheet" type="text/css" href="../css/style.css" >
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
            <tr class="selectable_tr" style="cursor: pointer;"
                data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}" data-level="${fieldValue(bean: questionInstance, field: "level")}"
                data-checked="false"
            >

                <td class="_not_editable"> <input style="background-color: #727272" id="checklabel" class="filled-in" type="checkbox"> <label for="checklabel"></label></td>

                <td class="level"  >${fieldValue(bean: questionInstance, field: "level")}</td>

                <td  >${fieldValue(bean: questionInstance, field: "title")}</td>

                <td >${fieldValue(bean: questionInstance, field: "answers")}</td>

                <td  >${questionInstance.answers[questionInstance.correctAnswer]} (${questionInstance.correctAnswer + 1}ª Alternativa)</td>

                <td> <i onclick="changeEditQuestion(${i})" style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil modal-trigger" data-target="editModal${i}" data-model="${questionInstance.id}"></i> <i style="color: #7d8fff " class="fa fa-trash-o" onclick="_delete($(this.closest('tr')))" > </i></td>

                <!-- Modal Structure -->
                <div id="editModal${i}" class="modal">
                    <div class="modal-content">
                        <div class="row">
                            <div class="col s12"></div>
                                <h4>Editar Questão</h4>
                        </div>
                        <div class="row">
                            <div class="col s12">
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
                                <g:form url="[resource:questionInstance, action:'update']" method="PUT" >
                                    <g:hiddenField name="version" value="${questionInstance?.version}" />
                                    <g:render template="form" model="[ questionInstance: questionInstance, count:i]"/>
                                    <g:actionSubmit class="save btn btn-success btn-lg my-orange" action="update" value="${message(code: 'default.button.update.label', default: 'Salvar')}"/>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>

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
            <a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange"><i class="material-icons">add</i></a>
        </div>
        <div class="col s1">
            <a data-target="uploadModal" class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger"><i
                    class="material-icons">file_upload</i></a>
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
        </div>
    </div>






    <script type="text/javascript">
            function _delete(tr) {
                if(confirm("Você tem certeza que deseja excluir esta questão?")) {
                    var tds = $(tr).find("td");
                    var url = location.origin + '/escolamagica/question/delete/' + $(tr).attr('data-id');
                    var data = {_method: 'DELETE'};

                    $.ajax({
                                type: 'GET',
                                data: data,
                                url: url,
                                success: function (data) {
                                    $(tr).remove();
                                    //uncheck_all();
                                    //window.location.reload();
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                }
                            }
                    );


                }
            }

            function check_all(){
                console.log("selecionar todas");
                var CheckAll = document.getElementById("BtnCheckAll");
                var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
                $(".filled-in:visible").prop('checked', 'checked');


                for (var i = 0; i < trs.length; i++) {
                    if($(trs[i]).is(':visible')) {
                        $(trs[i]).attr('data-checked', "true");
                    }
                }

                $('#BtnCheckAll').hide();
                $('#BtnUnCheckAll').show();

            }

            function uncheck_all(){
                console.log("remover todas");
                var UnCheckAll = document.getElementById("BtnUnCheckAll");
                var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
                $(".filled-in:visible").prop('checked', false);


                for (var i = 0; i < trs.length; i++) {
                    if($(trs[i]).is(':visible')) {
                        $(trs[i]).attr('data-checked', "false");
                    }
                }

                $('#BtnUnCheckAll').hide();
                $('#BtnCheckAll').show();

            }

            function changeEditQuestion(variable){
                var editQuestion = document.getElementById("editQuestionLabel");
                editQuestion.value=variable;

                console.log(editQuestion.value);
                //console.log(variable);

            }

    </script>

    </body>
</html>
