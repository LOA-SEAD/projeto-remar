$("#ocultar").click(function () {
    $("#exemplo1").toggle();
    var isChecked = $('#audioPergunta1').prop('checked');
    if (isChecked == true) {
        $("#audioPergunta1").prop("checked", false)
    }
    else {
        $("#audioPergunta1").prop("checked", true)
    }
});


$(document).on('change','#selectPergunta, #selectResposta',function(){
    console.log("Select Pergunta mudou!");
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
