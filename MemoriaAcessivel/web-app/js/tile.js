$(document).on('change','#selectPergunta, #selectResposta',function(){
    console.log("Um dos SELECT mudou!");
    var selectedOption = $(this).val();
    if(selectedOption == "gravarA") {
        $('#gravarModalA').openModal();
    }
    if(selectedOption == "gravarB") {
        $('#gravarModalB').openModal();
    }


    if(selectedOption == "carregarA") {
        $('#carregarModalA').openModal();
    }
    if(selectedOption == "carregarB") {
        $('#carregarModalB').openModal();
    }


    if(selectedOption == "gerar") {
        $('#gerarModal').openModal();
    }
});
