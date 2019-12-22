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
        var gameLevel = $(this).find(":selected").val();
        renderMultiple(gameLevel);
    });

    function renderMultiple(gameLevel){
        $(".tabelaStats").each(function(){
            if($(this).attr('num-fase') == gameLevel){
                $(this).css("display", "block");
            }else {
                $(this).css("display", "none");
            }
        });
    };
});