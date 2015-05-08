/**
 * Created by matheus on 5/7/15.
 */

window.addEventListener("load", function() {

    $("#send").on("click", function() {
        if($(this).attr("data-clicked")) {
            return;
        }

        $(this).attr("data-clicked", true);

        $(".endpoint").each(function() {
            var checkbox = $(this).find("input");
            if(checkbox[0].checked) {
                var id = this.id;
                var intervalId = setInterval(function(){etc(id)}, 500);
                ajax(id, intervalId);
            }
        });
    });
});


function ajax(endpoint, intervalId) {

    $.ajax({
        type:'GET',
        url: endpoint,
        success:function(data){
            clearInterval(intervalId);
            $("#" + endpoint).find("h1").html("Versão web: <a href=\"" + data + "\">clique aqui</a>");

        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}

function etc(id) {
    var el = $("#" + id).find("h1");
    var html = $(el).html();

    if(html != "Carregando..." && html.indexOf("Carregando") > -1) {
        html += ".";
    } else if (!html.indexOf("Carregando") > -1 || html.indexOf("...") > -1) {
        html = "Carregando.";
    }

    $(el).html(html);

}