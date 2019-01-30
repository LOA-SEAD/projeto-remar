$(document).ready(function() {

    $('.compartilhaModal').click(function() {
        var id = $(this).closest('.fullCard').data('instance_id');
        var url = location.origin + "/exportedResource/cardInfos/" + id; // envia o id do jogo para gerar o modal de compartilhamento

        $.ajax({
            type: 'GET',
            url:  url,
            data: null,
            processData: false,
            contentType: false,
            success: function (data) {
                $(".modal-content").html(data); // coloca os dados gerados, na view _cardGamesModal dentro de modal-content
                $(".shareModal").openModal(); // abre o modal com a classe shareModal
            },
            error: function (request, status, error) {
                console.log(error);
            }
        });
    });

    $('.deleteExportedResource').click(function(){
        var id = $(this).closest('.fullCard').data('instance_id');
        $('#confirmDeleteExpResource').attr('href', '/exported-resource/delete?id=' + id + '&mode=1');
    });
});