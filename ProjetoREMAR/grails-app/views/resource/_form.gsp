<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>

<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">

	<div class="row">
		<div class="row">
			<div class="input-field col s12">
				<input id="icon_prefix" type="text" class="validate" name="name">
				<label for="icon_prefix">Nome do jogo</label>
			</div>
		</div>
		<div class="row">
			<div class="input-field col s12">
				<textarea id="textarea1" class="materialize-textarea" length="250" name="description"></textarea>
				<label for="textarea1">Textarea</label>
			</div>
		</div>

		<div class="row">
			<div class="col s2 img-preview">
				<img id="img1Preview" style="width: 100px; height: 100px;" />
			</div>
			<div class="col s10">
				<div class="file-field input-field">
					<div class="btn waves-effect waves-light my-orange">
						<span>File</span>
						<input type="file">
					</div>
					<div class="file-path-wrapper">
						<input data-image="true" id="img-1" name="img1" class="file-path validate" type="text" >
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col s2 img-preview">
				<img id="img2Preview" style="width: 100px; height: 100px;" />
			</div>
			<div class="col s10">
				<div class="file-field input-field">
					<div class="btn waves-effect waves-light my-orange">
						<span>File</span>
						<input type="file">
					</div>
					<div class="file-path-wrapper">
						<input data-image="true" name="img2" id="img-2" class="file-path validate" type="text" accept="image/jpeg, image/png">
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col s2 img-preview">
				<img id="img3Preview" style="width: 100px; height: 100px;" />
			</div>
			<div class="col s10">
				<div class="file-field input-field">
					<div class="btn waves-effect waves-light my-orange">
						<span>File</span>
						<input type="file">
					</div>
					<div class="file-path-wrapper">
						<input data-image="true" name="img3" id="img-3" class="file-path validate" type="text" accept="image/jpeg, image/png">
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

	<div class="form-group has-feedback" >
		<div class="pull-right">
			<button type="submit" class="btn waves-effect waves-light my-orange" id="upload" >
				Enviar
			</button>
		</div>
	</div>

</div>
