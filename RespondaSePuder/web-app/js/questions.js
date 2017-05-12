/**
 * Created by marcus on 30/03/16.
 */

window.onload = function(){
    $('#BtnUnCheckAll').hide();
    $('.modal-trigger').leanModal();
    $("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody ").find("tr"), function() {
            //console.log($(this).text());
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });

};


function submit(){
    var list_id_level1 = [];
    var list_id_level2 = [];
    var list_id_level3 = [];

    var questions_level1 = 0;
    var questions_level2 = 0;
    var questions_level3 = 0;
    var randomQuestion = parseInt(document.getElementById("randomQuestion").value);

    if(randomQuestion>0){
        $.each($("input[type=checkbox]:checked"), function (ignored, el) {
            var tr = $(el).parents().eq(1);
            switch ($(tr).attr('data-level')) {
                case "1":
                    questions_level1++;
                    list_id_level1.push($(tr).attr('data-id'));
                    break;
                case "2":
                    questions_level2++;
                    list_id_level2.push($(tr).attr('data-id'));
                    break;
                default:
                    questions_level3++;
                    list_id_level3.push($(tr).attr('data-id'));
                    break;

            }
        });
        if(questions_level1 > randomQuestion && questions_level2 > randomQuestion && questions_level3 > randomQuestion){
            //Chaama controlador para salvar questões em arquivos.json
            $.ajax({
                type: "POST",
                traditional: true,
                url: "/respondasepuder/question/exportQuestions",
                data: { list_id_level1: list_id_level1, list_id_level2: list_id_level2, list_id_level3: list_id_level3, randomQuestion: randomQuestion },
                success: function(returndata) {
                    window.top.location.href = returndata;
                },
                error: function(returndata) {
                    alert("Error:\n" + returndata.responseText);


                }
            });
        }
        else
        {

            $('#totalQuestion').empty();
            var min = randomQuestion + 1;
            if(randomQuestion>1){
                $("#totalQuestion").append("<div> <p> Você deve selecionar no mínimo "+ min + " questões: " + 
                                          randomQuestion + " para serem utilizadas em cada nível mais 1 questão para " + 
					  " a opção \"Pular\".</p> </div>");
            }
            else{
                $("#totalQuestion").append("<div> <p> Você deve selecionar no mínimo "+ min + " questões: " + 
                                          randomQuestion + " para serem utilizadas em cada nível mais 1 questão para " + 
					  " a opção \"Pular\".</p> </div>");
            }

            if(questions_level1==1) {
                $("#totalQuestion").append("<div> <p> Questões nível 1: " + questions_level1 + " selecionada. </p> </div>");
            }
            else {
                $("#totalQuestion").append("<div> <p> Questões nível 1: " + questions_level1 + " selecionadas. </p> </div>");
            }

            if(questions_level2==1) {
                $("#totalQuestion").append("<div> <p> Questões nível 2: " + questions_level2 + " selecionada. </p> </div>");
            }
            else {
                $("#totalQuestion").append("<div> <p> Questões nível 2: " + questions_level2 + " selecionadas. </p> </div>");
            }

            if(questions_level3==1) {
                $("#totalQuestion").append("<div> <p> Questões nível 3: " + questions_level3 + " selecionada. </p> </div>");
            }
            else {
                $("#totalQuestion").append("<div> <p> Questões nível 3: " + questions_level3 + " selecionadas. </p> </div>");
            }

            $('#infoModal').openModal();

        }
    }
    else{
        $('#totalQuestion').empty();
        $("#totalQuestion").append("<div> <p> Você ainda precisa definir o número de questões que o jogo exibirá por nível.</p> </div>");
        $('#infoModal').openModal();
    }



}

function _edit(tr){
    var url = location.origin + '/respondasepuder/question/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var questionInstance = returndata.split("%@!");
                //questionInstance é um vetor com os atributos da classe Question na seguinte ordem:
                // Level - Title - Answer[0] - Answer[1] - Answer[2] - Answer[3] - correctAnswer - Tip(hint) - ID
                console.log("Sucesso?");
                console.log(questionInstance);
                switch(questionInstance[0]){
                    case '1':
                        $("#editLevel1").attr('checked', 'checked');
                        break;
                    case '2':
                        $("#editLevel2").attr('checked', 'checked');
                        break;
                    case '3' :
                        $("#editLevel3").attr('checked', 'checked');
                        break;
                    default :
                        console.log("Nível inválido");
                }

                switch(questionInstance[6]){
                    case '0':
                        $("#editRadio0").attr("checked","checked");
                        break;
                    case '1':
                        $("#editRadio1").attr("checked","checked");
                        break;
                    case '2':
                        $("#editRadio2").attr("checked","checked");
                        break;
                    case '3':
                        $("#editRadio3").attr("checked","checked");
                        break;
                    default :
                        console.log("Alternativa correta inválida");
                }
                $("#editTitle").attr("value",questionInstance[1]);
                $("#labelTitle").attr("class","active");
                $("#labelAnswer1").attr("class","active");
                $("#labelAnswer2").attr("class","active");
                $("#labelAnswer3").attr("class","active");
                $("#labelAnswer4").attr("class","active");
                $("#labelHint").attr("class","active");
                $("#editAnswers0").attr("value",questionInstance[2]);
                $("#editAnswers1").attr("value",questionInstance[3]);
                $("#editAnswers2").attr("value",questionInstance[4]);
                $("#editAnswers3").attr("value",questionInstance[5]);
                $("#editHint").attr("value",questionInstance[7]);
                $("#questionID").attr("value",questionInstance[8]);
                $("#editModal").openModal();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
            }
        }
    );
}

