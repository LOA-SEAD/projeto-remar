/**
 * Created by marcus on 18/08/15.
 */

$(function(){

    $('#BtnUnCheckAll').hide();

    $("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#ListTable tbody").find("tr"), function() {
            console.log($(this).text());
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });

    $('#ListTable tr td:not(:last-child)').click(function (event) {
        var tr = this.closest('tr');
        if($(tr).attr('data-checked') == "true") {
            $(tr).attr('data-checked', "false");
            $(':checkbox', this.closest('tr')).prop('checked', false);
        }
        else {
            $(tr).attr('data-checked', "true");
            $(':checkbox', this.closest('tr')).prop('checked', 'checked');
        }

    });


});

function showWord(wordP, answerP, initial_positionP, idP){
    var word = wordP;
    var answer = answerP;
    var initial_position = initial_positionP;
    var id = idP;

    var button_move_right = "<button class='myButton4' onclick=\"right('"+id+"')\" > <div style=\"align-content: center;left: 50%;\" class=\"arrowright\"></div></button>";
    var button_move_left = "<button class='myButton4' onclick=\"left('"+id+"')\" > <div style=\"align-content: center;left: 50%;\" class=\"arrowleft\"></div>  </button>";

    $("#showWordModal").empty();
    $("#showWordModal").append("<div class='col s1'> " + button_move_left + "</div>");



    for(var i=0; i<10;i++){
        if(word[i]=="ì"){
            $("#showWordModal").append("<div class='col s1'> <button class='myButton2'> - </button> </div>");

        }
        else{
            if(word[i]=="0")
            {
                var button_clear_letter = "<button class='myButton' onclick='clear_letter(" + id + "," + (i+1) + ")' > " + answer[i-initial_position] + "</button>";
                $("#showWordModal").append("<div class='col s1'>" + button_clear_letter + " </div>");
            }
            else
            {
                var button_mark_letter = "<button class='myButton3' onclick='mark_letter(" + id + "," + (i+1) + ")' > " + word[i] + "</button>";
                $("#showWordModal").append("<div class='col s1'> " + button_mark_letter +"  </div>");
            }
        }
    }
    $("#showWordModal").append("<div class='col s1'>" + button_move_right + "</div>");

}

function showWordAndModal(wordP, answerP,initial_positionP, idP) {
    showWord(wordP, answerP,initial_positionP, idP);
    $("#showModal").openModal({
        complete: function(){
            $(".lean-overlay").remove();
            window.location.reload();
        }
    });

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

function submit(){
    var list="";
    var count = 0;
    var trs = document.getElementById('ListTable').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    console.log(trs.length);
    for (var i = 0; i < trs.length; i++) {
        if ($(trs[i]).attr('data-checked') == "true") {
            list += $(trs[i]).attr('data-id') + ',';
            count = count +1;
        }
    }

    if(count>0){
        var url = location.origin + '/ortotetris/word/toJson';
        var data = {"ids": list };

        $.ajax({
                type: 'GET',
                data: data,
                url: url,
                success: function (returnData) {
                    window.top.location.href=returnData;
                    //uncheck_all();
                    //window.location.reload();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            }
        );
    }
    else{
        alert("Você deve selecionar ao menos uma palavra antes de enviar");
    }


}

$(document).ready(function () {

    $('.modal-trigger').leanModal({
        ready: function () {
        },
        complete: function () {

        }
    });


});


function right(id) {
    var parameters = {"id": id};

    $.ajax({
        type: 'POST',
        url: "word/moveToRight",
        data: parameters,
        success: function (data) {
            $.ajax({
                type: 'GET',
                url: "word/getWord",
                data: parameters,
                success: function (data) {
                    var atributos = data.split("#@&");
                    console.log(atributos);
                    showWord(atributos[0], atributos[1], atributos[2], atributos[3])

                },
                error: function(req, res, err, data) {
                    console.log(req);
                    console.log(res);
                    console.log(err);
                    console.log("data: " + data);
                }
            });

        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
}

function left(id) {
    var parameters = {"id": id};
    $.ajax({
        type: 'POST',
        url: "word/moveToLeft",
        data: parameters,
        success: function (data) {
            console.log(data);
            $.ajax({
                type: 'GET',
                url: "word/getWord",
                data: parameters,
                success: function (data) {
                    var atributos = data.split("#@&");
                    console.log(atributos);
                    showWord(atributos[0], atributos[1], atributos[2], atributos[3])

                },
                error: function(req, res, err, data) {
                    console.log(req);
                    console.log(res);
                    console.log(err);
                    console.log("data: " + data);
                }
            });

        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
}

function mark_letter(id, pos) {
    var parameters = {"id": id, "pos": pos};
    $.ajax({
        type: 'POST',
        url: "word/markLetter",
        data: parameters,
        success: function (data) {
            console.log(data);
            $.ajax({
                type: 'GET',
                url: "word/getWord",
                data: parameters,
                success: function (data) {
                    var atributos = data.split("#@&");
                    console.log(atributos);
                    showWord(atributos[0], atributos[1], atributos[2], atributos[3])

                },
                error: function(req, res, err, data) {
                    console.log(req);
                    console.log(res);
                    console.log(err);
                    console.log("data: " + data);
                }
            });

        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
}

function clear_letter(id, pos) {
    var parameters = {"id": id, "pos": pos};
    $.ajax({
        type: 'POST',
        url: "word/clearPosition",
        data: parameters,
        success: function (data) {
            console.log(data);
            $.ajax({
                type: 'GET',
                url: "word/getWord",
                data: parameters,
                success: function (data) {
                    var atributos = data.split("#@&");
                    console.log(atributos);
                    showWord(atributos[0], atributos[1], atributos[2], atributos[3])

                },
                error: function(req, res, err, data) {
                    console.log(req);
                    console.log(res);
                    console.log(err);
                    console.log("data: " + data);
                }
            });

        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
}

function SaveToJson() {
    var list="";
    var trs = document.getElementById('ListTable').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    console.log(trs.length);
    for (var i = 0; i < trs.length; i++) {
        if ($(trs[i]).attr('data-checked') == "true") {
            list += $(trs[i]).attr('data-id') + ',';
        }
    }

    var parameters = {"ids": list }
    $.ajax({
        type: 'POST',
        url: "word/toJson",
        data: parameters,
        success: function (data) {
            console.log(data);

        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
}

function SaveNewWord() {
    var ans = document.getElementById("NewWordLabel").value;
    var parameters = {"answer": ans, "word": "none", "initial_position": 0};
    $.ajax({
        type: 'POST',
        url: "word/save",
        data: parameters,
        success: function (data) {
            window.location.reload();
        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
    $('#NewWordLabel').val("");
    $('#createModal').closeModal();
}