/**
 * Created by leticia on 12/09/16.
 */
$(document).ready(function() {
    $('select').material_select();
});

window.onload = function() {

    $("#submitButton").click(function() {
        if ($("#palavras1").val() != "" && $("#palavras2").val() != "" && $("#palavras3").val() != "" && $("#orientacao").val() != "") {
            var words = [];
            var link = $("#link").val();
            var tipoLink = $("#tipo-link").val();

            words.push($("#palavras1").val());
            words.push($("#palavras2").val());
            words.push($("#palavras3").val());

            console.log("PALAVRAS: " + words);

            //Chama controlador para salvar questões em arquivos .json
            $.ajax({
                type: "POST",
                traditional: true,
                url: "/santograu/faseTecnologia/exportLevel",
                data: {words: words, link: link, tipoLink: tipoLink},
                success: function (returndata) {
                    window.top.location.href = returndata;
                },
                error: function (returndata) {
                    alert("Error:\n" + returndata.responseText);
                }
            });
        }
    })
}
