/**
 * Created by garciaph on 29/08/17.
 */

var countA = 1;
var countB = 1;
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
    $("#recordingsListA, #recordingsListB").delegate("input[type=radio]", "change", function (){
       $(this).parent().siblings("audio")[0].play();
    });

    // Submit form button click function
    $("#submit").click(function() {
        fd = new FormData();


        var audioAurl = $("input[name=audioA]:checked").parent().siblings("audio")[0].src;

        var xhr = new XMLHttpRequest();
        xhr.open('GET', audioAurl);
        xhr.responseType = 'blob';
        xhr.onload = function(e) { recoverBlobB(xhr.response) };
        xhr.send();
    });
});

function recoverBlobB(blobA) {

    var audioBurl = $("input[name=audioB]:checked").parent().siblings("audio")[0].src;
    var xhr = new XMLHttpRequest();
    xhr.open('GET', audioBurl);
    xhr.responseType = 'blob';
    xhr.onload = function(e) { sendFormData(blobA, xhr.response) };
    xhr.send();
}

function sendFormData(blobA, blobB) {
    var textA = $("input[name=textA]").val();
    var textB = $("input[name=textB]").val();

    var fd = new FormData();
    fd.append("audioA", blobA, new Date().toISOString());
    fd.append("audioB", blobB, new Date().toISOString());
    fd.append("textA", textA);
    fd.append("textB", textB);

    $.ajax({
        method: "POST",
        url: "/memoria/tile/save",
       contentType: false,
       processData: false,
       data: fd,
       success: function() {
           window.top.top.location.href = response;
       }

    });
}


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

function startRecording() {
    console.log("Recording requested.");

    /*
    Simple constraints object, for more advanced audio features see
    <div class="video-container"><blockquote class="wp-embedded-content" data-secret="cVHlrYJoGD"><a href="https://addpipe.com/blog/audio-constraints-getusermedia/">Supported Audio Constraints in getUserMedia()</a></blockquote><iframe class="wp-embedded-content" sandbox="allow-scripts" security="restricted" style="position: absolute; clip: rect(1px, 1px, 1px, 1px);" src="https://addpipe.com/blog/audio-constraints-getusermedia/embed/#?secret=cVHlrYJoGD" data-secret="cVHlrYJoGD" width="600" height="338" title="“Supported Audio Constraints in getUserMedia()” — Pipe Blog" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
    */

    var constraints = { audio: true, video:false }

    /*
    Disable the record button until we get a success or fail from getUserMedia()
    */

    if (this.id == "recordButtonA") {
        currentRecordingCard = "A";
        $(recordButton).attr("disabled", "");
        $(recordButtonB).attr("disabled", "");
        $(pauseButton).removeAttr("disabled");
        $(stopButton).removeAttr("disabled");
    } else {
        currentRecordingCard = "B";
        $(recordButton).attr("disabled", "");
        $(recordButtonB).attr("disabled", "");
        $(pauseButtonB).removeAttr("disabled");
        $(stopButtonB).removeAttr("disabled");
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
        Materialize.toast("Não foi possivel acessar seu microfone. Utilize o upload de arquivo para enviar seu som.", 3000);
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
            pauseButton.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        } else {
            pauseButtonB.innerHTML=GMS.RECORDINGS_RESUME_BUTTON_LABEL;
        }
    }else{
        //resume
        rec.record()
        if (this.id == "pauseButtonA") {
            pauseButton.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        } else {
            pauseButtonB.innerHTML = GMS.RECORDINGS_PAUSE_BUTTON_LABEL;
        }
    }
}

function stopRecording() {
    //disable the stop but'ton, enable the record too allow for new recordings
    $(recordButton).removeAttr("disabled");
    $(recordButtonB).removeAttr("disabled");
    if (this.id == "stopButtonA") {
        $(pauseButton).attr("disabled","");
        $(stopButton).attr("disabled","");
    } else {
        $(pauseButtonB).attr("disabled","");
        $(stopButtonB).attr("disabled","");
    }


    //reset button just in case the recording is stopped while paused
    pauseButton.innerHTML= GMS.RECORDINGS_PAUSE_BUTTON_LABEL;

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
    } else {
        uniqueID = "audioB" + countB;
        $(input).attr('type', 'radio').attr('id', uniqueID).attr('name', 'audioB');
        $(label).attr("for",uniqueID).html("Audio " + countB);

        //add the p containing new audio and input elements to the recordings list
        $("#recordingsListB").append(div);

        // Update the unique ID global counter;
        countB = countB + 1;
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