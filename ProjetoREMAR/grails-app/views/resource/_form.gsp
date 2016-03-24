<head>
	<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}"/>
</head>
<div id="formResource" class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">
		<div class="row">
			<div class="input-field col s12">
				<i class="material-icons suffix green-text active">done</i>
				<input id="name" type="text" class="validate" required name="name">
				<label for="name">Nome do jogo</label>
				<span id="name-error" class="invalid-input" style="left: 0.75rem">Este campo não pode ser vazio!</span>
			</div>
		</div>
		<div class="row">
			<div class="input-field col s12">
				<i class="material-icons suffix green-text active">done</i>
				<textarea id="description" class="materialize-textarea" length="250" name="description" required ></textarea>
				<label for="description">Descrição</label>
				<span id="desc-error" class="invalid-textarea" style="left: 0.75rem">Este campo não pode ser vazio!</span>
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
						%{--<option value="" data-icon="/assets/img/inside/avatar.png" class="left circle">Ação</option>--}%
						%{--<option value="" data-icon="/assets/img/inside/avatar.png" class="left circle">Aventura</option>--}%
						%{--<option value="" data-icon="/assets/img/inside/avatar.png" class="left circle">Educacional</option>--}%
					</select>
					<label for="select">Escolha uma categoria: </label>
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
