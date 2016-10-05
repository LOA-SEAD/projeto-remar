var author = $("#author");
var editor = $("#editor");
var citation = $("#citation");
var description = $("#description");
var error = 0;

function validateSubmit(){
    error =0;
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

    validateAuthor();
    validadteCitation();
    validateDescription();
    validateLicense();


    if(error==0){
        $("#nextLabel").hide();
        $("#nextButton").removeClass('hide');
    }
    else{
        $("#nextLabel").show();
        $("#nextButton").addClass('hide');
    }
}
function validateAuthor() {
    if( author.val()==null || author.val() == ""){
        author.removeClass('valid').addClass('invalid');
        $("#author-error").show(500);
        error =1;
    }
    else{
        author.removeClass('invalid').addClass('valid');
        $("#author-error").hide();
    }
}

function validadteCitation(){
    if( citation.val()==null || citation.val() == ""){
        citation.removeClass('valid').addClass('invalid');
        $("#citation-error").show(500);
        error=1;
    }
    else{
        citation.removeClass('invalid').addClass('valid');
        $("#citation-error").hide();
    }
}
function validateDescription(){
    if( description.val()==null || description.val() == ""){
        description.removeClass('valid').addClass('invalid');
        $("#description-error").show(500);
        error=1;
    }
    else{
        description.removeClass('invalid').addClass('valid');
        $("#description-error").hide();
    }
}

function validateLicense(){
    if($("#licenseValue").val()=="cc-by"){
        error=1;
    }
}


function checkAsLike(){
    $("#shareYesAsLike").prop("checked", true);
}

function bloqCheck(){
    $("#shareYes").attr("checked", false);
    $("#shareNo").attr("checked", false);
    checkAsLike();
}

$( document ).ready(function() {

    $("#title-error").hide();
    $("#author-error").hide();
    $("#description-error").hide();
    $("#abstract-error").hide();
    $("#citation-error").hide();

    validateSubmit();
    $("#title").on('input', function() {
        validateSubmit();
    });

    author.on('input', function() {
        validateSubmit();
    });

    editor.on('input', function() {
        validateSubmit();
    });

    citation.on('input', function() {
        validateSubmit();
    });

    description.on('input', function() {
        validateSubmit();
    });

});

