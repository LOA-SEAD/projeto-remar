
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <g:javascript src="editableTable.js"/>
        <g:javascript src="scriptTable.js"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'stylesheet.css')}" />

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
                            %{--<div class="pull-left alert alert-info">--}%
                                %{--<i class="fa fa-exclamation-triangle"></i>Favor não utilizar a tecla tab--}%
                                 %{--<i class="fa fa-smile-o"></i><br>--}%
                                 %{--<i class="fa fa-exclamation-triangle"></i>--}%
                                %{--Certifique-se que você tirou o foco dos campos editáveis antes de clicar em "Enviar" <i class="fa fa-smile-o"></i><br>--}%
                            %{--</div>--}%
                            <div class="pull-right">
                                <g:link name="create" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal">Nova Questão</g:link>
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

                                    <th style="text-align: center">Selecionar</th>
                                    <th style="text-align: center" >Pergunta</th>
                                    <th style="text-align: center">Resposta</th>
                                    <th style="text-align: center">Tema</th>
                                    <th style="text-align: center" >Autor</th>


                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                                    <tr class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
                                        data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
                                        data-checked="false"
                                    >

                                        <td class="_not_editable" align="center" > <input class="checkbox" type="checkbox"/> </td>

                                        <td style="text-align: center;"  onclick='window.location = "${createLink(action: "edit", id: questionInstance.id)}"' >${fieldValue(bean: questionInstance, field: "statement")}</td>

                                        <td style="text-align: center;"  onclick='window.location = "${createLink(action: "edit", id: questionInstance.id)}"'  >${fieldValue(bean: questionInstance, field: "answer")}</td>

                                        <td name="theme" id="theme" style="text-align: center;"  onclick='window.location = "${createLink(action: "edit", id: questionInstance.id)}"' >${fieldValue(bean: questionInstance, field: "category")}</td>

                                        <td style="text-align: center;"  onclick='window.location = "${createLink(action: "edit", id: questionInstance.id)}"' >${fieldValue(bean: questionInstance, field: "author")}</td>

                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
            <fieldset class="buttons">
                <g:submitButton  name="save" class="btn btn-success btn-lg" value="Enviar"/>
                <div class="pagination">
                    <g:paginate total="${questionInstanceCount ?: 0}" />
                </div>
            </fieldset>
        </div>
    </body>
</html>
