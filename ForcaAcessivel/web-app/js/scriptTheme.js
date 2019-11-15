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


    var checkboxes = document.getElementsByTagName('input');

    for (var i=0; i<checkboxes.length; i++)  {
        if (checkboxes[i].type == 'radio')   {
            checkboxes[i].checked = false;
        }
    }



    $(".save").click(function() {
        var select = false;
        var checkboxes = document.getElementsByTagName('input');
        var i =0;
        while(select==false && i<checkboxes.length){
            if ((checkboxes[i].type == 'radio') && (checkboxes[i].checked==true)){
                select=true;
            }
            i++;
        }
        //var id = $(this).parent().parent().attr("data-id");
        var id = document.forms["formName"].elements["radio"].value;
        if(select==false){
            alert("Você deve selecionar um tema antes de enviar.");
        }
        else{
            window.top.location.href = "/forca_acessivel/theme/choose/" + id;
        }
    });


    $(".delete").click(function() {
        var tr = $(this).parent().parent();
        var id = $(tr).attr("data-id");
        var data = { _method: 'DELETE' };

        if(confirm("Deseja realmente excluir este tema?")){

        $.ajax({
            type:'POST',
            data: data,
            url: "/forca_acessivel/theme/delete/" + id,
            success:function(data){
                console.log(data);
                $(tr).hide();
                $(tr).remove();
                var myThemes = document.getElementsByClassName("myTheme");
                if(myThemes.length==0){
                    window.location.reload();
                }
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});}
    });

};
