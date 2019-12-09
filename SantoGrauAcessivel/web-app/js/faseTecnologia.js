/**
 * Created by leticia on 12/09/16.
 */
$(document).ready(function() {
    $('select').material_select();
});

window.onload = function() {

    $("#submitButton").click(function() {
        if ($("#palavras1").val() != "" && $("#palavras2").val() != "" && $("#palavras3").val() != ""
            && $("#orientacao").val() != "" && $("#link").val() != "") {
            //var words = [];
            var link = $("#link").val();
            var tipoLink = $("#tipo-link").val();
            var palavras1 = $("#palavras1").val();
            var palavras2 = $("#palavras2").val();
            var palavras3 = $("#palavras3").val();


            //words.push($("#palavras1").val());
            //words.push($("#palavras2").val());
            //words.push($("#palavras3").val());

            if(link.indexOf("youtube") > -1 && (link.indexOf("v=") > -1 || link.indexOf("embed") > -1)) {
                //Chama controlador para salvar questões em arquivos .json
                $.ajax({
                    type: "POST",
                    traditional: true,
                    url: "/santograuacessivel/faseTecnologia/exportLevel",
                    data: {palavras1:palavras1, palavras2: palavras2, palavras3:palavras3, link: link, tipoLink: tipoLink},
                    success: function (returndata) {
                        window.top.location.href = returndata;
                    },
                    error: function (returndata) {
                        alert("Error:\n" + returndata.responseText);
                        if(returndata.status == 401) {
                            var url = document.referrer;
                            //url = url.substr(0,url.indexOf('/',7))
                            window.top.location.href = url //+ "/login/auth"
                        } else {
                            alert("Error:\n" + returndata.responseText);
                        }
                    }
                });
            } else {
                $("#errorLinkModal").openModal();
            }
        } else {
            $("#errorSubmitingModal").openModal();
        }
    })
}
