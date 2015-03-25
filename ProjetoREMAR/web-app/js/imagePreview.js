/**
 * Created by loa on 11/03/15.
 */
window.onload = function() {


    document.getElementById("icone").onchange = function() {
        Preview(this, document.getElementById("iconePreview"));
        var file;

        if ((file = this.files[0])) {
            var image  = new Image();
            image.src = window.URL.createObjectURL(file);
            image.onload = function () {

                console.log("The image width is " + image.width + " and image height is " + image.height);

            };

        }
    }

    document.getElementById("opening").onchange = function() {
        Preview(this, document.getElementById("openingPreview"));
    }

    document.getElementById("background").onchange = function() {
        Preview(this, document.getElementById("backgroundPreview"));
    }

    function Preview(input, preview) {
        var oFReader = new FileReader();

        oFReader.readAsDataURL(input.files[0]);

        oFReader.onload = function (oFREvent) {
            preview.src = oFREvent.target.result;
        }; }


}

