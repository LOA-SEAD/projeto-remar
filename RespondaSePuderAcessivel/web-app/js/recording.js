/*
    Código feito por Túlio Reis, fortemente baseado e adaptado de https://blog.addpipe.com/using-recorder-js-to-capture-wav-audio-in-your-html5-web-site/
    O código intercepta o submit dos formulários (#submit) para poder capturar e enviar manualmente os áudios gravados e carregados.
 */

var countTitle = 1;
var countAlt1= 1;
var countAlt2 = 1;
var countAlt3 = 1;
var countAlt4 = 1;
var countHint = 1;
var currentRecordingCard = "Title";
$(document).ready(function() {
    // Disable send button after submit the form
    $('form.sendForm').submit(function(){
        $(this).find(':input[type=submit]').prop('disabled', true);
    });

    $('#back').click(function() {
        var getUrl = window.location;
        var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];

        window.location.href = baseUrl + "/question/index";
    });

    // autoplay selected audio
    $("#recordingsListTitle, #recordingsListAlt1, #recordingsListAlt2, #recordingsListAlt3, #recordingsListAlt4, #recordingsListHint").delegate("input[type=radio]", "change", function (){
        $(this).parent().siblings("audio")[0].play();
    });

    // Submit form button click function
    $("#submit").click(function() {
        fd = new FormData();
        var selectTitle = $("#selectTitle :selected").val();


        if (selectTitle == "gravarTitle") {
            if ($("input[name=audioA]:checked").parent().siblings("audio")[0] != null) {
                var audioAurl = $("input[name=audioA]:checked").parent().siblings("audio")[0].src;

                var xhr = new XMLHttpRequest();
                xhr.open('GET', audioAurl);
                xhr.responseType = 'blob';
                xhr.onload = function (e) {
                    recoverBlobB(xhr.response)
                };
                xhr.send();
            }
            else {
                $('#gravarModalTitle').modal();
                $('#gravarModalTitle').modal('open');
                Materialize.toast("Grave e selecione o áudio da pergunta para prosseguir", displayLength='3000');
            }
        }
        else {
            recoverBlobB(null)
        }
    });

});


function recoverBlobB(blobA) {
    var selectAlt1 = $("#selectAlt1 :selected").val();

    if(selectAlt1 == "gravarAlt2") {
        if (audioBurl = $("input[name=audioB]:checked").parent().siblings("audio")[0] != null) {
            var audioBurl = $("input[name=audioB]:checked").parent().siblings("audio")[0].src;
            var xhr = new XMLHttpRequest();
            xhr.open('GET', audioBurl);
            xhr.responseType = 'blob';
            xhr.onload = function (e) {
                recoverBlobC(blobA, xhr.response)
            };
            xhr.send();
        } else {
            $('#gravarModalAlt1').modal();
            $('#gravarModalAlt1').modal('open');
            Materialize.toast("Grave e selecione o áudio da alternativa 1 para poder prosseguir", displayLength='3000');
        }
    }
    else {
        recoverBlobC(blobA, null)
    }
}


function recoverBlobC(blobA, blobB) { // blob da description
    var selectAlt2 = $("#selectAlt2 :selected").val();

    if(selectAlt2 == "gravarAlt2") {
        if (audioCurl = $("input[name=audioC]:checked").parent().siblings("audio")[0] != null) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', audioCurl);
            xhr.responseType = 'blob';
            xhr.onload = function (e) {
                recoverBlobD(blobA, blobB, xhr.response)
            };
            xhr.send();
        } else {
            $('#gravarModalAlt2').modal();
            $('#gravarModalAlt2').modal('open');
            Materialize.toast("Grave e selecione o áudio da alternativa 2 para poder prosseguir", displayLength='3000');
        }
    }
    else {
        recoverBlobD(blobA, blobB, null)
    }
}

