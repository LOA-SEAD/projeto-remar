function send(enunciado,correta,resp0,resp1,resp2,resp3,escolhida) {

    correta = String.fromCharCode(65 + parseInt(correta));
    escolhida = String.fromCharCode(65 + parseInt(escolhida));

    var data = {
        "enunciado"        : enunciado,
        "alternativaa"     : resp0,
        "alternativab"     : resp1,
        "alternativac"     : resp2,
        "alternativad"     : resp3,
        "respostacerta"    : correta,
        "resposta"         : escolhida
    }

    var splittedUrl = window.location.href.split("/");
    console.log("...");

    data.moodle_url = "/published/" + splittedUrl[4] + "/web";

    console.log("sending data:");
    console.log(data);

    $.ajax({
        type: 'POST',
        data: JSON.stringify(data),
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        url: '/exported-resource/saveGameInfo',
        success: function(data) {
            console.log("Game data stored.");
        },
        error: function(res) {
            console.log("Error in stroring the game data.");
        }
    });
}
