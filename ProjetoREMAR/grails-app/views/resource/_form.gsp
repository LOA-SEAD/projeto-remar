<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">
		<div class="row">
			<div class="input-field col s12">
				<input id="name" type="text" class="validate" required name="name">
				<label for="name">Nome do jogo</label>
			</div>
		</div>
		<div class="row">
			<div class="input-field col s12">
				<textarea id="description" class="materialize-textarea" length="250" name="description" required ></textarea>
				<label for="description">Textarea</label>
			</div>
		</div>

		<div class="row">
			<div class="col s12">
				<div class="input-field">
					<select class="icons-select">
						<option value="" selected>Puzzle</option>
						<option value="" data-icon="/assets/img/inside/avatar.png" class="left circle">Ação</option>
						<option value="" data-icon="/assets/img/inside/avatar.png" class="left circle">Aventura</option>
						<option value="" data-icon="/assets/img/inside/avatar.png" class="left circle">Educacional</option>
					</select>
					<label>Escolha uma categoria: </label>
				</div>
			</div>
		</div>

		<!-- Imagens -->
		<div class="row">
			<div class="col s2 img-preview">
				<img id="img1Preview" class="materialboxed" width="100" height="100" />
			</div>
			<div class="col s10">
				<div class="file-field input-field">
					<div class="btn waves-effect waves-light my-orange">
						<span>File</span>
						<input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png">
					</div>
					<div class="file-path-wrapper">
						<input class="file-path validate" type="text" placeholder="Imagem 1" id="img-1-text" readonly >
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col s2 img-preview">
				<img id="img2Preview" class="materialboxed " width="100" height="100" />
			</div>
			<div class="col s10">
				<div class="file-field input-field">
					<div class="btn waves-effect waves-light my-orange">
						<span>File</span>
						<input type="file" data-image="true" name="img2" id="img-2"  accept="image/jpeg, image/png">
					</div>
					<div class="file-path-wrapper">
						<input class="file-path validate" type="text" placeholder="Imagem 2" id="img-2-text" readonly>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col s2 img-preview">
				<img id="img3Preview" class="materialboxed" width="100" height="100" />
			</div>
			<div class="col s10">
				<div class="file-field input-field">
					<div class="btn waves-effect waves-light my-orange">
						<span>File</span>
						<input type="file" data-image="true" name="img3" id="img-3"  accept="image/jpeg, image/png">
					</div>
					<div class="file-path-wrapper">
						<input class="file-path validate" type="text" placeholder="Imagem 3" id="img-3-text" readonly>
					</div>
				</div>
			</div>
		</div>

	<!--
	<div class="form-group has-feedback" >
		<label>Nome do R.E.A.</label>
		<input placeholder="Nome do R.E.A." type="text" class="form-control-remar" name="name" />
	</div>

	<div class="form-group has-feedback" >
		<label>Descrição</label>
		<textarea class="form-control-remar" placeholder="Descrição" name="description" style="height: 100px;"></textarea>
	</div>

	<div class="form-group has-feedback" >
		<fieldset style="margin: 0px;" >
			<legend>Imagens do R.E.A.</legend>
		<div>
				<div class="form-group">
					<div>
						<img id="img1Preview" style="width: 100px; height: 100px;" />
					</div>
					<input data-image="true" id="img-1" type="file" name="img1" accept="image/jpeg, image/png" />

				</div>

				<div class="form-group">
					<img id="img2Preview" style="width: 100px; height: 100px;" />
					<input data-image="true"  type="file" name="img2" id="img-2" />
				</div>

				<div class="form-group">
					<img  id="img3Preview" style="width: 100px; height: 100px;" />
					<input data-image="true" type="file" name="img3" id="img-3"/>
				</div>
			</div>
		</fieldset>
	</div>
	-->
		<div class="right">
			<button  onclick="validateSubmit()" class="waves-effect waves-light btn-flat " id="upload" >
				Enviar
			</button>
		</div>
		<br class="clear" />
</div>

<script>

    function validateSubmit(){
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
            formData.append('img1',image1);
            formData.append('img2',image2);
            formData.append('img3',image3);


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
</script>