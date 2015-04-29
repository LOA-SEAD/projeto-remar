/**
 * Created by loa on 11/03/15.
 */
window.onload = function() {

    document.getElementById("icone").onchange = function () {
        Preview(this, document.getElementById("iconePreview"));
        if(verifyDimensions(this)){

        }

    }


    document.getElementById("opening").onchange = function () {
        Preview(this, document.getElementById("openingPreview"));
        (verifyDimensions(this))

    }

    document.getElementById("background").onchange = function () {
        Preview(this, document.getElementById("backgroundPreview"));
        (verifyDimensions(this))
    }



    function verifyDimensions(input) {
        var file;
        var inputs = document.getElementsByTagName('input');
        if ((file = input.files[0])) {
            console.log(input.files[0]);
            image = new Image();
            image.src = window.URL.createObjectURL(file);
            console.log("antes de entrar no onload da imagem");
            image.onload = function () {
                console.log("The image width is " + image.width + " and image height is " + image.height);
                if ((image.width < 800) || (image.height < 600)) {
                        alert("Alguma das imagens contém tamanho invalido. Resolução mínima: 800x600");
                       input.setAttribute('data-image','false');
                        image.pop;
                }
                else{
                    if(input.getAttribute('data-image') == 'false'){
                        input.setAttribute('data-image','true');
                        image.pop;
                    }
                    else {
                        input.setAttribute('data-image','true');
                        image.pop;
                    }
                }

                for(var i=0; i<inputs.length; i++) {
                    var data = inputs[i].getAttribute('data-image');
                    console.log("Data: "+data);
                    if (data == 'false') {
                        $('#upload').prop('disabled', true);
                        break;
                    }
                    else
                        $('#upload').prop('disabled', false);
                }
            }

        }

    }

    function Preview(input, preview) {
        var oFReader = new FileReader();

        oFReader.readAsDataURL(input.files[0]);

        oFReader.onload = function (oFREvent) {
            preview.src = oFREvent.target.result;
        };


    }
}


