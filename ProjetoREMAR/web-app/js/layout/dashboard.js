/**
 * Created by matheus on 10/8/15.
 */

$(document).ready(function() {

    // Comentado por causa de erros no JS
    // $(...).rateYo is not a function
    /*
   $('.rating-dashboard').each(function() {
        $(this).rateYo({
            readOnly: true,
            precision: 0,
            maxValue: 100,
            starWidth: "13px",
            rating: Number($(this).attr("data-stars"))
        });
    });
    */
});

window.onload = function(){
    var firstAccess = document.getElementById("userFirstAccessLabel").value;
    console.log(firstAccess);
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
};
