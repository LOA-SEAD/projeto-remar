<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="/forca/css/materialize.css" media="screen,projection"/>
    <link rel="stylesheet" type="text/css" href="/forca/css/style.css">

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="utf-8">
    <g:javascript src="editableTable.js"/>
    <g:javascript src="scriptTable.js"/>
    <g:javascript src="validate.js"/>
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>

    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>

</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        <i class="small material-icons left">grid_on</i>Forca - Tabela de Questões
    </p>
</div>


<div class="row">
    <div class="col s3 offset-s9">
        <input type="text" id="SearchLabel" placeholder="Buscar"/>
    </div>
</div>

<table class="highlight" id="table" style="margin-top: -30px;">
    <thead>
    <tr>
        <th>Selecionar %{--<div class="row">--}%
            <div class="row" style="margin-bottom: -10px;">
                %{--<input class="filled-in" type="checkbox" id="BtnCheckAll" onclick="check_all()"> <label for="BtnCheckAll"></label>--}%
                %{--<input class="filled-in" type="checkbox" id="BtnUnCheckAll" onclick="uncheck_all()"> <label for="BtnUnCheckAll"></label>--}%

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
                                                                        style="visibility: hidden"></button></div></th>
        <th>Autor <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                         style="visibility: hidden"></button></div></th>
        <th>Ação <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                        style="visibility: hidden"></button></div></th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${questionInstanceList}" status="i" var="questionInstance">
        <tr id="tr${questionInstance.id}" class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
            data-id="${fieldValue(bean: questionInstance, field: "id")}"
            data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
            data-checked="false">
            <g:if test="${questionInstance.author == userName}">

                <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                <td name="question_label">${fieldValue(bean: questionInstance, field: "statement")}</td>

                <td>${fieldValue(bean: questionInstance, field: "answer")}</td>

                <td name="theme" id="theme">${fieldValue(bean: questionInstance, field: "category")}</td>

                <td>${fieldValue(bean: questionInstance, field: "author")}</td>

                <td><i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff; margin-right:10px;"
                       class="fa fa-pencil"
                       ></i></td>


            </g:if>
            <g:else>
                <td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

                <td name="question_label"
                    data-questionId="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "statement")}</td>

                <td>${fieldValue(bean: questionInstance, field: "answer")}</td>

                <td name="theme" id="theme">${fieldValue(bean: questionInstance, field: "category")}</td>

                <td>${fieldValue(bean: questionInstance, field: "author")}</td>

                <td><i style="color: gray; margin-right:10px;" class="fa fa-pencil"></i>
                </td>
            </g:else>
        </tr>
    </g:each>
    </tbody>
</table>

<input type="hidden" id="editQuestionLabel" value=""> <label for="editQuestionLabel"></label>

<div class="row">
    <div class="col s2">
        <button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="save">Enviar
            <i class="material-icons right">send</i>
        </button>
    </div>

    <div class="col s1 offset-s6">
        <a data-target="createModal" name="create"
           class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar questão"><i
                class="material-icons">add</i></a>
    </div>

    <div class="col s1 m1 l1">
        <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir questão" ><i class="fa fa-trash"></i></a>
    </div>

    <div class="col s1">
        <a data-target="uploadModal"  class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped" data-tooltip="Upload de arquivo .csv"><i
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

                <h4>Criar Questão <i class="material-icons tooltipped" data-position="right" data-delay="30" data-tooltip="Respostas não devem possuir números nem caracteres especiais.">info</i></h4>


        <div class="row">
            <g:form url="[resource: questionInstance, action: 'newQuestion']">
                <g:render template="form"/>
                <br/>
                <g:submitButton name="create" class="btn btn-success btn-lg my-orange"
                                value="${message(code: 'default.button.create.label', default: 'Create')}"/>
            </g:form>
        </div>
    </div>
</div>

<!-- Modal Structure -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <h4>Editar Questão</h4>
        <g:form url="[resource: questionInstance, action: 'update']" method="PUT">

                <input id="editVersion" name="version" required="" value="" type="hidden">
                <input type="hidden" id="questionID" name="questionID">


            <div class="input-field col s12">
                <input id="editStatement" name="statement" required="" value="" type="text" class="validate" maxlength="150">
                <label id="statementLabel" for="editStatement">Pergunta</label>
            </div>
            <div class="input-field col s12">
                <input id="editAnswer" name="answer" required="" value="" type="text" class="validate"  onkeypress="validate(event)" maxlength="48">
                <label id="answerLabel" for="editAnswer">Resposta</label>
            </div>
            <div class="input-field col s12">
                <input id="editCategory" name="category" required="" value="" type="text" class="validate">
                <label id="categoryLabel" for="editCategory">Tema</label>
            </div>

            <div class="input-field col s12" style="display: none;">
                <input id="editAuthor" name="author" required="" readonly="readonly" value="" type="text" class="validate">
                <label id="authorLabel" for="editAuthor">Autor</label>
            </div>

            <g:actionSubmit class="save btn btn-success btn-lg my-orange" action="update"
                            value="${message(code: 'default.button.update.label', default: 'Salvar')}"/>
        </g:form>
    </div>
</div>


<!-- Modal Structure -->
<div id="infoModal" class="modal">
    <div class="modal-content">
        <div id="totalQuestion">

        </div>
    </div>

    <div class="modal-footer">
        <button class="btn waves-effect waves-light modal-close my-orange">Entendi</button>
    </div>
</div>

<div id="uploadModal" class="modal">
    <div class="modal-content">
        <h4>Enviar arquivo .csv</h4>
        <br>
        <div class="row">
            <g:uploadForm action="generateQuestions">

                <div class="file-field input-field">
                    <div class="btn my-orange">
                        <span>Arquivo</span>
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
            <div class="col s6">
                <ol>
                    <li>O separador do arquivo .csv deve ser <b> ';' (ponto e vírgula)</b>  </li>
                    <li>O arquivo deve ser composto apenas por <b>dados</b></li>
                    <li>O arquivo deve representar a estrutura da tabela ao lado</li>
                </ol>
                <ul>
                    <li><a href="/forca/samples/exemploForca.csv" >Download do arquivo exemplo</a></li>
                </ul>
            </div>
            <div class="col s6">
                <table class="center">
                    <thead>
                    <tr>
                        <th>Pergunta</th>
                        <th>Resposta</th>
                        <th>Tema</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Pergunta 1</td>
                        <td>Resposta 1</td>
                        <td>Tema 1</td>
                    </tr>
                    <tr>
                        <td>Pergunta 2</td>
                        <td>Resposta 2</td>
                        <td>Tema 2</td>
                    </tr>
                    <tr>
                        <td>Pergunta 3</td>
                        <td>Resposta 3</td>
                        <td>Tema 3</td>
                    </tr>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>





<script type="text/javascript" src="/forca/js/materialize.min.js"></script>
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
