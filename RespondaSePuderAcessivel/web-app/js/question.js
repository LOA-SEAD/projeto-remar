$(document).on('change','#selectTitle, #selectAlt1, #selectAlt2, #selectAlt3, #selectAlt4, #selectHint',function(){
    console.log("Select Pergunta mudou!");
    var selectedOption = $(this).val();
    console.log(selectedOption);

    if(selectedOption == "gravarTitle") {
        $('#gravarModalTitle').modal();
        $('#gravarModalTitle').modal('open');
    }
    if(selectedOption == "gravarAlt1") {
        $('#gravarModalAlt1').modal();
        $('#gravarModalAlt1').modal('open');
    }
    if(selectedOption == "gravarAlt2") {
        $('#gravarModalAlt2').modal();
        $('#gravarModalAlt2').modal('open');
    }
    if(selectedOption == "gravarAlt3") {
        $('#gravarModalAlt3').modal();
        $('#gravarModalAlt3').modal('open');
    }
    if(selectedOption == "gravarAlt4") {
        $('#gravarModalAlt4').modal();
        $('#gravarModalAlt4').modal('open');
    }
    if(selectedOption == "gravarHint") {
        $('#gravarModalHint').modal();
        $('#gravarModalHint').modal('open');
    }

    if(selectedOption == "carregarTitle") {
        $('#carregarModalTitle').modal();
        $('#carregarModalTitle').modal('open');
    }
    if(selectedOption == "carregarAlt1") {
        $('#carregarModalAlt1').modal();
        $('#carregarModalAlt1').modal('open');
    }
    if(selectedOption == "carregarAlt2") {
        $('#carregarModalAlt2').modal();
        $('#carregarModalAlt2').modal('open');
    }
    if(selectedOption == "carregarAlt3") {
        $('#carregarModalAlt3').modal();
        $('#carregarModalAlt3').modal('open');
    }
    if(selectedOption == "carregarAlt4") {
        $('#carregarModalAlt4').modal();
        $('#carregarModalAlt4').modal('open');
    }
    if(selectedOption == "carregarHint") {
        $('#carregarModalHint').modal();
        $('#carregarModalHint').modal('open');
    }

    if(selectedOption == "gerar") {
        $('#gerarModal').modal();
        $('#gerarModal').modal('open');
    }
});
