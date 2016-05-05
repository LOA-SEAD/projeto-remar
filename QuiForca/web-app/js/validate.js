function validate(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    if(key == 37 || key == 38 || key == 39 || key == 40 || key == 8) { // Left / Up / Right / Down Arrow, Backspace, Delete keys
        return;
    }
    key = String.fromCharCode( key );

   // var regex = /[a-z|A-Z|/]/;
    var regex = /[a-zA-Z]/;
    console.log("key: " + key);
    if( !regex.test(key)) {
        theEvent.returnValue = false;
        if(theEvent.preventDefault) theEvent.preventDefault();
    }
}
