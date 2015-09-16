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

    $.ajax({
        url: 'moodle.json',
        dataType: "json",
        async: false,
        success: function(res) {
            data.remar_resource_id = res.remar_resource_id;
        }
    })
    console.log(data);

    $.ajax({
        type: 'POST',
        data: data,
        url: '/moodle/send',
        success: function(data) {
            console.log(data);
        },
        error: function(res) {
            console.log(res);
        }
    });
}
