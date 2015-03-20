/**
 * Created by loa on 11/03/15.
 */
window.onload = function() {


    document.getElementById("icone").onchange = function() {
        Preview(this, document.getElementById("iconePreview"));
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

