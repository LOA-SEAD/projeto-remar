<%@ page import="br.ufscar.sead.loa.escolamagica.remar.QuestionEscola" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
    <g:javascript src="questions.js" ></g:javascript>
    </head>
    <body>
        <div class="page-header">
            <h1> Minhas Questões</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Visualização das Minhas Questões</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <g:if test="${flash.message}">
                                <div class="message" role="status">${flash.message}</div>
                                <br />
                            </g:if>
                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                    <tr>

                                        <g:sortableColumn property="level" title="${message(code: 'questionEscola.level.label', default: 'Nível')}" />

                                        <g:sortableColumn property="title" title="${message(code: 'questionEscola.title.label', default: 'Pergunta')}" />

                                        <g:sortableColumn property="answers" title="${message(code: 'questionEscola.answers.label', default: 'Respostas')}" />

                                        <g:sortableColumn property="correctAnswer" title="${message(code: 'questionEscola.correctAnswer.label', default: 'Alternativa Correta')}" />

                                

                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${questionEscolaInstanceList}" status="i" var="questionEscolaInstance">
                                        <tr class="selectable_tr" onclick='window.location = "${createLink(action: "show", id: questionEscolaInstance.id)}"'>

                                            <td class="level">${fieldValue(bean: questionEscolaInstance, field: "level")}</td>

                                            <td>${fieldValue(bean: questionEscolaInstance, field: "title")}</td>

                                            <td>${fieldValue(bean: questionEscolaInstance, field: "answers")}</td>

                                            <td>${questionEscolaInstance.answers[questionEscolaInstance.correctAnswer]} (${questionEscolaInstance.correctAnswer + 1}ª Alternativa)</td>



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


                <g:if test="${br.ufscar.sead.loa.escolamagica.remar.QuestionEscola.validateQuestions()}" >
                    <g:link class="btn btn-info btn-lg" action="createXML" >Finalizar</g:link>
                </g:if>


                <g:link class="btn btn-success btn-lg" action="create">Nova Questão</g:link>

            </div>
        </div>
    </body>
</html>
