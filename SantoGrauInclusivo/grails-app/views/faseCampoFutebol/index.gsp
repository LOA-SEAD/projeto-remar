<%@ page import="br.ufscar.sead.loa.santograuinclusivo.remar.QuestionFaseCampoFutebol" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Em Busca do Santo Grau</title>
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:external dir="css" file="faseCampoFutebol.css"/>
    <script type="text/javascript" src="/santograuinclusivo/js/faseCampoFutebol.js"></script>
</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        Fase Campo Futebol - Banco de Questões
    </p>
</div>

<div class="row">
    <div style=" margin-bottom: 10px; color:#333333">
        Fase do campo de futebol. São dois desafios compostos cada um por uma pergunta com uma única resposta.

        <div style="margin-top:20px;margin-bottom:15px;text-align:center">
            <img src="/santograuinclusivo/images/football.jpg"
                 style="width:400px"/>
        </div>

        Selecione no mínimo 2 desafios.
    </div>

    <div id="chooseQuestion" class="col s12 m12 l12">
        <br>

        <div class="row">
            <div class="col s6 m3 l3 offset-s6 offset-m9 offset-l9">
                <input type="text" id="SearchLabel" placeholder="Buscar"/>
            </div>
        </div>


        <!-- LISTAGEM -->
        <div class="row">
            <div class="col s12 m12 l12">
                <table class="highlight" id="table" style="margin-top: -30px;">
                    <thead>
                    <tr>
                        <th>Selecionar
                            <div class="row" style="margin-bottom: -10px;">
                                <button style="margin-left: 3px; background-color: #795548" class="btn-floating "
                                        id="BtnCheckAll" onclick="check_all()"><i
                                        class="material-icons">check_box_outline_blank</i></button>
                                <button style="margin-left: 3px; background-color: #795548" class="btn-floating "
                                        id="BtnUnCheckAll" onclick="uncheck_all()"><i class="material-icons">done</i>
                                </button>
                            </div>
                        </th>
                        <th id="titleLabel">Desafio <div class="row" style="margin-bottom: -10px;"><button
                                class="btn-floating" style="visibility: hidden"></button></div></th>
                        <th>Resposta <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                                            style="visibility: hidden"></button>
                        </div></th>
                        <th>Ações <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                                         style="visibility: hidden"></button>
                        </div></th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${questionFaseCampoFutebolInstanceList}" status="i" var="faseCampoFutebolInstance">
                        <tr id="tr${faseCampoFutebolInstance.id}" class="selectable_tr" style="cursor: pointer;"
                            data-id="${faseCampoFutebolInstance.id}"
                            data-owner-id="${faseCampoFutebolInstance.ownerId}"
                            data-checked="false">
                            <td class="_not_editable">
                                <input style="background-color: #727272" id="checkbox-${faseCampoFutebolInstance.id}"
                                       class="filled-in" type="checkbox">
                                <label for="checkbox-${faseCampoFutebolInstance.id}"></label>
                            </td>
                            <td>${fieldValue(bean: faseCampoFutebolInstance, field: "title")}</td>
                            <td>${fieldValue(bean: faseCampoFutebolInstance, field: "answer")}</td>
                            <td><i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil "
                                   onclick="_modal_edit($(this.closest('tr')))"></i>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>


        <!------------ BOTÕES ------------>
        <div class="row">
            <!-- BOTÕES LARANJA -->
            <div class="col s1 m1 l1 offset-s4 offset-m8 offset-l8">
                <a data-target="createModal" name="create"
                   class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped"
                   data-tooltip="Criar questão"><i class="material-icons">add</i></a>
            </div>

            <div class="col s1 offset-s1 m1 l1">
                <a name="delete" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped"
                   data-tooltip="Exluir questão"><i class="material-icons" onclick="_open_modal_delete()">delete</i></a>
            </div>

            <div class="col s1 offset-s1 m1 l1">
                <a data-target="uploadModal"
                   class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped"
                   data-tooltip="Upload arquivo .csv"><i
                        class="material-icons">file_upload</i></a>
            </div>

            <div class="col s1 offset-s1 m1 l1">
                <a class="btn-floating btn-large waves-effect waves-light my-orange tooltipped"
                   data-tooltip="Exportar questões para .csv"><i
                        class="material-icons" onclick="exportQuestions()">file_download</i></a>
            </div>
        </div>

        <div class="row">
            <!-- BOTÃO TURQUESA "ENVIAR" -->
            <div class="col s2">
                <button class="btn waves-effect waves-light remar-orange" name="save" id="submitButton"
                        onclick="_submit()">Enviar</button>
            </div>
        </div>


        <!------------ EDIT MODAL ------------>
        <div id="editModal" class="modal">
            <div class="modal-content">
                <h4>Editar Desafio</h4>

                <div class="row">
                    <g:form method="post" action="update" resource="${faseCampoFutebolInstance}">
                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTitle" class="active" for="editTitle">Desafio</label>
                                <input id="editTitle" name="title" required="" type="text" class="validate" length="95"
                                       maxlength="95">
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s9">
                                <label id="labelAnswer" class="active" for="editAnswer">Resposta</label>
                                <input type="number" step="any" class="validate" id="editAnswer" name="answer"
                                       required="" maxlength="15" length="15"/>
                            </div>
                        </div>

                        <input type="hidden" id="faseCampoFutebolID" name="faseCampoFutebolID">

                        <div class="col l10">
                            <g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar"/>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>


        <!------------ CREATE MODAL ------------>
        <div id="createModal" class="modal">
            <div class="modal-content">
                <h4>Criar Desafio</h4>

                <div class="row">
                    <g:form action="save" resource="${faseCampoFutebolInstance}">
                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTitleCreate" class="active" for="editTitleCreate">Pergunta</label>
                                <input id="editTitleCreate" name="title" required="" type="text" class="validate"
                                       length="95" maxlength="95">
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelAnswerCreate" class="active" for="editAnswerCreate">Resposta</label>
                                <input type="number" step="any" class="validate" id="editAnswerCreate" name="answer"
                                       required="" maxlength="15" length="15"/>
                            </div>
                        </div>

                        <div class="col l10">
                            <g:submitButton name="create" class="btn btn-success btn-lg my-orange" value="Criar"/>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>

        <!------------ DELETE MODAL ------------>
        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div id="delete-one-question">
                    Você tem certeza que deseja excluir esse desafio?
                </div>

                <div id="delete-several-questions">
                    Você tem certeza que deseja excluir esses desafios?
                </div>
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()"
                        style="margin-right: 10px;">Sim</button>
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Não</button>
            </div>
        </div>


        <div id="erroDeleteModal" class="modal">
            <div class="modal-content">
                Você deve selecionar ao menos um desafio para excluir.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>

        <div id="errorSaveModal" class="modal">
            <div class="modal-content">
                Você deve selecionar pelo menos dois desafios para enviar.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>


        <div id="errorDownloadModal" class="modal">
            <div class="modal-content">
                Você deve selecionar ao menos um desafio antes de exportar seu banco de questões.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>

        <div id="errorImportingQuestionsModal" class="modal">
            <div class="modal-content">
                Erro - Para importar desafios, você deve deixá-los no formato indicado.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>


        <!------------ UPLOAD MODAL (importar arquivo .CSV) ------------>
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
                            <li>O separador do arquivo .csv deve ser <b>';' (ponto e vírgula)</b></li>
                            <li>O arquivo deve ser composto apenas por <b>dados</b></li>
                            <li>O arquivo deve representar a estrutura da tabela de exemplo</li>
                        </ol>
                        <ul>
                            <li><a href="/santograuinclusivo/samples/exemploSantoGrau.csv">Download do arquivo exemplo</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="row">
                    <div class="col s12">
                        <table class="center" style="font-size: 12px;">
                            <thead>
                            <tr>
                                <th>Pergunta</th>
                                <th>Resposta</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr>
                                <td>Pergunta 1</td>
                                <td>Resposta 1</td>
                            </tr>
                            <tr>
                                <td>Pergunta 2</td>
                                <td>Resposta 2</td>
                            </tr>
                            <tr>
                                <td>Pergunta 3</td>
                                <td>Resposta 3</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="errorImportingQuestions" name="errorImportingQuestions" value="${errorImportQuestions}">
</body>
</html>
