var demo = {};

function readJson() {

$.ajax({
    url: "json/frases.json",
    dataType: "text",
    mimeType: "application/json",
    async: false,
    success: function (data) {
demo.frases = $.parseJSON(data).frases;
    } 
});

}

function criarPage()
{
var pai = document.getElementById("ancora").parentNode;

	var header = document.createElement("header");
	header.setAttribute("id", "top");
        header.setAttribute("class", "header");
	pai.appendChild(header);

	var div = document.createElement("div");
	div.setAttribute("class", "text-vertical-center");
	header.appendChild(div);

       var h1 = document.createElement("h1");
       h1.innerHTML="Demo";
       div.appendChild(h1);

       for (var i = 0; i < demo.frases.length; i++) {
var h3 = document.createElement("h3");
       h3.innerHTML=demo.frases[i];
       div.appendChild(h3);
       }       
       
}

readJson();
criarPage();
