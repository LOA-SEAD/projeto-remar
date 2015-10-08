<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>

<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">



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

	<div class="form-group has-feedback" >
		<div class="pull-right">
			<button type="submit" class="btn btn-primary btn-file btn-flat" id="upload" >
				Enviar
			</button>
		</div>
	</div>

</div>



