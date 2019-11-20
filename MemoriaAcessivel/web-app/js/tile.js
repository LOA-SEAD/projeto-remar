$(document).on('change','#selectCartaA, #selectCartaB',function(){
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

    if(selectedOption == "carregarA") {
        $('#carregarModalA').modal();
        $('#carregarModalA').modal('open');
    }
    if(selectedOption == "carregarB") {
        $('#carregarModalB').modal();
        $('#carregarModalB').modal('open');
    }

    if(selectedOption == "gerar") {
        $('#gerarModal').modal();
        $('#gerarModal').modal('open');
    }
});

