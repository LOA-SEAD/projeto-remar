function validateSubmit(){
    var error = 0;
    if($("#title").val()==null || $("#title").val() == ""){
        $("#title-error").show(500);
        $("#title").prev().hide();
        $("#title").removeClass('valid').addClass('invalid');
        error=1;

    }
    else {
        $("#title-error").hide();
        $("#title").removeClass('invalid').addClass('valid');
    }

    if(error==0){
        $("#nextLabel").hide();
        $("#nextButton").removeClass('hide');
    }
    else{
        $("#nextLabel").show();
        $("#nextButton").addClass('hide');
    }
}

$( document ).ready(function() {

    $("#title-error").hide();
    validateSubmit();
    $("#title").change(function () {
        validateSubmit();
    })
});

