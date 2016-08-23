/**
 * Created by marcus on 08/08/16.
 */
var taskCount = $("#taskCount").val();

function checkMetadata(){
    var status = true;
    for(var i=0; i<taskCount;i++){
        if($("#task"+i).prop('checked') && $("#task"+i+"-metadata").val()=="false"){
            status=false
        }

    }

    if(!status){
        $("#finishLabel").removeClass('hide');
        $("#finishLink").hide();
    }
    else{
        $("#finishLabel").addClass('hide');
        $("#finishLink").show();
    }
    return status;
}

$(document).ready(function(){
    checkMetadata();

   $(".checkbox").change(function(){
        checkMetadata();
    });
});