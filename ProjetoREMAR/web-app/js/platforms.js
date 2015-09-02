/**
 * Created by matheus on 5/7/15.
 */

window.onload = function () {
    $("#moodle").click(function () {
        $('#moodleForm').toggle($('#moodle:checked').length > 0);
        console.log("Ola");

    });
};

window.addEventListener("load", function() {
    $("#send").on("click", function() {
        $(".checkbox-platform").each(function() {
            if (this.checked) {
                $(this).removeClass('checkbox-platform');
                var id = this.id;
                var el = $('label[for="' + id + '"]');
                var originalText = $(el).html();
                var intervalId = setInterval(function() {etc(el)}, 500);
                ajax(id, intervalId, el, originalText);
            }
        });
    });

});


function ajax(endpoint, intervalId, el, originalText) {
    $.ajax({
        type:'GET',
        url: location.origin + '/exported-resource/' + endpoint + "?id=" + $(el).data("resource-id") + "&type=" + $("input[name=type]:checked").val(),
        success:function(data){
            clearInterval(intervalId);
            $(el).html(originalText +": <a target=\"_blank\" href=\"" + data + "\">Acessar</a>");
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}

function etc(el) {
    var html = $(el).html();

    if(html != "Processando..." && html.indexOf("Processando") > -1) {
        html += ".";
    } else if (!html.indexOf("Processando") > -1 || html.indexOf("...") > -1) {
        html = "Processando.";
    }

    $(el).html(html);
}