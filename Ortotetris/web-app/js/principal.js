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


function AutoClickButton(id){
    var button = "#button"+id;
    //$(button).click();
    $("#showWordModal").empty();
    var answer = document.getElementById("answerNew"+id).value;
    var word = document.getElementById("wordNew"+id).value;
    var initial_position = document.getElementById("position"+id).value;

    var button_move_right = "<button class='myButton4' onclick=\"right('"+id+"')\" > <div style=\"align-content: center;left: 50%;\" class=\"arrowright\"></div></button>";
    var button_move_left = "<button class='myButton4' onclick=\"left('"+id+"')\" > <div style=\"align-content: center;left: 50%;\" class=\"arrowleft\"></div>  </button>";

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

function ShowWord(wordP, answerP,initial_positionP, idP) {
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
    $("#showModal").openModal({
        complete: function(){
            $(".lean-overlay").remove();
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
    var trs = document.getElementById('ListTable').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    console.log(trs.length);
    for (var i = 0; i < trs.length; i++) {
        if ($(trs[i]).attr('data-checked') == "true") {
            list += $(trs[i]).attr('data-id') + ',';
        }
    }


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

