<div id="formResource" class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">
	<div class="row">
		<div class="input-field col s12">
			<input id="name" type="text" class="validate" value="${resourceInstance?.name}" required name="name">
			<label for="name">Nome do jogo <span class="required-indicator">*</span></label>
			<span id="name-error" class="invalid-input" style="left: 0.75rem">Este campo deve ser preenchido!</span>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<textarea id="description" class="materialize-textarea" data-length="250" name="description" required >${resourceInstance?.description}</textarea>
			<label for="description">Descrição <span class="required-indicator">*</span></label>
			<span id="desc-error" class="invalid-textarea" style="left: 0.75rem">Este campo deve ser preenchido!</span>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12">
			<input id="authorship" type="text" class="validate" required name="authorship">
			<label for="authorship">Autoria <span class="required-indicator">*</span></label>
			<span id="authorship-error" class="invalid-input" style="left: 0.75rem">Este campo deve ser preenchido!</span>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12">
			<textarea id="info" class="materialize-textarea" data-length="250" name="info">${resourceInstance?.info}</textarea>
			<label for="info">Info</label>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<textarea id="customizableItems" class="materialize-textarea" name="customizableItems" required >${resourceInstance?.customizableItems}</textarea>
			<label for="customizableItems">Itens customizáveis <span class="required-indicator">*</span></label>
			<span id="customizableErr" class="invalid-textarea" style="left: 0.75rem">Este campo deve ser preenchido!</span>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<input value="${resourceInstance?.videoLink}" id="videoLink" type="text" class="validate" required name="videoLink">
			<label for="videoLink">Link de Video Tutorial</label>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<input value="${resourceInstance?.documentation}" id="documentation" type="text" class="validate" required name="documentation">
			<label for="documentation">Documentação</label>
		</div>
	</div>

	<div class="row">
		<div class="col s12">
			<div class="input-field">
				<select id="select" class="icons-select">
					<g:if test="${categories.size() > 0}">
						<g:each in="${categories}" var="category">
							<g:if test="${category.id == defaultCategory.id}">
								<option class="option" value="${category.id}" selected>${category.name}</option>
							</g:if>
							<g:else>
								<option class="option" value="${category.id}">${category.name}</option>
							</g:else>
						</g:each>
					</g:if>
				</select>
				<label for="select">Escolha uma categoria: <span class="required-indicator">*</span></label>
			</div>
		</div>
	</div>
	<div class="row">
		<div>
			<p>
				<input class="filled-in" type="checkbox" name="shareable" id="shareable" />
				<label style="font-size: 1.2em" for="shareable">Deseja habilitar o compartilhamento e acompanhamento em grupos?</label>
			</p>
		</div>
	</div>
	<!-- Imagens -->
	<div class="row">
		<div class="col s2 m2 l2 img-preview">
			<img id="img1Preview" class="materialboxed" width="200px" height="120px"/>
		</div>
		<div class="col s10 m10 l10">
			<div class="file-field input-field">
				<div class="btn waves-effect waves-light my-orange">
					<span>Arquivo</span>
					<input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png">
				</div>
				<div class="file-path-wrapper">
					<input class="file-path validate" type="text" placeholder="Imagem 1" id="img-1-text" readonly >
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col s2 m2 l2 img-preview">
			<img id="img2Preview" class="materialboxed " width="200px" height="120px" />
		</div>
		<div class="col s10 m10 l10" >
			<div class="file-field input-field">
				<div class="btn waves-effect waves-light my-orange">
					<span>Arquivo</span>
					<input type="file" data-image="true" name="img2" id="img-2"  accept="image/jpeg, image/png">
				</div>
				<div class="file-path-wrapper">
					<input class="file-path validate" type="text" placeholder="Imagem 2" id="img-2-text" readonly>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col s2 m2 l2 img-preview">
			<img id="img3Preview" class="materialboxed" width="200px" height="120px" />
		</div>
		<div class="col s10 m10 l10">
			<div class="file-field input-field">
				<div class="btn waves-effect waves-light my-orange">
					<span>Arquivo</span>
					<input type="file" data-image="true" name="img3" id="img-3"  accept="image/jpeg, image/png">
				</div>
				<div class="file-path-wrapper">
					<input class="file-path validate" type="text" placeholder="Imagem 3" id="img-3-text" readonly>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col s12 m12 l12" style="margin-top:20px">
			<button class="btn btn-large waves-effect waves-light my-orange right" onclick="validateSubmit()" type="submit" name="save" id="upload" style="height: 3rem; line-height: 3rem">Enviar</button>
		</div>
	</div>
</div>

<script>
    $(document).ready(function(){
        $("#send-import").click(function(){

            var formData = new FormData();
            formData.append('spreadsheet-file', $("#arquivo")[0].files[0]);

            $.ajax({
                url: '/resource/importData',
                method: "POST",
                dataType: 'json',
                data: formData,
                processData: false,
                contentType: false,
                success: function(resp){

                    $("label[for='description']").addClass("validate active");
                    $("#description").val(resp[1][0]);

                    $("label[for='info']").addClass("validate active");
                    $("#info").val(resp[1][1]);

                    $("label[for='customizableItems']").addClass("validate active");
                    $("#customizableItems").val(resp[1][2]);

                    $("label[for='videoLink']").addClass("validate active");
                    $("#videoLink").val(resp[1][3]);

                    $("label[for='documentation']").addClass("validate active");
                    $("#documentation").val(resp[1][4]);

                    $("#cancel-import").click();

                    $('.success-box').slideDown(500);
                },
                error: function(er){
                    alert("Erro! Problema na importação.");
                }
            });

        });

        $("#close-success").click(function(){
            $('.success-box').slideUp(500);
		})
    });
</script>