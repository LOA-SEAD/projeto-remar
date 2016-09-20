/**
 * Created by lucasbocanegra on 06/09/16.
 */

function localStorageAvailable() {
    if (typeof(Storage) !== "undefined") {
        return true;
    }else {
        return false;
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

    if (localStorageAvailable()) {
        if (localStorage.DoNotShowMessageAgain && localStorage.DoNotShowMessageAgain === "true") {
            // user doesn't want to see the message again, so handle accordingly
        }else{
            //$('#messenger').openModal();
        }
    }

    $('#show-messenger').click(function(){
        console.log("entrou aki!");
        if (this.checked) {
            console.log("checked");

            if (localStorageAvailable()){
                console.log("entramos aki");
                localStorage.DoNotShowMessageAgain = "true";
                console.log(localStorage.DoNotShowMessageAgain);
            }
        }else{
            console.log("don't checked");

            localStorage.DoNotShowMessageAgain = "false"
        }
    });

    $('#add-author').on('click', function(){
        $('.div-author .input-field').last().after(' <div class="input-field col s12"> ' +
            '   <input name="author" id="author" type="text" class="validate"> ' +
            '   <label for="author">Autor:</label> ' +
            '  </div>');
    });

});