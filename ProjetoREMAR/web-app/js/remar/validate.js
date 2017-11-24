function validateSubmit(){
    var ok = 0;
    var name = document.getElementById("name");
    var description = document.getElementById("description");
    var customizableItems = document.getElementById("customizableItems");


    var nameErr = $("#name-error");
    var descErr = $("#desc-error");
    var customizableErr = $("#customizableItems-error");


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

    if($(customizableItems).val()==null || $(customizableItems).val()==""){
        $(customizableErr).show(500);
        $(customizableItems).prev().hide();
        $(customizableItems).removeClass('valid').addClass('invalid');
        ok = ok+1;
    }

    if(ok == 0) {
            if(validateImageFile("img-1") && validateImageFile("img-2") && validateImageFile("img-3")){
                var formData = new FormData();
                var image1 = $("#img-1").prop('files')[0];
                var image2 = $("#img-2").prop('files')[0];
                var image3 = $("#img-3").prop('files')[0];
                console.log(image1);
                console.log(image2);
                console.log(image3);
                console.log($(this).data('id'));
                //console.log("SELECT "+$("select").find(":selected").text());


                //formData.append('id', $(this).data('id'));
                formData.append('name', document.getElementById("name").value);
                formData.append('description', document.getElementById("description").value);
                formData.append('info', document.getElementById("info").value);
                formData.append('documentation', document.getElementById("documentation").value);
                formData.append('customizableItems', document.getElementById("customizableItems").value);
                formData.append('videoLink', document.getElementById("videoLink").value);


                formData.append('img1',$("#img1Preview").attr("src"));
                formData.append('img2',$("#img2Preview").attr("src"));
                formData.append('img3',$("#img3Preview").attr("src"));
                formData.append('category', $("select").val());
                if($('#shareable').is(':checked'))
                    formData.append('shareable', 'yes');
                else
                    formData.append('shareable', 'no');


                $.ajax({
                    url: "/resource/update/" + $("#hidden").val(),
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        window.location.href = "../../index"
                    },
                    error: function () {
                        alert("error");
                    }
                });

            }
            else{
                Materialize.toast("Escolha arquivos de imagens válidos. Os arquivos devem ter extensão .jpeg ou .png", 3000);
            }
    }
}

function validateImageFile(File){
    var inputFile = document.getElementById(File);
    var fileName = inputFile.value;

    if(fileName.length>0){
        var fileExtension = fileName.split('.').pop().toLowerCase();
        if( fileExtension=="jpeg" || fileExtension=="png" || fileExtension=="jpg" ){
            return true;
        }
        else {
            return false;
        }
    }
    else{
        return false;
    }
}