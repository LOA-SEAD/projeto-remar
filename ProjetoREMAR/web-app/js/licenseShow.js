/**
 * Created by marcus on 11/05/16.
 */
$(function () {
    $('.materialboxed').materialbox();

    var license = document.getElementById("licenseValue").value;
    var comercial = "cc-by-sa";
    var notComercial = "cc-by-nc-sa";

    if(license==comercial){
        $("#licenseInfo").empty();
        $("#licenseInfo").append(" <div class='row center-align'> <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>" +
            " <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' /> " +
            " </a>");
        $("#licenseInfo").append("Esta obra está licenciada com uma Licença <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional</a>.</div>");

    }
    else{
        if(license==notComercial){
            $("#licenseInfo").empty();
            $("#licenseInfo").append(" <div class='row center-align'> <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'> " +
                "<img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />" +
                "</a> ");
            $("#licenseInfo").append("Esta obra está licenciada com uma Licença <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>.</div>");

        }
    }
});

$('#submit').on('click', function() {
    if(!grecaptcha.getResponse().length) {
        return false;
    }
});

