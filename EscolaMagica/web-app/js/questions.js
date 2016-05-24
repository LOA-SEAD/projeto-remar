$(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal-trigger').leanModal();
    //$('select').material_select();
});


window.onload = function() {
    $('#BtnUnCheckAll').hide();

    var x = document.getElementsByName("question_label");
    $(document).on("click", ".selectable_tr", function () {
        var myNameId = $(this).data('id')

        $("#questionInstance").val( myNameId );

        $('body').on('hidden.bs.modal', '#EditModal', function (e) {
            $(e.target).removeData("bs.modal");
            $("#EditModal > div > div > div").empty();
        });

    });



    $(function(){
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
    });

    $('#submitButton').click(function () {
        var list_id = [];
        var questions_level1 = 0;
        var questions_level2 = 0;
        var questions_level3 = 0;
        $.each($("input[type=checkbox]:checked"), function(ignored, el) {
            var tr = $(el).parents().eq(1);
            switch ($(tr).attr('data-level')) {
                case "1":
                    questions_level1++;
                    break;
                case "2":
                    questions_level2++;
                    break;
                default:
                    questions_level3++;
                    break;

            }
            list_id.push($(tr).attr('data-id'));
        });


        if(questions_level1 >= 5 && questions_level2 >= 5 && questions_level3 >= 5){
            $.ajax({
                type: "POST",
                traditional: true,
                url: "/escolamagica/question/createXML",
                data: { list_id: list_id },
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
            $("#totalQuestion").append("<div> <p> Você deve selecionar no mínimo 5 (cinco) questões de cada nível. </p> </div>");
            $("#totalQuestion").append("<div> <p> Questões nível 1: " + questions_level1 +" . </p> </div>");
            $("#totalQuestion").append("<div> <p> Questões nível 2: " + questions_level2 +" . </p> </div>");
            $("#totalQuestion").append("<div> <p> Questões nível 3: " + questions_level3 +" . </p> </div>");
            $('#infoModal').openModal();


        }

    });

    $('#noSubmitButton').click(function () {
        alert("Você deve criar no mínimo 5 (cinco) questões de cada nível.");
    })
};

function _edit(tr) {
    var url = location.origin + '/escolamagica/question/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var questionInstance = returndata.split("%@!");
                //questionInstance é um vetor com os atributos da classe Question na seguinte ordem:
                // Level - Title - Answer[0] - Answer[1] - Answer[2] - Answer[3] - correctAnswer -  ID
                console.log("Sucesso?");
                console.log(questionInstance);
                switch (questionInstance[0]) {
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

                switch (questionInstance[6]) {
                    case '0':
                        $("#editRadio0").attr("checked", "checked");
                        break;
                    case '1':
                        $("#editRadio1").attr("checked", "checked");
                        break;
                    case '2':
                        $("#editRadio2").attr("checked", "checked");
                        break;
                    case '3':
                        $("#editRadio3").attr("checked", "checked");
                        break;
                    default :
                        console.log("Alternativa correta inválida");
                }
                $("#editTitle").attr("value", questionInstance[1]);
                $("#labelTitle").attr("class", "active");
                $("#labelAnswer1").attr("class", "active");
                $("#labelAnswer2").attr("class", "active");
                $("#labelAnswer3").attr("class", "active");
                $("#labelAnswer4").attr("class", "active");
                $("#editAnswers0").attr("value", questionInstance[2]);
                $("#editAnswers1").attr("value", questionInstance[3]);
                $("#editAnswers2").attr("value", questionInstance[4]);
                $("#editAnswers3").attr("value", questionInstance[5]);
                $("#questionID").attr("value", questionInstance[7]);


                $("#editModal").openModal();


            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
            }
        }
    );
}

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
                    //uncheck_all();
                    //window.location.reload();
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
