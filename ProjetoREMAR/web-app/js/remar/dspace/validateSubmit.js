var author = $("#author");
var title = $("#title");
var description = $("#description");

function validateAuthor() {
    if( author.val()==null || author.val() == ""){
        $("#author-error").show(500);
        author.removeClass('valid');
        author.addClass('invalid');
        return false;
    }
    else{
        $("#author-error").hide();
        author.removeClass('invalid');
        author.addClass('valid');
        return true;
    }
}

function validateTitle(){
    if($("#title").val()==null || $("#title").val() == ""){
        $("#title-error").show(500);
        title.removeClass('valid').addClass('invalid');
        return false;
    }
    else {
        $("#title-error").hide();
        $("#title").removeClass('invalid').addClass('valid');
        return true;
    }
}
function validateDescription(){
    if( description.val()==null || description.val() == ""){
        description.removeClass('valid').addClass('invalid');
        $("#description-error").show(500);
        return false;
    }
    else{
        description.removeClass('invalid').addClass('valid');
        $("#description-error").hide();
        return true;
    }
}

function validateLicense(){
    return $("#comercialYes").is(":checked") || $("#comercialNo").is(":checked")
}


function validateShare(){
    return $("#shareYes").is(":checked")
}

function validateSubmit(){
    if( validateTitle()
        && validateAuthor()
        && validateDescription()
        && validateShare()
        && validateLicense()){

        $("#nextLabel").hide();
        $("#nextButton").removeClass('hide');
    }
    else{
        $("#nextLabel").show();
        $("#nextButton").addClass('hide');
    }
}

$( document ).ready(function() {

    title.on('input', function() {
        validateSubmit();
    });

    author.on('input', function() {
        validateSubmit();
    });

    description.on('input', function() {
        validateSubmit();
    });

    $("input[type='radio']").change(function(){
        validateSubmit();
    });

});