function recoverBlobD(blobA, blobB, blobC) { // blob da description
    var selectAlt3 = $("#selectAlt3 :selected").val();

    if(selectAlt3 == "gravarAlt3") {
        if (audioDurl = $("input[name=audioD]:checked").parent().siblings("audio")[0] != null) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', audioDurl);
            xhr.responseType = 'blob';
            xhr.onload = function (e) {
                recoverBlobE(blobA, blobB, blobC, xhr.response)
            };
            xhr.send();
        } else {
            $('#gravarModalAlt3').modal();
            $('#gravarModalAlt3').modal('open');
            Materialize.toast("Grave e selecione o áudio da alternativa 3 para poder prosseguir", displayLength='3000');
        }
    }
    else {
        recoverBlobE(blobA, blobB, blobC, null)
    }
}

function recoverBlobE(blobA, blobB, blobC, blobD) { // blob da description
    var selectAlt4 = $("#selectAlt4 :selected").val();

    if(selectAlt4 == "gravarAlt4") {
        if (audioEurl = $("input[name=audioE]:checked").parent().siblings("audio")[0] != null) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', audioEurl);
            xhr.responseType = 'blob';
            xhr.onload = function (e) {
                recoverBlobF(blobA, blobB, blobC, blobD, xhr.response)
            };
            xhr.send();
        } else {
            $('#gravarModalAlt4').modal();
            $('#gravarModalAlt4').modal('open');
            Materialize.toast("Grave e selecione o áudio da alternativa 4 para poder prosseguir", displayLength='3000');
        }
    }
    else {
        recoverBlobF(blobA, blobB, blobC, blobD, null)
    }
}

function recoverBlobF(blobA, blobB, blobC, blobD, blobE) { // blob da description
    var selectHint = $("#selectHint :selected").val();

    if(selectHint == "gravarHint") {
        if (audioFurl = $("input[name=audioF]:checked").parent().siblings("audio")[0] != null) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', audioFurl);
            xhr.responseType = 'blob';
            xhr.onload = function (e) {
                sendFormData(blobA, blobB, blobC, blobD, blobE, xhr.response)
            };
            xhr.send();
        } else {
            $('#gravarModalHint').modal();
            $('#gravarModalHint').modal('open');
            Materialize.toast("Grave e selecione o áudio da dica para poder prosseguir", displayLength='3000');
        }
    }
    else {
        sendFormData(blobA, blobB, blobC, blobD, blobE, null)
    }
}


