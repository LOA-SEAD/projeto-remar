
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="../css/materialize.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="layout" content="main">
        <meta charset="utf-8">
        <g:javascript src="editableTable.js"/>
        <g:javascript src="scriptTable.js"/>
        %{--<g:javascript src="../assets/js/jquery.min.js"/>--}%
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>

        %{--<g:javascript src="../assets/js/bootstrap.min.js"/>--}%
        %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'stylesheet.css')}" />--}%
        %{--<link rel="stylesheet" href="${resource(dir: 'assets/css', file: 'bootstrap.min.css')}" />--}%
        %{--<link rel="stylesheet" href="${resource(dir: 'assets/css', file: 'modal.css')}" />--}%
        <meta property="user-name" content="${userName}"/>
        <meta property="user-id" content="${userId}"/>

        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">


    </head>
    <body>
        <nav class="layout-top-nav">
            <div class="nav-wrapper">
                <h3 style="margin: 10px;">Tabela de Questões</h3>
            </div>
        </nav>

    <div class="row">
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
                %{--<input class="filled-in" type="checkbox" id="BtnCheckAll" onclick="check_all()"> <label for="BtnCheckAll"></label>--}%
                %{--<input class="filled-in" type="checkbox" id="BtnUnCheckAll" onclick="uncheck_all()"> <label for="BtnUnCheckAll"></label>--}%

                <button style="margin-left: 3px;" class="btn-floating" id="BtnCheckAll" onclick="check_all()"><i  class="material-icons">check_box_outline_blank</i></button>
                <button style="margin-left: 3px;" class="btn-floating" id="BtnUnCheckAll" onclick="uncheck_all()"><i  class="material-icons">done</i></button>
            </div>
            </th>
            <th>Pergunta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
            <th>Resposta <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
            <th>Tema <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
            <th>Autor <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
            <th>Ação <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${questionInstanceList}" status="i" var="questionInstance">
            <tr class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
                data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
                data-checked="false"
            >
                <g:if test="${questionInstance.author == userName }">

                    <td class="_not_editable"> <input class="filled-in" type="checkbox"> <label></label></td>

                    <td name="question_label" >${fieldValue(bean: questionInstance, field: "statement")}</td>

                    <td>${fieldValue(bean: questionInstance, field: "answer")}</td>

                    <td name="theme" id="theme">${fieldValue(bean: questionInstance, field: "category")}</td>

                    <td>${fieldValue(bean: questionInstance, field: "author")}</td>

                    <td> <i onclick="changeEditQuestion(${i})" style="color: #26A69A; margin-right:10px;" class="fa fa-pencil modal-trigger" data-target="editModal${i}" data-model="${questionInstance.id}"></i> <i style="color: #26A69A;" class="fa fa-trash-o" onclick="_delete($(this.closest('tr')))" ></i></td>

                    <!-- Modal Structure -->
                    <div id="editModal${i}" class="modal">
                        <div class="modal-content">
                            <h4>Editar Questão</h4>
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
                                <g:form url="[resource:questionInstance, action:'update']" method="PUT" >
                                    <g:hiddenField name="version" value="${questionInstance?.version}" />
                                    <g:render template="form" model="[ questionInstance: questionInstance]"/>
                                    <g:actionSubmit class="save btn btn-success btn-lg" action="update" value="${message(code: 'default.button.update.label', default: 'Salvar')}"/>
                                </g:form>
                            </div>
                        </div>
                    </div>

                </g:if>
                <g:else>
                    <td class="_not_editable"> <input class="filled-in" type="checkbox"> <label></label> </td>

                    <td name="question_label" data-questionId="${questionInstance.id}" >${fieldValue(bean: questionInstance, field: "statement")}</td>

                    <td  >${fieldValue(bean: questionInstance, field: "answer")}</td>

                    <td name="theme" id="theme" >${fieldValue(bean: questionInstance, field: "category")}</td>

                    <td >${fieldValue(bean: questionInstance, field: "author")}</td>

                    <td > <i style="color: lightslategray; margin-right:10px;" class="fa fa-pencil"></i>  <i style="color: lightslategray;" class="fa fa-trash-o"></i> </td>

                </g:else>
            </tr>
        </g:each>
        </tbody>
    </table>

    <input type="hidden" id="editQuestionLabel" value=""> <label for="editQuestionLabel"></label>

    <div class="row">
        <div class="col s2">
            <button class="btn waves-effect waves-light" type="submit" name="save" id="save">Enviar
                <i class="material-icons right">send</i>
            </button>
        </div>
        <div class="col s1 offset-s9">
            <a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger"><i class="material-icons">add</i></a>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="createModal" class="modal">
        <div class="modal-content">
            <h4>Criar Questão</h4>
            <div class="row">
                    <g:form url="[resource:questionInstance, action:'newQuestion']" >
                            <g:render template="form"/>
                        <br />
                            <g:submitButton name="create" class="btn btn-success btn-lg" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </g:form>
            </div>
        </div>
    </div>


    <!-- Modal Structure -->
    <div id="infoModal" class="modal">
        <div class="modal-content">
            <div id="totalQuestion">

            </div>
        </div>
        <div class="modal-footer">
            <button class="btn waves-effect waves-light modal-close">Entendi</button>
        </div>
    </div>





    <script type="text/javascript" src="../js/materialize.min.js"></script>
    <script type="text/javascript">

            function changeEditQuestion(variable){
            var editQuestion = document.getElementById("editQuestionLabel");
            editQuestion.value=variable;

            console.log(editQuestion.value);
            //console.log(variable);

        }

    </script>

    </body>
</html>
