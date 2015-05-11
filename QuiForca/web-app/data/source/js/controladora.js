function mudar_estado(el) {
    var display = document.getElementById(el).style.display;
    if (display == "none")
        document.getElementById(el).style.display = 'block';
    else
        document.getElementById(el).style.display = 'none';
}

function mostra_jogo() {
    mudar_estado('camadaJogo');
    mudar_estado('camadaPergunta');
    mudar_estado('camadaMenu');
    iniciarNovoJogo();
    iniciar();
}

function mostra_menu() {
    mudar_estado('camadaJogo');
    mudar_estado('camadaPergunta');
    mudar_estado('camadaMenu');
}

function mostra_derrota() {
    mudar_estado('camadaJogo');
    //mudar_estado('camadaPergunta');
    mudar_estado('camadaDerrota');
}

function sai_derrota() {
    mudar_estado('camadaMenu');
    mudar_estado('camadaPergunta');
    mudar_estado('camadaDerrota');
}

function mostra_vitoria() {
    mudar_estado('camadaJogo');
    mudar_estado('camadaVitoria');
    mudar_estado('camadaPergunta');
}

function continuar_jogo() {
    mudar_estado('camadaJogo');
    mudar_estado('camadaVitoria');
    mudar_estado('camadaPergunta');
    iniciar();
}

function tecla_pressionada(keyunicode) {
    var display = document.getElementById('camadaJogo').style.display;
    if (display == "block") {
        //var keyunicode = tecla.charcode || tecla.keyCode || tecla.which;

        if (keyunicode >= 65 && keyunicode <= 90)
        {
            keyunicode += 32;
        }

        //Se o codigo estiver dentro do alfabeto
        if ((keyunicode >= 97 && keyunicode <= 122) && (jogo.emTransicao == false) && (fimDeJogo() == -1))
        {
            //Verifica se deu erro
            verificarErro(String.fromCharCode(keyunicode - 32));
            //Coloca nas letras tentadas
            colocarLetraEmLetrasTentadas(String.fromCharCode(keyunicode - 32));
        }
    }
    var display = document.getElementById('camadaVitoria').style.display;
    if (display == "block") {
        if(keyunicode == 13){
            continuar_jogo();
        }
    }
    var display = document.getElementById('camadaDerrota').style.display;
    if (display == "block") {
        if(keyunicode == 13){
            sai_derrota();
        }
    }
}

function click_botao(_letra)
{
    verificarErro(_letra);
    colocarLetraEmLetrasTentadas(_letra);
}



function checkEventObj(_event_) {
    // --- IE explorer 
    if (window.event)
        return window.event;
    // --- Netscape and other explorers 
    else
        return _event_;
}

function applyKey(_event_) {

    // --- Retrieve event object from current web explorer 
    var winObj = checkEventObj(_event_);

    var intKeyCode = winObj.keyCode;
    
    tecla_pressionada(intKeyCode);

} 