
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
            <h1> Tabela de Questões</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                    <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">

                            <div class="pull-right">
                                <button name="create" type="button" class="btn btn-success btn-lg" style="margin-left: 100px;" data-toggle="modal" data-target="#CreateModal">Nova Questão</button>
                                %{--<g:submitButton id="delete" name="delete" class="delete btn btn-danger btn-lg new-question-create-button" value="Remover" alt="Remove questões selecionadas"/>--}%
                                <br />
                                <br />
                            <div class="pull-right" style="margin-bottom: 15px;">
                                <input  type="text" id="SearchLabel" placeholder="Buscar"/>
                            </div>
                            </div>

                            <div class="pull-left">
                                %{--<button name="create" type="button" class="btn btn-success btn-lg" style="margin-left: 100px;" data-toggle="modal" data-target="#CreateModal">Nova Questão</button>--}%
                                <br />
                                <br />
                                <br/>
                                <br/>
                                <div class="pull-left" style="margin-bottom: 15px;">
                                </div>
                                <button class="btn btn-primary btn-md" style="margin-bottom: 10px;" id="BtnCheckAll" onclick="check_all()" > Selecionar todas</button>
                                <button class="btn btn-primary  btn-md" style="margin-bottom: 10px; background-color: rgba(40, 96, 144, 0.76);"  id="BtnUnCheckAll" onclick="uncheck_all()" > Selecionar todas</button>

                            </div>

                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                <tr>
                                    <th style="text-align: center">Selecionar </th>
                                    <th style="text-align: center">Pergunta </th>
                                    <th style="text-align: center">Resposta</th>
                                    <th style="text-align: center">Tema</th>
                                    <th style="text-align: center">Autor</th>
                                    <th style="text-align: center">Ação</th>
                                </tr>

                                %{--<tr style="height: 5px; width: 5px;">--}%
                                    %{--<th align="center"><input align="center" class="checkbox" type="checkbox" id="CheckAll" style="margin-left: 42%;"/></th>--}%
                                %{--</tr>--}%


                                </thead>
                                <tbody>
                                <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                                    <tr class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
                                        data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
                                        data-checked="false"
                                    >
                                        <g:if test="${questionInstance.author == userName }">

                                            <td class="_not_editable" align="center" > <input class="checkbox" type="checkbox"/> </td>

                                            <td name="question_label" style="text-align: center;"  >${fieldValue(bean: questionInstance, field: "statement")}</td>

                                            <td style="text-align: center;"  >${fieldValue(bean: questionInstance, field: "answer")}</td>

                                            <td name="theme" id="theme" style="text-align: center;" >${fieldValue(bean: questionInstance, field: "category")}</td>

                                            <td style="text-align: center;" >${fieldValue(bean: questionInstance, field: "author")}</td>

                                            <td style="text-align: center;"  ><i style="color: cornflowerblue; margin-right:10px;" class="fa fa-pencil" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}"></i> <i style="color: cornflowerblue;" class="fa fa-trash-o" onclick="_delete($(this.closest('tr')))" ></i></td>


                                        </g:if>
                                        <g:else>
                                            <td class="_not_editable" align="center"> <input class="checkbox" type="checkbox"/> </td>

                                            <td name="question_label" style="text-align: center;" data-questionId="${questionInstance.id}" >${fieldValue(bean: questionInstance, field: "statement")}</td>

                                            <td style="text-align: center;" >${fieldValue(bean: questionInstance, field: "answer")}</td>

                                            <td name="theme" id="theme" style="text-align: center;" >${fieldValue(bean: questionInstance, field: "category")}</td>

                                            <td style="text-align: center;" >${fieldValue(bean: questionInstance, field: "author")}</td>

                                            <td style="text-align: center;"> <i style="color: lightslategray; margin-right:10px;" class="fa fa-pencil"></i>  <i style="color: lightslategray;" class="fa fa-trash-o"></i> </td>

                                        </g:else>
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
                        <div class="modal-dialog text-center ">
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
                    <div class="modal-dialog text-center">
                        <!-- Modal content-->
                        <div class="modal-content">

                            <div class="modal-body">
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
