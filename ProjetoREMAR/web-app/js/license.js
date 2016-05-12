/**
 * Created by marcus on 11/05/16.
 */
$(function() {
    $("#comercialYes").attr("checked", false);
    $("#comercialNo").attr("checked", true);
});

function showLicense(){
    if( $("#comercialYes").is(":checked")){
        $("#licenseImage").empty();
        $("#licenseImage").append(" <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>" +
                                  " <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' /> " +
                                  " </a> <br />" +
                                  " This work is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Attribution-ShareAlike 4.0 International License</a>.");
        $("#licenseValue").attr("value", "cc-by-sa");
    }
    else{
        if($("#comercialNo").is(":checked")){
            $("#licenseImage").empty();
            $("#licenseImage").append("<a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'> " +
                                      "<img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />" +
                                      "</a> <br /> " +
                                      " This work is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.");
            $("#licenseValue").attr("value", "cc-by-nc-sa");

        }
    }
}

function checkAsLike(){
    $("#shareYesAsLike").attr("checked", "checked");
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