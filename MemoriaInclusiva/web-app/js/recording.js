/*
    Código feito por Túlio Reis, fortemente baseado e adaptado de https://blog.addpipe.com/using-recorder-js-to-capture-wav-audio-in-your-html5-web-site/

    O código intercepta o submit dos formulários (#submit) para poder capturar e enviar manualmente os áudios gravados e carregados.
 */

var countA = 1;
var countB = 1;
var countDescription = 1;
var currentRecordingCard = "A";
$(document).ready(function() {
    // Disable send button after submit the form
    $('form.sendForm').submit(function(){
        $(this).find(':input[type=submit]').prop('disabled', true);
    });

    $('#back').click(function() {
        var getUrl = window.location;
        var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];

        window.location.href = baseUrl + "/tile/index";
    });

    // autoplay selected audio
    $("#recordingsListA, #recordingsListB, #recordingsDescription").delegate("input[type=radio]", "change", function (){
        $(this).parent().siblings("audio")[0].play();
    });

    // Submit form button click function
    $("#submit").click(function() {
        fd = new FormData();
        var selectCartaA = $("#selectCartaA :selected").val();


        if (selectCartaA == "gravarA") {
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
                $('#gravarModalA').modal();
                $('#gravarModalA').modal('open');
                Materialize.toast("Grave e selecione o áudio da pergunta para prosseguir", displayLength='3000');
            }
        }
        else {
            recoverBlobB(null)
        }
    });

});


function recoverBlobB(blobA) {
    var selectCartaB = $("#selectCartaB :selected").val();

    if(selectCartaB == "gravarB") {
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
            $('#gravarModalB').modal();
            $('#gravarModalB').modal('open');
            Materialize.toast("Grave e selecione o áudio da resposta para poder prosseguir", displayLength='3000');
        }
    }
    else {
        recoverBlobC(blobA, null)
    }
}


function recoverBlobC(blobA, blobB) { // blob da description
    var selectDescription = $("#selectDescription :selected").val();

    if(selectDescription == "gravarDescription") {
        if (audioDescriptionurl = $("input[name=audioDescription]:checked").parent().siblings("audio")[0] != null) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', audioDescriptionurl);
            xhr.responseType = 'blob';
            xhr.onload = function (e) {
                sendFormData(blobA, blobB, xhr.response)
            };
            xhr.send();
        } else {
            $('#gravarModalDescription').modal();
            $('#gravarModalDescription').modal('open');
            Materialize.toast("Grave e selecione o áudio da descrição para poder prosseguir", displayLength='3000');
        }
    }
    else {
        sendFormData(blobA, blobB, null)
    }
}


