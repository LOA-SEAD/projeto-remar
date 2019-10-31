window.onload = function() {

    function validateRecaptcha() {
        var recp = $('#g-recaptcha-response').val();
        if (recp == 0) {
            console.log("aloo");
            alert("Por favor, clique no botão: Não sou um robô ");
            return false;
        }

    }

    $("#submitBtn").click(function(event){
        if(validateRecaptcha()==false){
            event.preventDefault()
        }


    });

}