function sendFormData(blobA, blobB, blobC, blobD, blobE, blobF) {

    var title = $("input[name=title]").val();
    var answer1 = $("input[name=answer1]").val();
    var answer2 = $("input[name=answer2]").val();
    var answer3 = $("input[name=answer3]").val();
    var answer4 = $("input[name=answer4]").val();
    var hint = $("input[name=hint]").val();
    var questionID = $("input[name=questionID]").val();
    var level = $("#selectLevel :selected").val();
    var selectTitle = $("#selectTitle :selected").val();
    var selectAlt1 = $("#selectAlt1 :selected").val();
    var selectAlt2 = $("#selectAlt2 :selected").val();
    var selectAlt3 = $("#selectAlt3 :selected").val();
    var selectAlt4 = $("#selectAlt4 :selected").val();
    //var correctAnswer = $("#selectRespCorreta :selected").val();
    var selectHint = $("#selectHint :selected").val();
    var fd = new FormData();


    // Carregamento e checagem dos áudios
    if ((blobA != null) && (selectTitle == "gravarTitle")){
        fd.append("audioTitle", blobA, new Date().toISOString());
    }
    if ((blobB != null) && (selectAlt1 == "gravarAlt1")){
        fd.append("audioAlt1", blobB, new Date().toISOString());
    }
    if ((blobC != null) && (selectAlt2 == "gravarAlt2")){
        fd.append("audioAlt2", blobC, new Date().toISOString());
    }
    if ((blobD != null) && (selectAlt3 == "gravarAlt3")){
        fd.append("audioAlt3", blobD, new Date().toISOString());
    }
    if ((blobE != null) && (selectAlt4 == "gravarAlt4")){
        fd.append("audioAlt4", blobE, new Date().toISOString());
    }
    if ((blobF != null) && (selectHint == "gravarHint")){
        fd.append("audioHint", blobF, new Date().toISOString());
    }


    if (selectTitle == "carregarTitle"){
        if ($("#audio-1")[0].files[0] != null) {
            fd.append("audio-1", $("#audio-1")[0].files[0])
        }
        else {
            $('#carregarModalTitle').modal();
            $('#carregarModalTitle').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da pergunta para poder prosseguir", displayLength='3000');
        }
    }

    if (selectAlt1 == "carregarAlt1"){
        if ($("#audio-2")[0].files[0] != null) {
            fd.append("audio-2", $("#audio-2")[0].files[0]);
        }
        else {
            $('#carregarModalAlt1').modal();
            $('#carregarModalAlt1').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da alternativa 1 para poder prosseguir", displayLength='3000');
        }
    }

    if (selectAlt2 == "carregarAlt2"){
        if ($("#audio-3")[0].files[0] != null) {
            fd.append("audio-3", $("#audio-3")[0].files[0]);
        }
        else {
            $('#carregarModalAlt2').modal();
            $('#carregarModalAlt2').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da alternativa 2 para poder prosseguir", displayLength='3000');
        }
    }

    if (selectAlt3 == "carregarAlt3"){
        if ($("#audio-4")[0].files[0] != null) {
            fd.append("audio-4", $("#audio-4")[0].files[0]);
        }
        else {
            $('#carregarModalAlt3').modal();
            $('#carregarModalAlt3').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da alternativa 3 para poder prosseguir", displayLength='3000');
        }
    }

    if (selectAlt4 == "carregarAlt4"){
        if ($("#audio-5")[0].files[0] != null) {
            fd.append("audio-5", $("#audio-5")[0].files[0]);
        }
        else {
            $('#carregarModalAlt4').modal();
            $('#carregarModalAlt4').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da alternativa 4 para poder prosseguir", displayLength='3000');
        }
    }

    if (selectHint == "carregarHint"){
        if ($("#audio-6")[0].files[0] != null) {
            fd.append("audio-6", $("#audio-6")[0].files[0]);
        }
        else {
            $('#carregarModalHint').modal();
            $('#carregarModalHint').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da dica para poder prosseguir", displayLength='3000');
        }
    }

    /* if (correctAnswer == "selecione"){
        Materialize.toast("Selecione qual é a alternativa correta para poder prosseguir", displayLength='3000');
    } */


    // Carregamento dos itens restantes (como parâmetros para o controlador)

    fd.append("level", level)
    fd.append("title", title)
    fd.append("answer1", answer1)
    fd.append("answer2", answer2)
    fd.append("answer3", answer3)
    fd.append("answer4", answer4)
    fd.append("hint", hint)
    //fd.append("correctAnswer", correctAnswer)
    fd.append("questionID", questionID)
    fd.append("selectTitle", selectTitle)
    fd.append("selectAlt1", selectAlt1)
    fd.append("selectAlt2", selectAlt2)
    fd.append("selectAlt3", selectAlt3)
    fd.append("selectAlt4", selectAlt4)
    fd.append("selectHint", selectHint)


    if ((selectTitle == "gerar" || selectAlt1 == "gerar") || (selectAlt2 == "gerar") || (selectAlt3 == "gerar") || (selectAlt4 == "gerar") || (selectHint == "gerar")) {
        Materialize.toast("Aguarde um momento que o áudio do texto está sendo gerado...");
    }

    if (questionID) {

        console.log("update")
        // O formulário só continua se todos os campos de áudio estiverem devidamente designados (vazios ou preenchidos)
        if (((blobA != null) || ($("#audio-1")[0].files[0] != null) || (selectTitle == "gerar")) || (selectTitle == "naoeditar") &&
            ((blobB != null) || ($("#audio-2")[0].files[0] != null) || (selectAlt1 == "gerar")) || (selectAlt1 == "naoeditar") &&
            ((blobC != null) || ($("#audio-3")[0].files[0] != null) || (selectAlt2 == "gerar")) || (selectAlt2 == "naoeditar") &&
            ((blobD != null) || ($("#audio-4")[0].files[0] != null) || (selectAlt3 == "gerar")) || (selectAlt3 == "naoeditar") &&
            ((blobE != null) || ($("#audio-5")[0].files[0] != null) || (selectAlt4 == "gerar")) || (selectAlt4 == "naoeditar") &&
            ((blobF != null) || ($("#audio-6")[0].files[0] != null) || (selectHint == "gerar") || (selectHint == "naoeditar"))) {

            // significa que tem uma ID, e isso significa que está na tela de edição, então chama o controlador de edição (update)
            $.ajax({
                method: "POST",
                url: "/respondasepuderacessivel/question/update",
                contentType: false,
                processData: false,
                data: fd,
                success: function (response) {
                    window.location.href = '../index';
                }
            });
        }
    }
    else {

        if (((blobA != null) || ($("#audio-1")[0].files[0] != null) || (selectTitle == "gerar")) &&
            ((blobB != null) || ($("#audio-2")[0].files[0] != null) || (selectAlt1 == "gerar")) &&
            ((blobC != null) || ($("#audio-3")[0].files[0] != null) || (selectAlt2 == "gerar")) &&
            ((blobD != null) || ($("#audio-4")[0].files[0] != null) || (selectAlt3 == "gerar")) &&
            ((blobE != null) || ($("#audio-5")[0].files[0] != null) || (selectAlt4 == "gerar")) &&
            ((blobF != null) || ($("#audio-6")[0].files[0] != null) || (selectHint == "gerar"))) {

            // significa que está na tela do create, chama o controlador de salvar
            $.ajax({
                method: "POST",
                url: "/respondasepuderacessivel/question/save",
                contentType: false,
                processData: false,
                data: fd,
                success: function (response) {
                    window.location.href = 'index';
                },
                error: function (response) {
                    console.log(response)
                }
            });
        }
    }
}

