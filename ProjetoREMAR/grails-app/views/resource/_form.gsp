<head>
	<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}"/>
</head>
<div id="formResource" class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">
	<div class="row">
		<div class="input-field col s12">
			<i class="material-icons suffix green-text active">done</i>
			<input id="name" type="text" class="validate" value="${resourceInstance?.name}" required name="name">
			<label for="name">Nome do jogo</label>
			<span id="name-error2" class="invalid-input" style="left: 0.75rem">Este nome não é válido!</span>
			<span id="name-error" class="invalid-input" style="left: 0.75rem">Este campo não pode ser vazio!</span>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<i class="material-icons suffix green-text active">done</i>
			<textarea id="description" class="materialize-textarea" length="250" name="description" required >${resourceInstance?.description}</textarea>
			<label for="description">Descrição</label>
			<span id="desc-error" class="invalid-textarea" style="left: 0.75rem">Este campo não pode ser vazio!</span>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<i class="material-icons suffix green-text active">done</i>
			<textarea id="customizableItems" class="materialize-textarea" name="customizableItems" required >${resourceInstance?.customizableItems}</textarea>
			<label for="customizableItems">Itens customizáveis</label>
			<span id="customizableItems-error" class="invalid-textarea" style="left: 0.75rem">Este campo não pode ser vazio!</span>
		</div>
	</div>
	<div class="row">
		<div class="input-field col s12">
			<i class="material-icons suffix green-text active">done</i>
			<input value="${resourceInstance?.documentation}" id="documentation" type="text" class="validate" required name="documentation">
			<label for="documentation">Documentação</label>
			<span id="documentation-error" class="invalid-input" style="left: 0.75rem">Este campo não pode ser vazio!</span>
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
				<label for="select">Escolha uma categoria: </label>
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
		<div class="col s4 m4 l4 img-preview">
			<img id="img1Preview" class="materialboxed" width="180px" height="100px"/>
		</div>
		<div class="col s8 m8 l8">
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
		<div class="col s4 m4 l4 img-preview">
			<img id="img2Preview" class="materialboxed " width="180px" height="100px" />
		</div>
		<div class="col s8 m8 l8" >
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
		<div class="col s4 m4 l4 img-preview">
			<img id="img3Preview" class="materialboxed" width="180px" height="100px" />
		</div>
		<div class="col s8 m8 l8">
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

	<div class="right">
		<button  onclick="validateSubmit()" class="waves-effect waves-light btn-flat " id="upload" >
			Enviar
		</button>
	</div>
	<br class="clear" />
</div>
