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


});


function AutoClickButton(id){
    var button = "#button"+id
    $(button).click();
}

function ShowWord(word, answer,initial_position, id) {

    var node = document.getElementById("showWordModal");
    var button_move_right = "<button class='myButton4' onclick=\"right('"+id+"')\" > <div style=\"align-content: center;left: 50%;\" class=\"arrowright\"></div></button>"
    var button_move_left = "<button class='myButton4' onclick=\"left('"+id+"')\" > <div style=\"align-content: center;left: 50%;\" class=\"arrowleft\"></div>  </button>"

    node.innerHTML=""
    node.innerHTML+= button_move_left

    for(var i=0; i<10;i++){
        if(word[i]=="ì")
            node.innerHTML += "<button class='myButton2' '>" + "-" + "</button>"
        else{
            if(word[i]=="0")
            {
                var button_clear_letter = "<button class='myButton' onclick='clear_letter(" + id + "," + (i+1) + ")' > " + answer[i-initial_position] + "</button>"
                node.innerHTML += button_clear_letter
            }
            else
            {
                var button_mark_letter = "<button class='myButton3' onclick='mark_letter(" + id + "," + (i+1) + ")' > " + word[i] + "</button>"
                node.innerHTML += button_mark_letter
            }
        }
    }
    node.innerHTML+= button_move_right
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