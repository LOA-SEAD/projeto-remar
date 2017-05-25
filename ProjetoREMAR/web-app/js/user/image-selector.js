/*
 * Created by Pedro
 */

 // Um modal de seleção de imagem deve se chamar #modal-profile-picture e deve ter dois botões:
 //   Botão para aceitar a imagem com 'id accept-image'
 //   Botão para cancelar com id 'cancel-image'
 // O campo de input para selecionar o arquivo deve ter id 'file'
 // A imagem preview deve ter id 'profile-picture'
 // O input do tipo hidden da preview deve ter id 'source-image'

// Toda vez que o botão de seleção de um arquivo for clicado,
// o valor deste será setado para "null". Mas primeiro vamos salvar
// o valor anterior para, caso o usuário já tenha feito o upload de uma imagem
// e cancele a seleção de uma nova imagem, a antiga não seja perdida
var $profilePicture;
$('#file').on('click', function() {
    $profilePicture = this;
    if (this.value) console.log (this.value);
    this.value = null;
});

var jcrop;
$('#file').on('change', function() {
    var file = $(this).prop('files')[0];
    var fr = new FileReader();

    fr.readAsDataURL(file);
    fr.onload = function(event) {
        var image = new Image();
        image.src = event.target.result;
        image.onload = function() {
            var el = $('#crop-preview');
            $(el).attr('src', event.target.result);

            $('#modal-profile-picture').openModal({
                dismissible: false
            });

            // Ação a ser feita caso o botão para aceitar seja clicado
            $('#accept-picture').unbind('click');
            $('#accept-picture').click(function() {
                var formData = new FormData();
                var coordinates = jcrop.tellSelect();
                formData.append('photo', file);
                formData.append('x', coordinates.x);
                formData.append('y', coordinates.y);
                formData.append('w', coordinates.w);
                formData.append('h', coordinates.h);

                $.ajax({
                    type: 'POST',
                    url: "user/crop-profile-picture",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        $('#profile-picture').attr("src", "/data/tmp/" + data);
                        $('#source-image').attr("value", "/data/tmp/" + data);
                    },
                    error: function(req, res, err) {
                        console.log(req);
                        console.log(res);
                        console.log(err);
                    }
                });

                $('#modal-profile-picture').closeModal();

                jcrop.destroy();
                $('.jcrop-holder').remove();
                $(el).removeAttr('style');

                console.log ('Profile Picture Accepted');
                console.log ($('#file').value);
            });

            // Ação a ser feita caso o botão de cancelar seja clicado
            $('#cancel-picture').unbind('click');
            $('#cancel-picture').click(function() {
                // Caso o usuário cancele a imagem, para resetar o campo de input
                // referente à seleção de arquivo, o campo é clonado
                // e substituído pelo clone
                var $fileInput = $('.file-path-wrapper input');
                $fileInput.replaceWith($fileInput.val(null).clone(true));

                // Se já havia uma imagem selecionada antes, retorna o valor dela
                if ($profilePicture) {
                    $fileInput.val($profilePicture.value);
                }

                $('#modal-profile-picture').closeModal();

                jcrop.destroy();
                $('.jcrop-holder').remove();
                $(el).removeAttr('style');

                console.log ('Profile Picture Cancelled');
                console.log ($('#file').value);
            });


            $(el).Jcrop({
                aspectRatio: 1,
                setSelect: [0, 0, Math.max(this.width, this.height), Math.max(this.width, this.height)],
                boxHeight: 500,
                trueSize: [this.width, this.height]
            }, function () {
                jcrop = this;
            });
        }
    }
});
