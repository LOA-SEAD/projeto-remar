<!DOCTYPE html>
<html>
	<head>
        <g:javascript src="imagePreview.js"/>
		<title>Configurando um game para o Moodle</title>
	</head>
	<body>
		<div>
			<h1>Configurando um game para o Moodle</h1>

			<g:uploadForm action="save" method="post">
				<div>
					<div class="divider">
					</div>

					<div class="form-group">
						<label class="label-form" for="name">
							Nome<span class="required-indicator">*</span>
						</label>
						<g:textField name="name" class="form-control input-form" required="" />
					</div>


					%{--<div class="form-group">--}%
						%{--<label class="label-form" for="image">--}%
							%{--Imagem<span class="required-indicator">*</span>--}%
						%{--</label>--}%
						%{--<g:textField name="image" class="form-control input-form" required="" />--}%
					%{--</div>--}%

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
					%{----}%
					%{--<div class="form-group">--}%
						%{--<label class="label-form" for="url">--}%
							%{--URL<span class="required-indicator">*</span>--}%
						%{--</label>--}%
						%{--<g:textField name="url" class="form-control input-form" required="" />--}%
					%{--</div>--}%

					<div class="form-group">
						<label class="label-form" for="game_id">
							Id<span class="required-indicator">*</span>
						</label>
						<g:textField name="game_id" class="form-control input-form" required="" />
					</div>

                    <div class="col-xs-6">
                        <div>
                            <img id="imagePreview" style="width: 200px; height: 200px;" />
                        </div>
                        <br />
                        <input data-image="true"  type="file" name="moodleimage" id="moodleimage" />
                    </div>

					<!--<hr />
					<h3>Jogo disponível para as contas:</h3>

					<div id="account-list">
						
					</div>

					<div style="margin-top: 10px;">
						<button type="button" id="new-account">+ conta</a>
					</div>-->
					<br />
					<input type="submit" name="create" class="btn btn-primary btn-block btn-create" value="Salvar Configuração" />
					<hr />
				</div>
				<br />
			</g:uploadForm>
		</div>
	</body>
</html>