function sendFormData(blobA, blobB, blobC) {
    var textA = $("input[name=textA]").val();
    var textB = $("input[name=textB]").val();
    var description = $("input[name=description]").val();
    var tileID = $("input[name=tileID]").val();
    var selectCartaA = $("#selectCartaA :selected").val();
    var selectCartaB = $("#selectCartaB :selected").val();
    var selectDescription = $("#selectDescription :selected").val();
    var fd = new FormData();


    // Carregamento e checagem dos áudios
    if ((blobA != null) && (selectCartaA == "gravarA")){
        fd.append("audioA", blobA, new Date().toISOString());
    }

    if ((blobB != null) && (selectCartaB == "gravarB")){
        fd.append("audioB", blobB, new Date().toISOString());
    }

    if ((blobC != null) && (selectDescription == "gravarDescription")){
        fd.append("audioDescription", blobC, new Date().toISOString());
    }

    if (selectCartaA == "carregarA"){
        if ($("#audio-1")[0].files[0] != null) {
            fd.append("audio-1", $("#audio-1")[0].files[0])
        }
        else {
            $('#carregarModalA').modal();
            $('#carregarModalA').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da pergunta para poder prosseguir", displayLength='3000');
        }
    }

    if (selectCartaB == "carregarB"){
        if ($("#audio-2")[0].files[0] != null) {
            fd.append("audio-2", $("#audio-2")[0].files[0]);
        }
        else {
            $('#carregarModalB').modal();
            $('#carregarModalB').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da resposta para poder prosseguir", displayLength='3000');
        }
    }

    if (selectDescription == "carregarDescription"){
        if ($("#audio-2")[0].files[0] != null) {
            fd.append("audio-3", $("#audio-3")[0].files[0]);
        }
        else {
            $('#carregarModalDescription').modal();
            $('#carregarModalDescription').modal('open');
            Materialize.toast("Selecione de seu computador o áudio da resposta para poder prosseguir", displayLength='3000');
        }
    }


    // Carregamento dos itens restantes (como parâmetros para o controlador)
    fd.append("textA", textA)
    fd.append("textB", textB)
    fd.append("description", description)
    fd.append("tileID", tileID)
    fd.append("selectCartaA", selectCartaA)
    fd.append("selectCartaB", selectCartaB)
    fd.append("selectDescription", selectDescription)


    if ((selectCartaA == "gerar" || selectCartaB == "gerar") || (selectDescription == "gerar")) {
        Materialize.toast("Aguarde um momento que o áudio do texto está sendo gerado...");
    }


    if (tileID) {
        // O formulário só continua se todos os campos de áudio estiverem devidamente designados (vazios ou preenchidos)
        if (((blobA != null) || ($("#audio-1")[0].files[0] != null) || (selectCartaA == "gerar")) || (selectCartaA == "naoeditar") &&
            ((blobB != null) || ($("#audio-2")[0].files[0] != null) || (selectCartaB == "gerar")) || (selectCartaB == "naoeditar") &&
            ((blobC != null) || ($("#audio-3")[0].files[0] != null) || (selectDescription == "gerar") || (selectDescription == "naoeditar"))) {

            // significa que tem uma ID, e isso significa que está na tela de edição, então chama o controlador de edição (update)
            $.ajax({
                method: "POST",
                url: "/memoriainclusiva/tile/update",
                contentType: false,
                processData: false,
                data: fd,
                success: function (response) {
                    window.location.href = response;
                }
            });
        }
    }
    else {
        if (((blobA != null) || ($("#audio-1")[0].files[0] != null) || (selectCartaA == "gerar")) &&
            ((blobB != null) || ($("#audio-2")[0].files[0] != null) || (selectCartaB == "gerar")) &&
            ((blobC != null) || ($("#audio-3")[0].files[0] != null) || (selectDescription == "gerar"))) {

            // significa que está na tela do create, chama o controlador de salvar
            $.ajax({
                method: "POST",
                url: "/memoriainclusiva/tile/save",
                contentType: false,
                processData: false,
                data: fd,
                success: function (response) {
                    window.location.href = response;
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

var recordButton = document.getElementById("recordButtonA");
var stopButton = document.getElementById("stopButtonA");
var pauseButton = document.getElementById("pauseButtonA");
var recordButtonB = document.getElementById("recordButtonB");
var stopButtonB = document.getElementById("stopButtonB");
var pauseButtonB = document.getElementById("pauseButtonB");
var recordButtonDescription = document.getElementById("recordButtonDescription");
var stopButtonDescription = document.getElementById("stopButtonDescription");
var pauseButtonDescription = document.getElementById("pauseButtonDescription");

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
    if (this.id == "recordButtonA") {
        recordButton.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "A"; // referente à carta 1
        $(recordButton).attr("disabled", "");
        $(recordButtonB).attr("disabled", "");
        $(pauseButton).removeAttr("disabled");
        $(stopButton).removeAttr("disabled");

    }
    if (this.id == "recordButtonB") {
        recordButtonB.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "B"; // referente à carta 2
        $(recordButton).attr("disabled", "");
        $(recordButtonB).attr("disabled", "");
        $(pauseButtonB).removeAttr("disabled");
        $(stopButtonB).removeAttr("disabled");
    }
    if (this.id == "recordButtonDescription") {
        recordButtonDescription.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
        currentRecordingCard = "Description"; // referente à descrição
        $(recordButton).attr("disabled", "");
        $(recordButtonDescription).attr("disabled", "");
        $(pauseButtonDescription).removeAttr("disabled");
        $(stopButtonDescription).removeAttr("disabled");
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
        if (this.id == "pauseButtonA") {
            recordButton.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButton.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonB") {
            recordButtonB.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonB.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonDescription") {
            recordButtonDescription.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
            pauseButtonDescription.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
    }else{
        //resume
        rec.record()
        if (this.id == "pauseButtonA") {
            recordButton.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButton.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonB") {
            recordButtonB.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonB.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
        if (this.id == "pauseButtonDescription") {
            recordButtonDescription.innerHTML=GMS.RECORDINGS_RECORDING_BUTTON_LABEL;
            pauseButtonDescription.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
    }
}

function stopRecording() {
    //disable the stop but'ton, enable the record too allow for new recordings
    $(recordButton).removeAttr("disabled");
    $(recordButtonB).removeAttr("disabled");
    $(recordButtonDescription).removeAttr("disabled");
    if (this.id == "stopButtonA") {
        pauseButton.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButton.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButton).attr("disabled","");
        $(stopButton).attr("disabled","");
    }
    if (this.id == "stopButtonB") {
        pauseButtonB.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonB.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonB).attr("disabled","");
        $(stopButtonB).attr("disabled","");
    }
    if (this.id == "stopButtonDescription") {
        pauseButtonDescription.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        recordButtonDescription.innerHTML=GMS.RECORDINGS_RECORD_BUTTON_LABEL;
        $(pauseButtonDescription).attr("disabled","");
        $(stopButtonDescription).attr("disabled","");
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
        uniqueID = "audioA" + countA;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioA');
        $(label).attr("for",uniqueID).html("Audio " + countA);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListA").append(div);

        // Update the unique ID global counter;
        countA = countA + 1;
    }
    if (currentRecordingCard == "B") {
        uniqueID = "audioB" + countB;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioB');
        $(label).attr("for", uniqueID).html("Audio " + countB);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListB").append(div);

        // Update the unique ID global counter;
        countB = countB + 1;
    }
    if (currentRecordingCard == "Description") {
        uniqueID = "audioDescription" + countDescription;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioDescription');
        $(label).attr("for", uniqueID).html("Audio " + countDescription);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListDescription").append(div);

        // Update the unique ID global counter;
        countDescription = countDescription + 1;
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

//add events to all 6 buttons
recordButton.addEventListener("click", startRecording);
stopButton.addEventListener("click", stopRecording);
pauseButton.addEventListener("click", pauseRecording);
recordButtonB.addEventListener("click", startRecording);
stopButtonB.addEventListener("click", stopRecording);
pauseButtonB.addEventListener("click", pauseRecording);
recordButtonDescription.addEventListener("click", startRecording);
stopButtonDescription.addEventListener("click", stopRecording);
pauseButtonDescription.addEventListener("click", pauseRecording);