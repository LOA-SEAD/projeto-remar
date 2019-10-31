/**
 * Created by lucas on 04/10/16.
 */

function localStorageAvailable() {
    if (typeof(Storage) !== "undefined") {
        return true;
    }else {
        return false;
    }
}

$(document).ready(function() {
    if (localStorageAvailable()) {
        if (localStorage.DoNotShowMessageAgain && localStorage.DoNotShowMessageAgain === "true") {
            // user doesn't want to see the message again, so handle accordingly
        }else{
            // $('#messenger').openModal();
        }
    }

    $('#show-messenger').click(function(){
        console.log("entrou aki!");
        if (this.checked) {
            console.log("checked");

            if (localStorageAvailable()){
                console.log("entramos aki");
                localStorage.DoNotShowMessageAgain = "true";
                console.log(localStorage.DoNotShowMessageAgain);
            }
        }else{
            console.log("don't checked");
            localStorage.DoNotShowMessageAgain = "false"
        }
    });

});

