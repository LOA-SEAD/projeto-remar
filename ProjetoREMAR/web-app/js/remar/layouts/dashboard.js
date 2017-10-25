/**
 * Created by matheus on 10/8/15.
 */
$(document).ready(function() {
    var firstAccess = document.getElementById("userFirstAccessLabel").value;

    if(firstAccess=="true") {

        startWizard();

        $.ajax({
            url: '/user/setFalseFirstAccess',
            type: 'POST',
            success: function () {
                console.log("Sucess!");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(textStatus + "\n" + errorThrown);
            }
        });
    }
});
