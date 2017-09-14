/**
 * Created by Douglas on 11/09/17.
 * Based on Santo Grau models (faseCampoMinado and faseTCC)
 */

var list_id_delete = [];

window.onload = function(){
    //$("#title").characterCounter();
    $('.modal-trigger').leanModal();
    /*$("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody ").find("tr"), function() {
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });*/

    if($("#errorImportingQuestions").val() == "true") {
        $("#errorImportingQuestions").openModal();
    }
};

function _modal_edit(tr){
    var url = location.origin + '/sanjarunner/quizBanhado/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var quizBanhadoInstance = returndata.split("%@!");
                //quizBanhadoInstance é um vetor com os atributos da classe Question na seguinte ordem:
                // Question - Answer[0] - Answer[1] - Answer[2] - Answer[3] - CorrectAnswer - ID

                switch(quizBanhadoInstance[5]){
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
                $("#editQuestion").attr("value",quizBanhadoInstance[0]);
                $("#labelQuestion").attr("class","active");
                $("#labelAnswers1").attr("class","active");
                $("#labelAnswers2").attr("class","active");
                $("#labelAnswers3").attr("class","active");
                $("#labelAnswers4").attr("class","active");
                $("#editAnswers0").attr("value",quizBanhadoInstance[1]);
                $("#editAnswers1").attr("value",quizBanhadoInstance[2]);
                $("#editAnswers2").attr("value",quizBanhadoInstance[3]);
                $("#editAnswers3").attr("value",quizBanhadoInstance[4]);
                $("#quizBanhadoID").attr("value",quizBanhadoInstance[4]);
                $("#editModal").openModal();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
                if(returndata.status == 401) {
                    var url = document.referrer;
                    //url = url.substr(0,url.indexOf('/',7))
                    window.top.location.href = url //+ "/login/auth"
                } else {
                    alert("Error:\n" + returndata.responseText);
                }
            }
        }
    );
}

//CONSERTAR
/*function exportQuestions(){
    var list_id = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

        $.ajax({
            type: "POST",
            traditional: true,
            url: "/sanjarunner/quizBanhado/exportCSV",
            data: { list_id: list_id },
            success: function(returndata) {
                console.log(returndata);
                window.open(location.origin + returndata, '_blank');
            },
            error: function(returndata) {
                if(returndata.status == 401) {
                    var url = document.referrer;
                    //url = url.substr(0,url.indexOf('/',7))
                    window.top.location.href = url //+ "/login/auth"
                } else {
                    if(returndata.status == 401) {
                        var url = document.referrer;
                        //url = url.substr(0,url.indexOf('/',7))
                        window.top.location.href = url //+ "/login/auth"
                    } else {
                        alert("Error:\n" + returndata.responseText);
                    }
                }


            }
        });
}*/

//CONSERTAR
function _submit() {
    var list_id = [];

    //checa se o usuario selecionou exatamente 4 questoes
    /*if($("input[type=checkbox]:checked").size() < 4) {
        $("#errorSaveModal").openModal();
    } else {*/
        //cria uma lista com os ids de cada questao selecionada
    $.each($("input[type=text]"), function (ignored, el) {
            var tr = $(el).parents().eq(1);
            console.log(tr);
            list_id.push($(tr).attr('data-id'));
    });

    //chama o controlador para criar o arquivo txt com as questoes inseridas
    $.ajax({
        type: "POST",
        traditional: true,
        url: "/sanjarunner/quizBanhado/exportQuestions",
        data: { list_id: list_id},
        success: function(returndata) {
            window.top.location.href = returndata;
        },
        error: function(returndata) {
            if(returndata.status == 401) {
                var url = document.referrer;
                //url = url.substr(0,url.indexOf('/',7))
                window.top.location.href = url //+ "/login/auth"
            } else {
                alert("Error:\n" + returndata.responseText);
            }
        }
    });
    //}
}