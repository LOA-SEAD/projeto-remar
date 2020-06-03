<%@ page import="br.ufscar.sead.loa.santograuinclusivo.remar.QuestionFaseBiblioteca" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Em Busca do Santo Grau</title>
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:external dir="css" file="faseBiblioteca.css"/>
    <script type="text/javascript" src="/santograuinclusivo/js/faseBiblioteca.js"></script>
</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        Fase Biblioteca - Banco de Questões
    </p>
</div>

<div class="row">
    <div style=" margin-bottom: 10px; color:#333333">
        Fase da biblioteca. Existem 3 desafios cada um composto de uma resposta ("palavra mágica") e 3 dicas.

        <div style="margin-top:20px;margin-bottom:15px;text-align:center">
            <img src="/santograuinclusivo/images/library.jpg"
                 style="width:400px"/>
        </div>

        Selecione no mínimo 3 desafios.
    </div>

    <div id="chooseQuestion" class="col s12 m12 l12">
        <br>

        <div class="row">
            <div class="col s6 m3 l3 offset-s6 offset-m9 offset-l9">
                <input type="text" id="SearchLabel" placeholder="Buscar"/>
            </div>
        </div>

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
                        <th>Dicas <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                                         style="visibility: hidden"></button>
                        </div></th>
                        <th>Resposta<div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                                            style="visibility: hidden"></button>
                        </div></th>
                        <th>Ações <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
                                                                                         style="visibility: hidden"></button>
                        </div></th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${questionFaseBibliotecaInstanceList}" status="i" var="faseBibliotecaInstance">
                        <tr id="tr${faseBibliotecaInstance.id}" class="selectable_tr" style="cursor: pointer;"
                            data-id="${faseBibliotecaInstance.id}"
                            data-owner-id="${faseBibliotecaInstance.ownerId}"
                            data-checked="false">
                            <td class="_not_editable">
                                <input style="background-color: #727272" id="checkbox-${faseBibliotecaInstance.id}"
                                       class="filled-in" type="checkbox">
                                <label for="checkbox-${faseBibliotecaInstance.id}"></label>
                            </td>
                            <td>${fieldValue(bean: faseBibliotecaInstance, field: "tips")}</td>
                            <td>${fieldValue(bean: faseBibliotecaInstance, field: "answer")}</td>
                            <td><i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil "
                                   onclick="_modal_edit($(this.closest('tr')))"></i></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- BOTÕES -->
        <div class="row">
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
            <div class="col s2">
                <button class="btn waves-effect waves-light remar-orange" name="save" id="submitButton"
                        onclick="_submit()">Enviar</button>
            </div>
        </div>


        <div id="editModal" class="modal">
            <div class="modal-content">
                <h4>Editar Desafio</h4>

                <div class="row">
                    <g:form method="put" action="update" resource="${faseBibliotecaInstance}">
                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTip1" class="active" for="editTip1">Dica 1</label>
                                <input type="text" class="validate" id="editTip1" name="tip1" required="" maxlength="15"
                                       length="15"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTip2" class="active" for="editTip2">Dica 2</label>
                                <input type="text" class="validate" id="editTip2" name="tip2" required="" maxlength="15"
                                       length="15"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTip3" class="active" for="editTip3">Dica 3</label>
                                <input type="text" class="validate" id="editTip3" name="tip3" required="" maxlength="15"
                                       length="15"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelAnswer" class="active" for="editAnswer">Resposta</label>
                                <input type="text" class="form-control" id="editAnswer" name="answer" required=""
                                       maxlength="15" length="15"/>
                            </div>
                        </div>
                        <input type="hidden" id="faseBibliotecaID" name="faseBibliotecaID">

                        <div class="col l10">
                            <g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar"/>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>

        <!-- CREATE MODAL -->
        <div id="createModal" class="modal">
            <div class="modal-content">
                <h4>Criar Desafio</h4>

                <div class="row">
                    <g:form action="save" resource="${faseBibliotecaInstance}">
                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTip1Create" class="active" for="editTip1Create">Dica 1</label>
                                <input type="text" class="validate" id="editTip1Create" name="tip1" required=""
                                       maxlength="15" length="15"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTip2Create" class="active" for="editTip2Create">Dica 2</label>
                                <input type="text" class="validate" id="editTip2Create" name="tip2" required=""
                                       maxlength="15" length="15"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelTip3Create" class="active" for="editTip3Create">Dica 3</label>
                                <input type="text" class="validate" id="editTip3Create" name="tip3" required=""
                                       maxlength="15" length="15"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <label id="labelAnswerCreate" class="active" for="editAnswerCreate">Resposta</label>
                                <input type="text" class="form-control" id="editAnswerCreate" name="answer" required=""
                                       maxlength="15" length="15"/>
                            </div>
                        </div>

                        <div class="col l10">
                            <g:submitButton name="create" class="btn btn-success btn-lg my-orange" value="Criar"/>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>


        <!-- DELETE MODAL -->
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
                Você deve selecionar ao menos uma questão para excluir.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>

        <div id="errorSaveModal" class="modal">
            <div class="modal-content">
                Você deve selecionar pelo menos 3 desafios para enviar.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>


        <div id="errorDownloadModal" class="modal">
            <div class="modal-content">
                Você deve selecionar ao menos um desafio antes de exportar seu banco de desafios.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
            </div>
        </div>

        <div id="errorImportingQuestionsModal" class="modal">
            <div class="modal-content">
                Erro - Para importar desafios, você deve deixá-las no formado indicado.
            </div>

            <div class="modal-footer">
                <button class="btn waves-effect waves-light modal-close my-orange"
                        style="margin-right: 10px;">Ok</button>
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
                                <th>Dica1</th>
                                <th>Dica2</th>
                                <th>Dica3</th>
                                <th>Resposta</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>DICA</td>
                                <td>DICA</td>
                                <td>DICA</td>
                                <td>RESPOSTA 1</td>
                            </tr>
                            <tr>
                                <td>DICA</td>
                                <td>DICA</td>
                                <td>DICA</td>
                                <td>RESPOSTA 2</td>
                            </tr>
                            <tr>
                                <td>DICA</td>
                                <td>DICA</td>
                                <td>DICA</td>
                                <td>RESPOSTA 3</td>
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
