/**
 * Created by marcus on 08/08/16.
 */
var resourceCount = $("#resourceCount").val();

function showResourceStatus(){
    for(var i=0; i<resourceCount;i++){
        switch($("#cardStatus"+i).val()){
            case "pending":
                $("#card"+i).addClass("pending");
                break;
            case "approved":
                $("#card"+i).addClass("approved");
                break;
            case "rejected":
                $("#card"+i).addClass("rejected");
                break;
        }
    }
}

$(document).ready(function(){
    showResourceStatus();
});