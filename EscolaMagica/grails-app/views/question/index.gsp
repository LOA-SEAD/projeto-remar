<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
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
                            <div class="pull-right">


                                <g:if test="${Question.validateQuestions()}" >
                                    <g:link class="btn btn-info btn-lg" action="createXML" >Finalizar</g:link>
                                </g:if>


                                <g:link class="btn btn-success btn-lg" action="create">Nova Questão</g:link>
                                <br>
                                <br>
                            </div>
                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                    <tr>

                                        <g:sortableColumn property="level" title="${message(code: 'question.level.label', default: 'Nível')}" />

                                        <g:sortableColumn property="title" title="${message(code: 'question.title.label', default: 'Pergunta')}" />

                                        <g:sortableColumn property="answers" title="${message(code: 'question.answers.label', default: 'Respostas')}" />

                                        <g:sortableColumn property="correctAnswer" title="${message(code: 'question.correctAnswer.label', default: 'Alternativa Correta')}" />
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                                        <tr class="selectable_tr" onclick='window.location = "${createLink(action: "show", id: questionInstance.id)}"'>

                                            <td class="level">${fieldValue(bean: questionInstance, field: "level")}</td>

                                            <td>${fieldValue(bean: questionInstance, field: "title")}</td>

                                            <td>${fieldValue(bean: questionInstance, field: "answers")}</td>

                                            <td>${questionInstance.answers[questionInstance.correctAnswer]} (${questionInstance.correctAnswer + 1}ª Alternativa)</td>



                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </body>
</html>
