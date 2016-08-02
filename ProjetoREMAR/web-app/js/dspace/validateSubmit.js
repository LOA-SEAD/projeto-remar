$( document ).ready(function() {
    var titleError=0;
    var dataError=0
    $("#title-error").hide();
    $("#title").change(function(){
        if($("#title").val()==null || $("#title").val() == ""){
            $("#title-error").show(500);
            $("#title").prev().hide();
            $("#title").removeClass('valid').addClass('invalid');
            titleError=1;

        }
        else {
            $("#title-error").hide();
            $("#title").removeClass('invalid').addClass('valid');
            titleError=0;
        }
    });

    $("#publication_date-error").hide();
    $("#publication_date").change(function(){
        if($("#publication_date").val()==null || $("#publication_date").val() == ""){
            $("#publication_date-error").show(500);
            $("#publication_date").prev().hide();
            $("#publication_date").removeClass('valid').addClass('invalid');
            dataError=1;

        }
        else {
            $("#publication_date-error").hide();
            $("#publication_date").removeClass('invalid').addClass('valid');
            dataError=0;
        }
    });

    

});