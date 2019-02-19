/**
 * Created by garciaph on 29/08/17.
 */

$(document).ready(function() {
    // Disable send button after submit the form
    $('form.sendForm').submit(function(){
        $(this).find(':input[type=submit]').prop('disabled', true);
    });

    $('select').material_select();

    // textarea behavior
    $('textarea')
    // stops accepting input after reaching it's maximum length
        .keypress(function(e) {
            if (e.which < 0x20) {
                // e.which < 0x20, then it's not a printable character
                // e.which === 0 - Not a character
                return;     // Do nothing
            }
            if (this.value.length == $(this).data('length')) {
                e.preventDefault();
            } else if (this.value.length > $(this).data('length')) {
                // Maximum exceeded
                this.value = this.value.substring(0, $(this).data('length'));
            }
        })
        // slices input if pasted content exceeds character limit
        .on('paste', function(e) {
            e.clipboardData.getData('text/plain').slice(0, $(this).data('length'));
        });

    // preview selected image on form's image input section
    $(".previewed-image").change(function() {
        readURL($(this), $(this).data('preview-target'));
    });

    // resize already initialized images (edit mode)
    $("img.edit").materialbox().each(function() {
       resizeImageOrientationWise($(this), 180, 180);
    });


    $('#back').click(function() {
        var getUrl = window.location;
        var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];

        window.location.href = baseUrl + "/tile/index";

    });


});

// function used in image preview
function readURL($input, previewTarget) {
    var $preview = $('#' + previewTarget);

    // read filename from file input and create a new file reader to it
    if ($input.prop('files') && $input.prop('files')[0]) {
        var reader = new FileReader();

        // load file and change 'src' attribute of preview <img> element
        reader.onload = function (e) {
            $preview.attr('src', e.target.result);
            // resize to 180px height (if portrait) or 180px width (if landscape)s
            resizeImageOrientationWise($preview, 180, 180);
            $preview.show();
        };

        reader.readAsDataURL($input.prop('files')[0]);
    }
}

function resizeImageOrientationWise($el, height, width) {

    // note that it must be $.attr instead of $.css because of materialize materialbox
    $el.on('load', function(){
        var eWidth = $el.width();
        var eHeight = $el.height();

        if (eWidth > eHeight) {
            // landscape
            $el.attr('width', width);
        } else {
            //portrait
            $el.attr('height', height);
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

var recordButton = document.getElementById("recordButton");
var stopButton = document.getElementById("stopButton");
var pauseButton = document.getElementById("pauseButton");

function startRecording() {
    console.log("recordButton clicked");

    /*
    Simple constraints object, for more advanced audio features see
    <div class="video-container"><blockquote class="wp-embedded-content" data-secret="cVHlrYJoGD"><a href="https://addpipe.com/blog/audio-constraints-getusermedia/">Supported Audio Constraints in getUserMedia()</a></blockquote><iframe class="wp-embedded-content" sandbox="allow-scripts" security="restricted" style="position: absolute; clip: rect(1px, 1px, 1px, 1px);" src="https://addpipe.com/blog/audio-constraints-getusermedia/embed/#?secret=cVHlrYJoGD" data-secret="cVHlrYJoGD" width="600" height="338" title="“Supported Audio Constraints in getUserMedia()” — Pipe Blog" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
    */

    var constraints = { audio: true, video:false }

    /*
    Disable the record button until we get a success or fail from getUserMedia()
    */

    $(recordButton).attr("disabled","");
    $(pauseButton).removeAttr("disabled");
    $(stopButton).removeAttr("disabled");

    /*
    We're using the standard promise based getUserMedia()
    https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
    */

    navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
        console.log("getUserMedia() success, stream created, initializing Recorder.js ...");

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
        //enable the record button if getUserMedia() fails
        $(recordButton).removeAttr("disabled");
        $(pauseButton).attr("disabled","");
        $(stopButton).attr("disabled","");
    });
}

function pauseRecording(){
    console.log("pauseButton clicked rec.recording=",rec.recording );
    if (rec.recording){
        //pause
        rec.stop();
        pauseButton.innerHTML="Resume";
    }else{
        //resume
        rec.record()
        pauseButton.innerHTML="Pause";
    }
}

function stopRecording() {
    console.log("stopButton clicked");

    //disable the stop button, enable the record too allow for new recordings
    $(recordButton).removeAttr("disabled");
    $(pauseButton).attr("disabled","");
    $(stopButton).attr("disabled","");

    //reset button just in case the recording is stopped while paused
    pauseButton.innerHTML="Pause";

    //tell the recorder to stop the recording
    rec.stop();

    //stop microphone access
    gumStream.getAudioTracks()[0].stop();

    //create the wav blob and pass it on to createDownloadLink
    rec.exportWAV(createDownloadLink);
}

function createDownloadLink(blob) {

    var url = URL.createObjectURL(blob);
    var au = document.createElement('audio');
    var li = document.createElement('li');
    var link = document.createElement('a');

    //add controls to the <audio> element
    au.controls = true;
    au.src = url;


    //add the new audio and a elements to the li element
    li.appendChild(au);

    //add the li element to the ordered list
    recordingsList.appendChild(li);

    var filename = new Date().toISOString(); //filename to send to server without extension

    //upload link
    var upload = document.createElement('a');
    upload.href="#";
    upload.innerHTML = "Upload";
    upload.addEventListener("click", function(event){
          var xhr=new XMLHttpRequest();
          xhr.onload=function(e) {
              if(this.readyState === 4) {
                  console.log("Server returned: ",e.target.responseText);
              }
          };
          var fd=new FormData();
          fd.append("audio_data",blob, filename);
          xhr.open("POST","upload.php",true);
          xhr.send(fd);
    })
    li.appendChild(document.createTextNode (" "))//add a space in between
    li.appendChild(upload)//add the upload link to li
}

//add events to those 3 buttons
recordButton.addEventListener("click", startRecording);
stopButton.addEventListener("click", stopRecording);
pauseButton.addEventListener("click", pauseRecording);