// Trecho do código responsável pela captura de áudio e funcionamento dos botões dos áudios
//webkitURL is deprecated but nevertheless
URL = window.URL || window.webkitURL;

var gumStream; //stream from getUserMedia()
var rec; //Recorder.js object
var input; //MediaStreamAudioSourceNode we'll be recording

// shim for AudioContext when it's not avb.
var AudioContext = window.AudioContext || window.webkitAudioContext;
var audioContext = new AudioContext; //new audio context to help us record

var recordButtonTitle = document.getElementById("recordButtonTitle");
var stopButtonTitle = document.getElementById("stopButtonTitle");
var pauseButtonTitle = document.getElementById("pauseButtonTitle");

var recordButtonAlt1 = document.getElementById("recordButtonAlt1");
var stopButtonAlt1 = document.getElementById("stopButtonAlt1");
var pauseButtonAlt1 = document.getElementById("pauseButtonAlt1");

var recordButtonAlt2 = document.getElementById("recordButtonAlt2");
var stopButtonAlt2 = document.getElementById("stopButtonAlt2");
var pauseButtonAlt2 = document.getElementById("pauseButtonAlt2");

var recordButtonAlt3 = document.getElementById("recordButtonAlt3");
var stopButtonAlt3 = document.getElementById("stopButtonAlt3");
var pauseButtonAlt3 = document.getElementById("pauseButtonAlt3");

var recordButtonAlt4 = document.getElementById("recordButtonAlt4");
var stopButtonAlt4 = document.getElementById("stopButtonAlt4");
var pauseButtonAlt4 = document.getElementById("pauseButtonAlt4");

var recordButtonHint = document.getElementById("recordButtonHint");
var stopButtonHint = document.getElementById("stopButtonHint");
var pauseButtonHint = document.getElementById("pauseButtonHint");

