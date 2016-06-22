/**
 * Created by lucasbocanegra on 21/06/16.
 */

$(document).ready(function(){

    var modal = $("#modal");

    $(".view").on("click",function(){

        $.ajax({
            type:'GET',
            url: '/dspace/bitstream/' + $(this).attr("data-bitstream-id"),
            data: null,
            success: function(data){
                $(modal).empty();
                $(modal).append(data);
                $(modal).openModal();
            },
            error: function(data){
                console.log("deu erros do modal");
            }
        });
    });
});