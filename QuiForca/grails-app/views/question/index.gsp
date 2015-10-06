
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
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
                                <g:link name="create" class="btn btn-success btn-lg" action="create">Nova Questão</g:link>
                                <g:submitButton id="delete" name="delete" class="delete btn btn-danger new-question-create-button" value="Remover" alt="Remove questões selecionadas"/>
                                <input  type="text" id="SearchLabel" placeholder="Buscar" style="margin-left: 10px;"/>
                                <br />
                                <br />
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
                <g:submitButton  name="save" class="btn btn-success" value="Enviar"/>
                <div class="pagination">
                    <g:paginate total="${questionInstanceCount ?: 0}" />
                </div>
            </fieldset>
        </div>
    </body>
</html>
