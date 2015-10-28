<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="questions.js" />
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
                            <div class="pull-left">
                                <div class=" alert alert-info">
                                <i class="fa fa-info-circle"></i> Temos algumas questões-exemplo. Você pode editá-las!
                                Basta clicar sobre o ícone <i class="fa fa-pencil"></i><br>
                                <i class="fa fa-info-circle"></i> Não se esqueça: para finalizar a tarefa, são necessárias pelo menos 5 questões para cada nível!</i><br>
                            </div>
                                <button class="btn btn-primary btn-md" style="margin-bottom: 10px;" id="BtnCheckAll" onclick="check_all()" > Selecionar todas</button>
                                <button class="btn btn-primary  btn-md" style="margin-bottom: 10px; background-color: rgba(40, 96, 144, 0.76) "  id="BtnUnCheckAll" onclick="uncheck_all()" > Selecionar todas</button>
                            </div>
                            <div class="pull-right">
                                <g:if test="${Question.validateQuestions("${session.user.id}")}">
                                    <button class="btn btn-info btn-lg" id="submitButton" > Finalizar </button>
                                </g:if>
                                <g:else>
                                    <button class="btn btn-warning btn-lg" id="noSubmitButton" data-toggle="tooltip" data-placement="right" title="Crie pelo menos 5 (cinco) questões de cada nível">Finalizar</button>
                                </g:else>


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
                                        <th style="text-align: center; color: #337AB7">Selecionar </th>
                                        <th style="text-align: center; color: #337AB7"> Nível </th>
                                        <th style="text-align: center; color: #337AB7"> Pergunta </th>
                                        <th style="text-align: center; color: #337AB7"> Respostas </th>
                                        <th style="text-align: center; color: #337AB7"> Alternativa Correta </th>
                                        <th style="text-align: center; color: #337AB7">Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                                        <tr class="selectable_tr" style="cursor: pointer;"
                                            data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}" data-level="${fieldValue(bean: questionInstance, field: "level")}"
                                            data-checked="false"
                                        >

                                            <td class="_not_editable" align="center" > <input class="checkbox" type="checkbox"/> </td>

                                            <td class="level"  >${fieldValue(bean: questionInstance, field: "level")}</td>

                                            <td  >${fieldValue(bean: questionInstance, field: "title")}</td>

                                            <td >${fieldValue(bean: questionInstance, field: "answers")}</td>

                                            <td  >${questionInstance.answers[questionInstance.correctAnswer]} (${questionInstance.correctAnswer + 1}ª Alternativa)</td>

                                            <td style="text-align: center;"  ><i style="color: cornflowerblue; margin-right:10px;" class="fa fa-pencil" data-toggle="modal" data-target="#EditModal" href="edit/${questionInstance.id}"></i> <i style="color: cornflowerblue;" class="fa fa-trash-o" onclick="_delete($(this.closest('tr')))" ></i></td>

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



            function _delete(tr) {
                if(confirm("Você tem certeza que deseja excluir esta questão?")) {
                    var tds = $(tr).find("td");
                    var url = location.origin + '/escolamagica/question/delete/' + $(tr).attr('data-id');
                    var data = {_method: 'DELETE'};

                    $.ajax({
                                type: 'GET',
                                data: data,
                                url: url,
                                success: function (data) {
                                    $(tr).remove();
                                    window.location.reload();
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                }
                            }
                    );


                }
            }

            function check_all(){
                console.log("selecionar todas");
                var CheckAll = document.getElementById("BtnCheckAll");
                var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
                $(".checkbox:visible").prop('checked', 'checked');


                for (var i = 0; i < trs.length; i++) {
                    if($(trs[i]).is(':visible')) {
                        $(trs[i]).attr('data-checked', "true");
                    }
                }

                $('#BtnCheckAll').hide();
                $('#BtnUnCheckAll').show();

            }

            function uncheck_all(){
                console.log("remover todas");
                var UnCheckAll = document.getElementById("BtnUnCheckAll");
                var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
                $(".checkbox:visible").prop('checked', false);


                for (var i = 0; i < trs.length; i++) {
                    if($(trs[i]).is(':visible')) {
                        $(trs[i]).attr('data-checked', "false");
                    }
                }

                $('#BtnUnCheckAll').hide();
                $('#BtnCheckAll').show();

            }

    </script>

    </body>
</html>
