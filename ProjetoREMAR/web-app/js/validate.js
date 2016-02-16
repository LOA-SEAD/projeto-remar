function validateSubmit(){
    var name = document.getElementById("name").value;
    var description = document.getElementById("description").value;

    if(name==null || name == "") {
        alert("O campo Nome do Jogo é obrigatório.");
    }
    else{
        if(description==null || description==""){
            alert("O campo Textarea é obrigatório.");
        }
        else{
            if(validateImageFile("img-1") && validateImageFile("img-2") && validateImageFile("img-3")){
                var formData = new FormData();
                var image1 = $("#img-1").prop('files')[0];
                var image2 = $("#img-2").prop('files')[0];
                var image3 = $("#img-3").prop('files')[0];
                console.log(image1);
                console.log(image2);
                console.log(image3);
                console.log($(this).data('id'));


                formData.append('name', document.getElementById("name").value);
                formData.append('description', document.getElementById("description").value);
                formData.append('img1',$("#img1Preview").attr("src"));
                formData.append('img2',$("#img2Preview").attr("src"));
                formData.append('img3',$("#img3Preview").attr("src"));


                $.ajax({
                    url: "/resource/update/" + $("#hidden").val(),
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        window.location.href = "index"
                    },
                    error: function () {
                        alert("error");
                    }
                });

            }
            else{
                alert("Escolha arquivos de imagens válidos. Os arquivos devem ter extensão .jpeg ou .png");
            }
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