function startRecording() {
    console.log("Recording requested.");

    /*
    Simple constraints object, for more advanced audio features see
    <div class="video-container"><blockquote class="wp-embedded-content" data-secret="cVHlrYJoGD"><a href="https://addpipe.com/blog/audio-constraints-getusermedia/">Supported Audio Constraints in getUserMedia()</a></blockquote><iframe class="wp-embedded-content" sandbox="allow-scripts" security="restricted" style="position: absolute; clip: rect(1px, 1px, 1px, 1px);" src="https://addpipe.com/blog/audio-constraints-getusermedia/embed/#?secret=cVHlrYJoGD" data-secret="cVHlrYJoGD" width="600" height="338" title="“Supported Audio Constraints in getUserMedia()” — Pipe Blog" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
    */

    var constraints = { audio: true, video: false }

    /*
    Disable the record button until we get a success or fail from getUserMedia()
    */
    /*
    recordButton.disabled = true;
    stopButton.disabled = false;
    pauseButton.disabled = false;
*/
    if (this.id == "recordButtonTitle") {
        recordButtonTitle.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "A"; // Referente à Pergunta (title)
        $(recordButtonTitle).attr("disabled", "");
        $(recordButtonAlt1).attr("disabled", "");
        $(recordButtonAlt2).attr("disabled", "");
        $(recordButtonAlt3).attr("disabled", "");
        $(recordButtonAlt4).attr("disabled", "");
        $(recordButtonHint).attr("disabled", "");

        $(pauseButtonTitle).removeAttr("disabled");
        $(stopButtonTitle).removeAttr("disabled");
    }
    if (this.id == "recordButtonAlt1") {
        recordButtonAlt1.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "B"; // Referente à Pergunta (title)
        $(recordButtonTitle).attr("disabled", "");
        $(recordButtonAlt1).attr("disabled", "");
        $(recordButtonAlt2).attr("disabled", "");
        $(recordButtonAlt3).attr("disabled", "");
        $(recordButtonAlt4).attr("disabled", "");
        $(recordButtonHint).attr("disabled", "");

        $(pauseButtonAlt1).removeAttr("disabled");
        $(stopButtonAlt1).removeAttr("disabled");
    }
    if (this.id == "recordButtonAlt2") {
        recordButtonAlt2.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "C"; // Referente à Pergunta (title)
        $(recordButtonTitle).attr("disabled", "");
        $(recordButtonAlt1).attr("disabled", "");
        $(recordButtonAlt2).attr("disabled", "");
        $(recordButtonAlt3).attr("disabled", "");
        $(recordButtonAlt4).attr("disabled", "");
        $(recordButtonHint).attr("disabled", "");

        $(pauseButtonAlt2).removeAttr("disabled");
        $(stopButtonAlt2).removeAttr("disabled");
    }
    if (this.id == "recordButtonAlt3") {
        recordButtonAlt3.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "D"; // Referente à Pergunta (title)
        $(recordButtonTitle).attr("disabled", "");
        $(recordButtonAlt1).attr("disabled", "");
        $(recordButtonAlt2).attr("disabled", "");
        $(recordButtonAlt3).attr("disabled", "");
        $(recordButtonAlt4).attr("disabled", "");
        $(recordButtonHint).attr("disabled", "");

        $(pauseButtonAlt3).removeAttr("disabled");
        $(stopButtonAlt3).removeAttr("disabled");
    }
    if (this.id == "recordButtonAlt4") {
        recordButtonAlt4.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "E"; // Referente à Pergunta (title)
        $(recordButtonTitle).attr("disabled", "");
        $(recordButtonAlt1).attr("disabled", "");
        $(recordButtonAlt2).attr("disabled", "");
        $(recordButtonAlt3).attr("disabled", "");
        $(recordButtonAlt4).attr("disabled", "");
        $(recordButtonHint).attr("disabled", "");

        $(pauseButtonAlt4).removeAttr("disabled");
        $(stopButtonAlt4).removeAttr("disabled");
    }
    if (this.id == "recordButtonHint") {
        recordButtonHint.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "F"; // Referente à Pergunta (title)
        $(recordButtonTitle).attr("disabled", "");
        $(recordButtonAlt1).attr("disabled", "");
        $(recordButtonAlt2).attr("disabled", "");
        $(recordButtonAlt3).attr("disabled", "");
        $(recordButtonAlt4).attr("disabled", "");
        $(recordButtonHint).attr("disabled", "");

        $(pauseButtonHint).removeAttr("disabled");
        $(stopButtonHint).removeAttr("disabled");
    }


    /*
    We're using the standard promise based getUserMedia()
    https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
    */

    navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
        console.log("Starting recording stream...");

        /* assign to gumStream for later use */
        gumStream = stream;

        /* use the stream */
        input = audioContext.createMediaStreamSource(stream);

        /*
        Create the Recorder object and configure to record mono sound (1 channel)
        Recording 2 channels  will double the file size
        */
        rec = new Recorder(input,{numChannels:1})

        //start the recording process
        rec.record()

        console.log("Recording started");

    }).catch(function(err) {
        Materialize.toast("Não foi possivel acessar seu microfone. Utilize o upload de arquivo para enviar seu som ou tente novamente.", 3000);
        //enable the record button if getUserMedia() fails
        $(recordButton).removeAttr("disabled");
        $(pauseButton).attr("disabled","");
        $(stopButton).attr("disabled","");
    });
}

