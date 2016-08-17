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

    validateSubmit();
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
    $("#title").change(function () {
        validateSubmit();
    });

    author.change(function () {
        validateSubmit();
    });

    editor.change(function () {
        validateSubmit();
    });

    citation.change(function () {
        validateSubmit();
    });

    description.change(function () {
        validateSubmit();
    });

});

