/**
 * Created by matheus on 6/27/15.
 */
$(function(){


    var name = document.getElementById("name");  // Nome do jogo
    var description = document.getElementById("description");  // Descricao
    var customizableItems = document.getElementById("customizableItems");  // Itens customizaveis
    document.getElementById("shareable").disabled = true;

    var nameErr = $("#name-error");  // Ainda tenho que descobrir qual tipo de erro deveria ser esse
    var nameErr2 = $("#name-error2");  // Erro para nome já sendo utilizado

    // nameErr esta sendo escondido em game-index.js
    nameErr2.hide();  // Esconde o erro numero 2

    var descErr = $("#desc-error");  // Era pra ter algum erro de descricao q simplesmente n existe
    var customizableErr = $("#customizableItems-error");  // Aparentemente, era pra ter erro de itens customizaveis tbm
    var authorshipErr = $("#authorship-error");


    $.ajax({
        type: 'POST',  // Eh aqui q o formulario eh preenchido com os seus valores salvos
        url: location.origin + "/resource/getResourceInstance/" + $("#hidden").val(),  // #hidden vem de um <input> logo antes do form, pq?
        data: {name: $("#name").val()},  // Dados enviados ao servidor. Sao enviados em par chave/valor, no caso, name: #name.val().
        processData: false,  // Pesquisar sobre o que ser falso acarreta
        contentType: false,  // Pesquisar sobre o que ser falso acarreta
        success: function (data) {  // Em caso de sucesso

            $("#name").val(data.name)  // Seta valor do campo do Nome do Jogo
                .next().addClass("active");

            $("#description").val(data.description)  // Seta valor do campo da Descricao, mas isso nao eh enviado ao servidouro
                .next().addClass("active");

            $("#documentation").val(data.documentation)  // Seta valor do campo da Documentacao, mas isso nao eh enviado ao servidouro
                .next().addClass("active");

            $("#customizableItems").val(data.customizableItems)  // Seta valor do campo de Itens Customizaveis, mas isso nao eh enviado ao servidouro
                .next().addClass("active");

            if(data.shareable === true) {  // Seta o checkbox de acordo
                $('#shareable').attr('checked', 'checked');
                $('#shareable').attr('disabled', 'disabled');
            }

            // Seta imagens buscadas. Talvez mudar essa frase pra continuar sendo o nome do arquivo.
            // Talvez n de pra por o nome do arquivo? Pesquisar
            $("#img1Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-1");
            $("#img-1-text").prop('placeholder',"Carregue uma nova imagem!");

            $("#img2Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-2");
            $("#img-2-text").prop('placeholder',"Carregue uma nova imagem!");

            $("#img3Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-3");
            $("#img-3-text").prop('placeholder',"Carregue uma nova imagem!");
        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });

    $("#upload").on("click",function(){  // Quando clicar em ENVIAR setará os campos de acordo com as mudancas

        var ok = 0;
        var formData = new FormData();  // Dados do formulario

        // Abaixo faz um append de todos os campos no formData para ser enviado
        formData.append('name', document.getElementById("name").value);
        formData.append('description', document.getElementById("description").value);
        formData.append('documentation', document.getElementById("documentation").value);
        formData.append('customizableItems', document.getElementById("customizableItems").value);


        formData.append('img1',$("#img1Preview").attr("src"));
        formData.append('img2',$("#img2Preview").attr("src"));
        formData.append('img3',$("#img3Preview").attr("src"));
        formData.append('category', $("select").val());

        if($('#shareable').is(':checked'))
            formData.append('shareable', 'yes');
        else
            formData.append('shareable', 'no');

        $.ajax({
            url: "/resource/findResource?name=" + $("#name").val(),
            type: 'GET',
            processData: false,
            contentType: false,
            success: function (data) {
                //window.location.href = "../index";
                console.log(data);
                if(data == "null"){
                    if($(name).val()==null || $(name).val() == "") {
                        $(nameErr).show(500);
                        $(name).prev().hide();
                        $(name).removeClass().addClass('invalid');
                        ok = ok+1;
                    }

                    if($(description).val()==null || $(description).val()==""){
                        $(descErr).show(500);
                        $(description).prev().hide();
                        $(description).removeClass('valid').addClass('invalid');
                        ok = ok+1;
                    }

                    if(ok == 0) {
                        $.ajax({
                            url: "/resource/update/" + $("#hidden").val(),
                            type: 'POST',
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function (response) {
                                //window.location.href = "../index";
                                Materialize.toast('Informações salvas com sucesso!', 3000, 'rounded');
                                $(nameErr2).hide();


                                $(name).removeClass().addClass("valid");
                                $(name).prev().show(500);

                                $(description).addClass("valid");
                                $(description).prev().show(500);

                                $(documentation).prev().show(500);

                            },
                            error: function () {
                                console.log("nao realizou update!");
                            }
                        });
                    }
                }
                else{
                    $(nameErr2).show(500);
                    $(name).prev().hide();
                    $(name).removeClass().addClass('invalid');
                }

            },
            error: function () {
                console.log("nao conseguiu GET!");
            }
        });



    });

});