function pauseRecording(){
    if (rec.recording){
        //pause
        rec.stop();
        if (this.id == "pauseButtonTitle") {
            recordButtonTitle.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonTitle.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt1") {
            recordButtonAlt1.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonAlt1.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt2") {
            recordButtonAlt2.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonAlt2.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt3") {
            recordButtonAlt3.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonAlt3.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt4") {
            recordButtonAlt4.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonAlt4.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonHint") {
            recordButtonHint.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonHint.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }


    }else{
        //resume
        rec.record()
        if (this.id == "pauseButtonTitle") {
            recordButtonTitle.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonTitle.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt1") {
            recordButtonAlt1.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonAlt1.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt2") {
            recordButtonAlt2.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonAlt2.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt3") {
            recordButtonAlt3.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonAlt3.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonAlt1") {
            recordButtonAlt4.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonAlt4.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonHint") {
            recordButtonHint.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonHint.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
    }
}

function stopRecording() {
    //disable the stop but'ton, enable the record too allow for new recordings
    $(recordButtonTitle).removeAttr("disabled");
    $(recordButtonAlt1).removeAttr("disabled");
    $(recordButtonAlt2).removeAttr("disabled");
    $(recordButtonAlt3).removeAttr("disabled");
    $(recordButtonAlt4).removeAttr("disabled");
    $(recordButtonHint).removeAttr("disabled");

    if (this.id == "stopButtonTitle") {
        pauseButtonTitle.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonTitle.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonTitle).attr("disabled","");
        $(stopButtonTitle).attr("disabled","");
    }
    if (this.id == "stopButtonAlt1") {
        pauseButtonAlt1.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonAlt1.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonAlt1).attr("disabled","");
        $(stopButtonAlt1).attr("disabled","");
    }
    if (this.id == "stopButtonAlt2") {
        pauseButtonAlt2.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonAlt2.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonAlt2).attr("disabled","");
        $(stopButtonAlt2).attr("disabled","");
    }
    if (this.id == "stopButtonAlt3") {
        pauseButtonAlt3.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonAlt3.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonAlt3).attr("disabled","");
        $(stopButtonAlt3).attr("disabled","");
    }
    if (this.id == "stopButtonAlt4") {
        pauseButtonAlt4.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonAlt4.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonAlt4).attr("disabled","");
        $(stopButtonAlt4).attr("disabled","");
    }
    if (this.id == "stopButtonHint") {
        pauseButtonHintlt1.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonHint.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonHint).attr("disabled","");
        $(stopButtonHint).attr("disabled","");
    }


    //tell the recorder to stop the recording
    rec.stop();

    //stop microphone access
    gumStream.getAudioTracks()[0].stop();

    //create the wav blob and pass it on to createDownloadLink
    rec.exportWAV(createDownloadLink);
}

