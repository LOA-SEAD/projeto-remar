/**
 * Created by marcus on 11/05/16.
 */
$(function () {
    var license = document.getElementById("licenseValue").value;
    var comercial = "cc-by-sa";
    var notComercial = "cc-by-nc-sa";

    if(license==comercial){
        $("#licenseInfo").empty();
        $("#licenseInfo").append("<p>Licença</p>");
        $("#licenseInfo").append(" <div class='row center-align'> <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>" +
            " <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' /> " +
            " </a>");
        $("#licenseInfo").append("This work is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Attribution-ShareAlike 4.0 International License</a>.</div>");

    }
    else{
        if(license==notComercial){
            $("#licenseInfo").empty();
            $("#licenseInfo").append("<p>Licença</p>");
            $("#licenseInfo").append(" <div class='row center-align'> <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'> " +
                "<img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />" +
                "</a> ");
            $("#licenseInfo").append(" This work is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>. </div>");

        }
    }
});