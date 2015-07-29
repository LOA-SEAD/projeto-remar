<!DOCTYPE html>
<html>
	<head>
		<title>Configurando um game para o Moodle</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

		<script type="text/javascript">
			currentAccount = 1;

			$(document).ready(function() {
				newAccount();

				$('#new-account').click(function() {
					newAccount();
				});
			});

			function newAccount() {
				var local = currentAccount + 1;
				local--;
				console.log("currentAccount: " + currentAccount + ", local: " + local);

				var mainDiv = jQuery('<div/>', {
					id: 'main-div'+local,
					class: 'form-group',
					style: 'margin-top: 10px;'
				});
				var label1 = jQuery('<label>', {
					class: 'label-form',
					for: 'select'+local,
					html: 'Moodle<span class="required-indicator">*</span>',
					style: 'float: left;'
				});
				var select = jQuery('<div/>', {
					id: 'select'+local,
					name: 'select'+local,
					style: 'margin-left: 10px; float: left;',
					required: 'required'
				});
				var clearDiv = jQuery('<div/>', {
					style: 'clear: both;'
				});
				var label2 = jQuery('<label>', {
					class: 'label-form',
					for: 'prof'+local,
					html: 'Contra do prof.<span class="required-indicator">*</span>',
					style: 'float: left; margin-left: 30px'
				});
				var textField = jQuery('<input>', {
					type: 'text',
					id: 'prof'+local,
					name: 'prof' + local,
					style: 'float: left; margin-left: 10px;',
					required: 'required'
				});
				
				$('#account-list').append(mainDiv);
				$('#main-div'+local).append(label1);
				$('#main-div'+local).append(select);
				$('#main-div'+local).append(label2);
				$('#main-div'+local).append(textField);
				$('#main-div'+local).append(clearDiv);

				$.ajax({
					url: "${createLink(action:'loadMoodleList')}",
					type: 'GET',
					success: function(data, status){
						$("#select"+local).append(data);
					}
				});

				currentAccount++;
			}
		</script>
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
						<label class="label-form" for="url">
							URL<span class="required-indicator">*</span>
						</label>
						<g:textField name="url" class="form-control input-form" required="" />
					</div>

					<div class="form-group">
						<label class="label-form" for="game_id">
							Id<span class="required-indicator">*</span>
						</label>
						<g:textField name="game_id" class="form-control input-form" required="" />
					</div>

					<hr />
					<h3>Jogo disponível para as contas:</h3>

					<div id="account-list">
						
					</div>

					<div style="margin-top: 10px;">
						<button type="button" id="new-account">+ conta</a>
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