function createDownloadLink(blob) {

    // Generate a unique ID to be used in the radio button and its label;
    var uniqueID;

    // Generate new DOM elements to display the new audio sound
    var url = URL.createObjectURL(blob);
    var div = document.createElement('div');
    var p = document.createElement('span');
    var label = document.createElement('label');
    var span = document.createElement('span');
    var au = document.createElement('audio');
    var input = document.createElement('input');

    if (currentRecordingCard == "A") {
        uniqueID = "audioA" + countTitle;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioA');
        $(label).attr("for",uniqueID).html("Audio " + countTitle);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListTitle").append(div);

        // Update the unique ID global counter;
        countTitle = countTitle + 1;
    }
    if (currentRecordingCard == "B") {
        uniqueID = "audioB" + countAlt1;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioB');
        $(label).attr("for", uniqueID).html("Audio " + countAlt1);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListAlt1").append(div);

        // Update the unique ID global counter;
        countAlt1 = countAlt1 + 1;
    }
    if (currentRecordingCard == "C") {
        uniqueID = "audioC" + countAlt2;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioC');
        $(label).attr("for", uniqueID).html("Audio " + countAlt2);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListAlt2").append(div);

        // Update the unique ID global counter;
        countAlt2 = countAlt2 + 1;
    }
    if (currentRecordingCard == "D") {
        uniqueID = "audioD" + countAlt3;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioD');
        $(label).attr("for", uniqueID).html("Audio " + countAlt3);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListAlt3").append(div);

        // Update the unique ID global counter;
        countAlt3 = countAlt3 + 1;
    }
    if (currentRecordingCard == "E") {
        uniqueID = "audioE" + countAlt1;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioE');
        $(label).attr("for", uniqueID).html("Audio " + countAlt4);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListAlt4").append(div);

        // Update the unique ID global counter;
        countAlt4 = countAlt4 + 1;
    }
    if (currentRecordingCard == "F") {
        uniqueID = "audioF" + countHint;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioF');
        $(label).attr("for", uniqueID).html("Audio " + countHint);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListHint").append(div);

        // Update the unique ID global counter;
        countHint = countHint + 1;
    }



    // Insert them into a set hierarchy
    $(div).append(p);
    $(p).append(input);
    $(p).append(label);
    $(div).append(au);

    //add controls to the <audio> element
    au.controls = true;
    au.src = url;
}

//add events to all buttons
recordButtonTitle.addEventListener("click", startRecording);
stopButtonTitle.addEventListener("click", stopRecording);
pauseButtonTitle.addEventListener("click", pauseRecording);

recordButtonAlt1.addEventListener("click", startRecording);
stopButtonAlt1.addEventListener("click", stopRecording);
pauseButtonAlt1.addEventListener("click", pauseRecording);

recordButtonAlt2.addEventListener("click", startRecording);
stopButtonAlt2.addEventListener("click", stopRecording);
pauseButtonAlt2.addEventListener("click", pauseRecording);

recordButtonAlt3.addEventListener("click", startRecording);
stopButtonAlt3.addEventListener("click", stopRecording);
pauseButtonAlt3.addEventListener("click", pauseRecording);

recordButtonAlt4.addEventListener("click", startRecording);
stopButtonAlt4.addEventListener("click", stopRecording);
pauseButtonAlt4.addEventListener("click", pauseRecording);

recordButtonHint.addEventListener("click", startRecording);
stopButtonHint.addEventListener("click", stopRecording);
pauseButtonHint.addEventListener("click", pauseRecording);
