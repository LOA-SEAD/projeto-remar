/**
 * Created by marcus on 11/05/16.
 */
function showLicense(){
    if( $("#comercialYes").is(":checked")){
        $("#licenseImage").empty();
        $("#licenseImage").append(" <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>" +
                                  " <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' /> " +
                                  " </a> <br />" +
                                  " Esta obra está licenciado com uma Licença <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional</a>.");
        $("#licenseValue").attr("value", "cc-by-sa");
    }
    else{
        if($("#comercialNo").is(":checked")){
            $("#licenseImage").empty();
            $("#licenseImage").append("<a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'> " +
                                      "<img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />" +
                                      "</a> <br /> " +
                                      " Esta obra está licenciado com uma Licença <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>.");
            $("#licenseValue").attr("value", "cc-by-nc-sa");
            // $("#license-container").show();
        }
    }
    $("#license-container").show();
}

function checkAsLike(){
    $("#shareYesAsLike").prop("checked", true);
}

function bloqCheck(){
    $("#shareYes").attr("checked", false);
    $("#shareNo").attr("checked", false);
    checkAsLike();
}

function validateLicense(){
    if( ($("#comercialYes").is(":checked")) || ($("#comercialNo").is(":checked")) ){
        return true;
    }
    else{
        return false;
    }
}