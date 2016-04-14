/**
 * Created by matheus on 4/29/15.
 */

$(document).ready(function(){
    $('.collapsible').collapsible({
        accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });
});

window.onload = function(){
    console.log("ok");

    $(".save").click(function() {
        //var id = $(this).parent().parent().attr("data-id");
        var id = document.forms["formName"].elements["radio"].value
        window.top.location.href = "choose/" + id;
    });


    $(".delete").click(function() {
        var tr = $(this).parent().parent();
        var id = $(tr).attr("data-id");
        var data = { _method: 'DELETE' };

        if(confirm("Deseja realmente excluir este tema?")){

        $.ajax({
            type:'POST',
            data: data,
            url: "delete/" + id,
            success:function(data){
                console.log(data);
                $(tr).hide();
                $(tr).remove();
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});}
    });

};