var author = $("#author");
var editor = $("#editor");
var citation = $("#citation");
var description = $("#description");
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
function validateAuthor() {
    if( author.val()==null || author.val() == ""){
        author.removeClass('valid').addClass('invalid');
    }
    else{
        author.removeClass('invalid').addClass('valid');
    }
}
function validateEditor() {
    if( editor.val()==null || editor.val() == ""){
        editor.removeClass('valid').addClass('invalid');
    }
    else{
        editor.removeClass('invalid').addClass('valid');
    }
}
function validadteCitation(){
    if( citation.val()==null || citation.val() == ""){
        citation.removeClass('valid').addClass('invalid');
    }
    else{
        citation.removeClass('invalid').addClass('valid');
    }
}
function validateDescription(){
    if( description.val()==null || description.val() == ""){
        description.removeClass('valid').addClass('invalid');
    }
    else{
        description.removeClass('invalid').addClass('valid');
    }
}


$( document ).ready(function() {

    $("#title-error").hide();
    validateSubmit();
    $("#title").change(function () {
        validateSubmit();
        validateAuthor();
        validateEditor();
        validadteCitation();
        validateDescription();
    });

    author.change(function () {
        validateSubmit();
        validateAuthor();
        validateEditor();
        validadteCitation();
        validateDescription();
    });

    editor.change(function () {
        validateSubmit();
        validateAuthor();
        validateEditor();
        validadteCitation();
        validateDescription();
    });

    citation.change(function () {
        validateSubmit();
        validateAuthor();
        validateEditor();
        validadteCitation();
        validateDescription();
    });

    description.change(function () {
        validateSubmit();
        validateAuthor();
        validateEditor();
        validadteCitation();
        validateDescription();
    });


});

