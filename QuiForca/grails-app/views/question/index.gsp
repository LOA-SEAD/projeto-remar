
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        %{--<g:javascript src="editableTable.js"/>--}%
        <g:javascript src="scriptTable.js"/>
        <g:javascript src="../assets/js/jquery.min.js"/>
        <g:javascript src="../assets/js/bootstrap.min.js"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'stylesheet.css')}" />
        <link rel="stylesheet" href="${resource(dir: 'assets/css', file: 'bootstrap.min.css')}" />
        <link rel="stylesheet" href="${resource(dir: 'assets/css', file: 'modal.css')}" />
        <meta property="user-name" content="${userName}"/>
        <meta property="user-id" content="${userId}"/>

        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">


    </head>
    <body>

        <div class="page-header">
            <h1> Minhas Questões</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                    <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">

                            <div class="pull-right">
                                <button name="create" type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#CreateModal">Nova Questão</button>
                                <g:submitButton id="delete" name="delete" class="delete btn btn-danger btn-lg new-question-create-button" value="Remover" alt="Remove questões selecionadas"/>
                                <br />
                                <br />
                            <div class="pull-right" style="margin-bottom: 15px;">
                                <input  type="text" id="SearchLabel" placeholder="Buscar"/>
                            </div>
                            </div>

                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                <tr>
                                    <th style="text-align: center">Selecionar </th>
                                    <th style="text-align: center">Pergunta </th>
                                    <th style="text-align: center">Resposta</th>
                                    <th style="text-align: center">Tema</th>
                                    <th style="text-align: center">Autor</th>
                                </tr>

                                <tr style="height: 5px; width: 5px;">
                                    <th align="center"><input align="center" class="checkbox" type="checkbox" id="CheckAll" style="margin-left: 42%;"/></th>
                                </tr>

                                </thead>
                                <tbody>
                                <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                                    <tr class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
                                        data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
                                        data-checked="false"
                                    >

                                        <td class="_not_editable" align="center" > <input class="checkbox" type="checkbox"/> </td>

                                        <td name="question_label" style="text-align: center;" data-questionId="${questionInstance.id}" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}" >${fieldValue(bean: questionInstance, field: "statement")}</td>

                                        <td style="text-align: center;" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}" >${fieldValue(bean: questionInstance, field: "answer")}</td>

                                        <td name="theme" id="theme" style="text-align: center;" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}" >${fieldValue(bean: questionInstance, field: "category")}</td>

                                        <td style="text-align: center;" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}" >${fieldValue(bean: questionInstance, field: "author")}</td>

                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>

            </div>
            <fieldset class="buttons">
                <g:submitButton  name="save" class="btn btn-success btn-lg" value="Enviar"/>
                <div class="pagination">
                    <g:paginate total="${questionInstanceCount ?: 0}" />
                </div>
            </fieldset>
                    <!-- Create Question Modal -->
                    <div class="modal fade" id="CreateModal" role="dialog">
                        <div class="modal-dialog center new-size ">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title"><i class="icon-table"></i>  Criar uma Questão</h4>
                                </div>
                                <div class="modal-body">
                                    <g:if test="${flash.message}">
                                        <div class="message" role="status">${flash.message}</div>
                                    </g:if>

                                    <div class="padded">
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
                                        <g:form url="[resource:questionInstance, action:'save']" >
                                            <fieldset class="form">
                                                <g:render template="form"/>
                                            </fieldset>
                                            <br />
                                            <fieldset class="buttons">
                                                <g:submitButton name="create" class="btn btn-success btn-lg" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                                                <g:link class="btn btn-warning btn-lg" action="index">Voltar</g:link>
                                            </fieldset>
                                            </g:form>
                                    </div>
                                </div>
                                %{--<div class="modal-footer">--}%
                                    %{--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--}%
                                %{--</div>--}%
                            </div>
                        </div>
                    </div>
                <!--Edit Question Modal -->
                <div class="modal fade" id="EditModal" role="dialog">
                    <div class="modal-dialog center new-size ">
                        <!-- Modal content-->
                        <div class="modal-content">

                            <div class="modal-body">
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    <script type="text/javascript">
        var x = document.getElementsByName("question_label");
        $(document).on("click", ".selectable_tr", function () {
            console.log("click event");
            var myNameId = $(this).data('id')
            console.log(myNameId);
            $("#questionInstance").val( myNameId );

            $('body').on('hidden.bs.modal', '#EditModal', function (e) {
                console.log("entrou aqui");
                $(e.target).removeData("bs.modal");
                $("#EditModal > div > div > div").empty();
            });

        });

    </script>
    </body>
</html>
