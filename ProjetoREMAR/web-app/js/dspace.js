/**
 * Created by lucasbocanegra on 21/06/16.
 */

$(document).ready(function(){

    var modal = $("#modal");
    var icon_metadata_done = $('.icon-metadata-done');
    var icon_metadata_pending = $('.icon-metadata-pending');

    if (localStorageAvailable()) {
        if (localStorage.DoNotShowMessageAgain && localStorage.DoNotShowMessageAgain === "true") {
            // user doesn't want to see the message again, so handle accordingly
        }else{
            //$('#messenger').openModal();
        }
    }

    // $(icon_metadata_done).hide();
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
    });

    $(icon_metadata_pending).on("click",function(){

    });

    $('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 15 // Creates a dropdown of 15 years to control year
    });

    $('select').material_select();

    $('#add-author').on('click', function(){
        $('.div-author .input-field').last().after(' <div class="input-field col s12"> ' +
                                                    '   <input name="author" id="author" type="text" class="validate"> ' +
                                                    '   <label for="author">Autor:</label> ' +
                                                    '  </div>');
    });


    $('#show-messenger').click(function(){
        console.log("entrou aki!");
        if (this.checked) {
            console.log("checked");

            if (localStorageAvailable()){
                console.log("entramos aki");
                localStorage.DoNotShowMessageAgain = "true";
                console.log(localStorage.DoNotShowMessageAgain);
            }
        }else{
            console.log("don't checked");

            localStorage.DoNotShowMessageAgain = "false"
        }
    })


});

function localStorageAvailable() {
    if (typeof(Storage) !== "undefined") {
        return true;
    }else {
        return false;
    }
}