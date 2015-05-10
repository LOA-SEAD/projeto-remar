
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
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header">
            <h1> Minhas Questões</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Visualização dos Seus Temas</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                    <tr>
                                        <th>Selecionar</th>
                                        <th>Pergunta</th>
                                        <th>Resposta</th>
                                        <th>Categoria</th>
                                        <th>Autor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                                        <tr data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
                                            data-checked="false"  class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td class="_not_editable"> <input class="checkbox" type="checkbox"/> </td>

                                            <td>${fieldValue(bean: questionInstance, field: "statement")}</td>

                                            <td>${fieldValue(bean: questionInstance, field: "answer")} </td>

                                            <td>${fieldValue(bean: questionInstance, field: "category")} </td>

                                            <td >${fieldValue(bean: questionInstance, field: "author")}</td>

                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <fieldset class="buttons">
                <g:submitButton  name="create" class="create btn btn-info" value="Nova questão" />
                <g:submitButton  name="save" class="btn btn-success" value="Salvar Alterações"/>
                <g:submitButton  name="delete" class="delete btn btn-danger" value="Remover questões selecionadas"/>
                <div class="pagination">
                    <g:paginate total="${questionInstanceCount ?: 0}" />
                </div>
            </fieldset>
        </div>
    </body>
</html>
