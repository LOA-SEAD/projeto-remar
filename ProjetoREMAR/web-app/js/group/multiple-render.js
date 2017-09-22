/*
 * Created by Lucas Pessoa (github: lucas-pessoa)
 *  on Sep 22, 2017
 */

$(document).ready(function() {

    $(".tabelaStats").each(function(){
        if($(this).attr('num-fase') == $("#select-multiple").find(":selected").val()){
            $(this).css("display", "block");
        }else {
            $(this).css("display", "none");
        }
    });

    $("#select-multiple").change(function(){
        var gameIndex = $(this).find(":selected").val();
        renderMultiple(gameIndex);
    });

    function renderMultiple(gameIndex){
        $(".tabelaStats").each(function(){
            if($(this).attr('num-fase') == gameIndex){
                $(this).css("display", "block");
            }else {
                $(this).css("display", "none");
            }
        });
    };
});