<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="scriptTheme.js"/>
        <!--<g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />-->
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header">
            <h1> Minhas Questões</h1>
        </div>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Visualização das Minhas Questões</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                    <tr>

                                        <g:sortableColumn property="level" title="${message(code: 'questionEscola.level.label', default: 'Level')}" />

                                        <g:sortableColumn property="answers" title="${message(code: 'questionEscola.answers.label', default: 'Answers')}" />

                                        <g:sortableColumn property="correctAnswer" title="${message(code: 'questionEscola.correctAnswer.label', default: 'Correct Answer')}" />

                                        <g:sortableColumn property="title" title="${message(code: 'questionEscola.title.label', default: 'Title')}" />

                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${questionEscolaInstanceList}" status="i" var="questionEscolaInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                            <td><g:link action="show" id="${questionEscolaInstance.id}">${fieldValue(bean: questionEscolaInstance, field: "level")}</g:link></td>

                                            <td>${fieldValue(bean: questionEscolaInstance, field: "answers")}</td>

                                            <td>${questionEscolaInstance.correctAnswer + 1}</td>

                                            <td>${fieldValue(bean: questionEscolaInstance, field: "title")}</td>

                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 center">
                <div class="paginacao">
                    <g:paginate total="${questionEscolaInstanceCount ?: 0}" />
                </div>

                <g:link class="btn btn-info btn-lg" action="createXML">Finalizar</g:link>
                <g:link class="btn btn-success btn-lg" action="create">Nova Questão</g:link>

            </div>
        </div>
    </body>
</html>
