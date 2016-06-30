/**
 * Created by lucasbocanegra on 21/06/16.
 */

$(document).ready(function(){

    var modal = $("#modal");
    var icon_metadata_done = $('.icon-metadata-done');
    var icon_metadata_pending = $('.icon-metadata-pending');

    $(icon_metadata_done).hide();
    $(icon_metadata_pending).hide();

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

    $("input[type=checkbox]").change(function(){
        var tr = $(this).parents().eq(2);

        if(this.checked){
            $(tr).find('.icon-metadata-disabled').hide();
            $(tr).find(icon_metadata_pending).show();
        }else{
            $(tr).find('.icon-metadata-disabled').show();
            $(tr).find(icon_metadata_pending).hide();
        }
    })


});