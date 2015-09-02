<!DOCTYPE html>
<html>
	<head>
		<title>Configurando um game para o Moodle</title>
	</head>
	<body>
		<div>
			<h1>Configurando um game para o Moodle</h1>

			<g:form url="[action:'save']">
				<div>
					<div class="divider">
					</div>

					<div class="form-group">
						<label class="label-form" for="name">
							Nome<span class="required-indicator">*</span>
						</label>
						<g:textField name="name" class="form-control input-form" required="" />
					</div>

					<div class="form-group">
						<label class="label-form" for="image">
							Imagem<span class="required-indicator">*</span>
						</label>
						<g:textField name="image" class="form-control input-form" required="" />
					</div>

					<div class="form-group">
						<label class="label-form" for="width">
							Largura<span class="required-indicator">*</span>
						</label>
						<g:textField name="width" class="form-control input-form" required="" />
					</div>

					<div class="form-group">
						<label class="label-form" for="height">
							Altura<span class="required-indicator">*</span>
						</label>
						<g:textField name="height" class="form-control input-form" required="" />
					</div>
					
					<div class="form-group">
						<label class="label-form" for="moodleUrl">
							URL<span class="required-indicator">*</span>
						</label>
						<g:textField name="moodleUrl" class="form-control input-form" required="" />
					</div>
				</div>
				<br />
				<fieldset class="buttons">
					<g:submitButton name="create" class="btn btn-primary btn-block btn-create" value="Salvar Configuração" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>