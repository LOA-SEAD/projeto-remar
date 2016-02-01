/**
 * Created by marcus on 18/08/15.
 */

$(function(){
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

$(document).ready(function(){


    //$( "#SearchButton" ).hover(
    //    function() {
    //        $( this ).append( $( "<span> Buscar</span>" ).fadeIn(300) );
    //    }, function() {
    //        $( this ).find( "span:last" ).remove();
    //    }
    //);
    //
    //$( "#CreateWordButton" ).hover(
    //    function() {
    //        $( this ).append( $( "<span> Nova palavra</span>" ).fadeIn(300) );
    //    }, function() {
    //        $( this ).find( "span:last" ).remove();
    //    }
    //);
    //
    //$( "#SaveButton" ).hover(
    //    function() {
    //        $( this ).append( $( "<span> Salvar banco</span>").fadeIn(300) );
    //    }, function() {
    //        $( this ).find( "span:last" ).remove();
    //    }
    //);

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