function _delete() {
    var list_id = [];
    var url;
    var data;
    var trID;

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        alert("Você deve selecionar ao menos uma questão para excluir");
    }
    else{
        if(list_id.length==1){
            if(confirm("Você tem certeza que deseja deletar essa questão?")){
                url = location.origin + '/respondasepuder/question/delete/' + list_id[0];
                data = {_method: 'DELETE'};
                trID = "#tr"+list_id[0];
                $.ajax({
                        type: 'DELETE',
                        data: data,
                        url: url,
                        success: function (data) {
                            $(trID).remove();
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                        }
                    }
                );
            }
        }
        else{
            if(confirm("Você tem certeza que deseja deletar essas questões?")){
            for(var i=0;i<list_id.length;i++){
                    url = location.origin + '/respondasepuder/question/delete/' + list_id[i];
                    data = {_method: 'DELETE'};
                    trID = "#tr"+list_id[i];
                    $(trID).remove();
                $.ajax({
                            type: 'DELETE',
                            data: data,
                            url: url,
                            success: function (data) {
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                            }
                        }
                    );
                }
                $(trID).remove();

            }
        }

    }

}

function check_all(){
    console.log("selecionar todas");
    var CheckAll = document.getElementById("BtnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', 'checked');


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
    $(".filled-in:visible").prop('checked', false);


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "false");
        }
    }

    $('#BtnUnCheckAll').hide();
    $('#BtnCheckAll').show();

}

function exportQuestions(){
    var list_id = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        alert("Você deve selecionar ao menos uma questão antes de exportar seu banco de questões");
    }
    else{
        $.ajax({
            type: "POST",
            traditional: true,
            url: "/respondasepuder/question/exportCSV",
            data: { list_id: list_id },
            success: function(returndata) {
                console.log(returndata);
                window.open(location.origin+returndata, '_blank');
            },
            error: function(returndata) {
                alert("Error:\n" + returndata.responseText);


            }
        });
    }

}

function sortTableByLevel(){
    var table = $("#levelLabel").parents('table').eq(0);
    var rows = table.find('tr:gt(0)').toArray().sort(compare($("#levelLabel").index()));
    $("#levelLabel").asc = !$("#levelLabel").asc;
    if ($("#levelLabel").asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}

    function compare(index){
        return function(a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index)
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
        }
    }
    function getCellValue(row, index){
        return $(row).children('td').eq(index).html()
    }
}

function sortTableByName(){
    var table = $("#statementLabel").parents('table').eq(0);
    var rows = table.find('tr:gt(0)').toArray().sort(compare($("#statementLabel").index()));
    $("#statementLabel").asc = !$("#statementLabel").asc;
    if ($("#statementLabel").asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}

    function compare(index){
        return function(a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index);
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
        }
    }
    function getCellValue(row, index){
        return $(row).children('td').eq(index).html()
    }
}

function sortTableByAnswer(){
    var table = $("#answerLabel").parents('table').eq(0);
    var rows = table.find('tr:gt(0)').toArray().sort(compare($("#answerLabel").index()));
    $("#answerLabel").asc = !$("#answerLabel").asc;
    if ($("#answerLabel").asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}

    function compare(index){
        return function(a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index);
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
        }
    }
    function getCellValue(row, index){
        return $(row).children('td').eq(index).html()
    }
}

function sortTableByCorrectAnswer(){
    var table = $("#correctAnswerLabel").parents('table').eq(0);
    var rows = table.find('tr:gt(0)').toArray().sort(compare($("#correctAnswerLabel").index()));
    $("#correctAnswerLabel").asc = !$("#correctAnswerLabel").asc;
    if ($("#correctAnswerLabel").asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}

    function compare(index){
        return function(a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index);
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
        }
    }
    function getCellValue(row, index){
        return $(row).children('td').eq(index).html()
    }
}

function sortTableByHint(){
    var table = $("#hintLabel").parents('table').eq(0);
    var rows = table.find('tr:gt(0)').toArray().sort(compare($("#hintLabel").index()));
    $("#hintLabel").asc = !$("#hintLabel").asc;
    if ($("#hintLabel").asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}

    function compare(index){
        return function(a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index);
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
        }
    }
    function getCellValue(row, index){
        return $(row).children('td').eq(index).html()
    }
}
