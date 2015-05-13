var pai = document.getElementById("ancora").parentNode;

var jogo = {};

$.ajax({
    url: "json/palavras.json",
    dataType: "text",
    mimeType: "application/json",
    async: false,
    success: function (data) {
        jogo.bd = $.parseJSON(data);
    }
});

/*var css = document.createElement("link");
css.setAttribute("rel", "stylesheet");
css.setAttribute("href", "css/style.css");
document.head.appendChild(css);



var script = document.createElement("script");
script.setAttribute("src", "js/jquery-1.7.2.js");
pai.appendChild(script);

var script = document.createElement("script");
script.setAttribute("src", "js/bancodepalavras.js");
pai.appendChild(script);

var script = document.createElement("script");
script.setAttribute("src", "js/classes.js");
pai.appendChild(script);

var script = document.createElement("script");
script.setAttribute("src", "js/logica.js");
pai.appendChild(script);*/
