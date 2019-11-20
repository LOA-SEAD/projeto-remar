$(document).on('change','#selectCartaA, #selectCartaB, #selectDescription',function(){
    console.log("Um dos SELECT mudou!");
    var selectedOption = $(this).val();
    if(selectedOption == "gravarA") {
        $('#gravarModalA').modal();
        $('#gravarModalA').modal('open');
    }
    if(selectedOption == "gravarB") {
        $('#gravarModalB').modal();
        $('#gravarModalB').modal('open');
    }
    if(selectedOption == "gravarDescription") {
        $('#gravarModalDescription').modal();
        $('#gravarModalDescription').modal('open');
    }

    if(selectedOption == "carregarA") {
        $('#carregarModalA').modal();
        $('#carregarModalA').modal('open');
    }
    if(selectedOption == "carregarB") {
        $('#carregarModalB').modal();
        $('#carregarModalB').modal('open');
    }
    if(selectedOption == "carregarDescription") {
        $('#carregarModalDescription').modal();
        $('#carregarModalDescription').modal('open');
    }

    if(selectedOption == "gerar") {
        $('#gerarModal').modal();
        $('#gerarModal').modal('open');
    }
});

