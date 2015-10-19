<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        %{--<g:javascript src="questions.js" />--}%
        <g:javascript src="../assets/js/jquery.min.js"/>
        <g:javascript src="../assets/js/bootstrap.min.js"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'stylesheet.css')}" />
        <link rel="stylesheet" href="${resource(dir: 'assets/css', file: 'bootstrap.min.css')}" />
        <link rel="stylesheet" href="${resource(dir: 'assets/css', file: 'modal.css')}" />
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
                            <g:if test="${flash.message}">
                                <div class="message" role="status">${flash.message}</div>
                                <br />
                            </g:if>
                            <div class="pull-left alert alert-info">
                                <i class="fa fa-info-circle"></i> Temos algumas questões-exemplo. Você pode editá-las!
                                Basta clicar sobre alguma <i class="fa fa-smile-o"></i><br>
                                <i class="fa fa-info-circle"></i> Não se esqueça: para finalizar a tarefa, são necessárias pelo menos 5 questões para cada nível!</i><br>
                            </div>
                            <div class="pull-right">
                                <g:if test="${Question.validateQuestions("${session.user.id}")}">
                                    <g:link class="btn btn-info btn-lg" target="_parent" action="createXML" >Finalizar</g:link>
                                </g:if>


                                <button class="btn btn-success btn-lg" data-toggle="modal" href="create" data-target="#CreateModal">Nova Questão</button>
                                <br>
                                <br>
                                <div class="pull-right" style="margin-bottom: 15px;">
                                    <input  type="text" id="SearchLabel" placeholder="Buscar"/>
                                </div>
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
                                        <tr class="selectable_tr" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}" style="cursor: pointer;">

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
    <!-- Create Question Modal -->
    <div class="modal fade" id="CreateModal" role="dialog">
        <div class="modal-dialog text-center">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>
    <!-- Edit Question Modal -->
    <div class="modal fade" id="EditModal" role="dialog">
        <div class="modal-dialog text-center ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <div class="modal-body">
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

        $(function(){
            $("#SearchLabel").keyup(function(){
                _this = this;
                $.each($("#table tbody ").find("tr"), function() {
                    console.log($(this).text());
                    if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                        $(this).hide();
                    else
                        $(this).show();
                });
            });
        });

    </script>
    </body>
</html>
