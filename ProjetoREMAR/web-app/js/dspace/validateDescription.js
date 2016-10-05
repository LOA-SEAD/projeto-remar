/**
 * Created by marcus on 08/08/16.
 */
var itensCount = $("#itensCount").val();
$(".description-error").hide();

$( document ).ready(function() {

    $("#nextLabel").hide();
    $("#nextButton").removeClass('hide');

});

function checkDescriptions(){
    var status = true;
    for(var i=0; i<itensCount;i++){
        if($("#description"+i).val()==null || $("#description"+i).val()==""){
            status = false;
            $("#description"+i).removeClass('valid').addClass('invalid');
            $("#description"+i+"-error").show();
        }
        else{
            $("#description"+i).removeClass('invalid').addClass('valid');
            $("#description"+i+"-error").hide();

        }

    }

    if(status){
        $("#finishLabel").hide();
        $("#finishButton").removeClass('hide');
    }
    else{
        $("#finishLabel").show();
        $("#finishButton").addClass('hide');
    }

}