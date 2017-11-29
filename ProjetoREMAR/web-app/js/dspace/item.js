/**
 * Created by lucasbocanegra on 06/09/16.
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


        }
    }
}

$(document).ready(function () {

    var license = $("#licenseValue");

    if(license.val() == "cc-by-nc-sa"){
        $("#comercialNo").attr("checked", "checked").next().append("* O modelo não permite uso de imagens comerciais");

        $("#licenseImage").empty();
        $("#licenseImage").append("<a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'> " +
            "<img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />" +
            "</a> <br /> " +
            " Esta obra está licenciado com uma Licença <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>.");

        $("#comercialYes").attr("type","hidden").next().hide();
    }


    $('#add-author').on('click', function(){
        $('.div-author .input-field').last().after(' <div class="input-field col s12"> ' +
            '   <input name="author" id="author" type="text" class="validate"> ' +
            '   <label for="author">Autor:</label> ' +
            '   <span class="btn-orange remove-author">remover autor</span> ' +
            '  </div>');
    });

    $('.remove-author').on('click', function(){
        $(this).parent().remove()
    });
});