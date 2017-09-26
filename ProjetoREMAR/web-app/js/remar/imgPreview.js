
$(function() {

    //console.log("imagenPreview carregada");


    document.getElementById("img-1").onchange = function (evt) {
        var files = evt.target.files;
        console.log(files);
        Preview(this, document.getElementById("img1Preview"));
        (verifyDimensions(this));
        //  if(verifyDimensions(this)){

        // }
    };

    //document.getElementById("img-1").onblur = function (){
    //    Preview(this, document.getElementById("img1Preview"));
    //    (verifyDimensions(this));
    //
    //};


    document.getElementById("img-2").onchange = function () {
        Preview(this, document.getElementById("img2Preview"));
        (verifyDimensions(this))

    };

    document.getElementById("img-3").onchange = function () {
        Preview(this, document.getElementById("img3Preview"));
        (verifyDimensions(this))
    };



    function verifyDimensions(input) {
        var file;
        var inputs = document.getElementsByTagName('input');
        if ((file = input.files[0])) {

            console.log(input.files[0]);

            image = new Image();
            image.src = window.URL.createObjectURL(file);


            image.onload = function () {
                console.log("The image width is " + image.width + " and image height is " + image.height);
                //
                //if ((image.width < 800) || (image.height < 600)) {
                //    alert("Alguma das imagens contém tamanho invalido. Resolução mínima: 800x600");
                //    input.setAttribute('data-image','false');
                //    image.pop;
                //}
                //else{
                //    if(input.getAttribute('data-image') == 'false'){
                //        input.setAttribute('data-image','true');
                //        image.pop;
                //    }
                //    else {
                //        input.setAttribute('data-image','true');
                //        image.pop;
                //    }
                //}

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

        if(input.files ==  null){console.log("campo vazio")}

        oFReader.readAsDataURL(input.files[0]);

        oFReader.onload = function (oFREvent) {
            preview.src = oFREvent.target.result;
        };


    }
});


