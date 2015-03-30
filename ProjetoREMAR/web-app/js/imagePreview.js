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
        if ((file = input.files[0])) {
            console.log(input.files[0]);
            image = new Image();
            image.src = window.URL.createObjectURL(file);
            console.log("antes de entrar no onload da imagem");
            image.onload = function () {
                console.log("The image width is " + image.width + " and image height is " + image.height);
                if ((image.width < 800) || (image.height < 600)) {

                        alert("Alguma das imagens contém tamanho invalido. Resolução mínima: 800x600");

                        console.log("LOG INVALIDO - The image width is " + image.width + " and image height is " + image.height);
                        //document.getElementById('form').setAttribute('data-image', 'false');
                        $('#form').attr('data-image','false');
                        image.pop;
                        // $('#upload').prop('disabled', true);

                }
                else{
                    if(document.getElementById('form').getAttribute('data-image') == 'false'){
                        console.log("data-image ja esta falso");
                        document.getElementById('form').setAttribute('data-image', 'true');
                        image.pop;
                    }
                    else {
                        console.log("else do TRUE");
                        document.getElementById('form').setAttribute('data-image', 'true');
                        image.pop;
                        // $('#upload').prop('disabled', false);

                    }
                }
                console.log("VALOR DA TAG DA IMAGE: " + document.getElementById('form').getAttribute('data-image'));
                if(document.getElementById('form').getAttribute('data-image') == 'false')
                    $('#upload').prop('disabled', true);
                else if (document.getElementById('form').getAttribute('data-image') == 'true')
                        $('#upload').prop('disabled', false);
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


