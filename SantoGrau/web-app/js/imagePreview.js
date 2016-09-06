/**
 * Created by leticia on 05/09/16.
 */

window.onload = function() {
    document.getElementById("img-1").onchange = function () {
        var el = $("#img-1-preview");
        $(el).attr("style", "");
        $(el).addClass("img-responsive");
        preview(this, document.getElementById("img-1-preview"));
        $(el).attr("data-current", "1");
    };

    document.getElementById("img-2").onchange = function () {
        var el = $("#img-2-preview");
        $(el).attr("style", "");
        $(el).addClass("img-responsive");
        preview(this, document.getElementById("img-2-preview"));
        $(el).attr("data-current", "1");
    };

    document.getElementById("img-3").onchange = function () {
        var el = $("#img-3-preview");
        $(el).attr("style", "");
        $(el).addClass("img-responsive");
        preview(this, document.getElementById("img-3-preview"));
        $(el).attr("data-current", "1");
    };

    document.getElementById("img-4").onchange = function () {
        var el = $("#img-4-preview");
        $(el).attr("style", "");
        $(el).addClass("img-responsive");
        preview(this, document.getElementById("img-4-preview"));
        $(el).attr("data-current", "1");
    };


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

    function preview(input, preview) {
        var oFReader = new FileReader();

        oFReader.readAsDataURL($(input).prop("files")[0]);

        oFReader.onload = function (oFREvent) {
            preview.src = oFREvent.target.result;
        };


    }
}


