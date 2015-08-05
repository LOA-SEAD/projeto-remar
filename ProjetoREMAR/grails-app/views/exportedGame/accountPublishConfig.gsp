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

				$("#form").submit(function(event) {
					var validator = $("#account-list").has("div").length;
					if (validator <= 0) {
						return false;
					}
					else {
						return true;
					}
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
					for: 'moodle'+local,
					html: 'Moodle<span class="required-indicator">*</span>',
					style: 'float: left;'
				});
				var select = jQuery('<div/>', {
					id: 'moodle'+local,
					name: 'moodle'+local,
					style: 'margin-left: 10px; float: left;',
					required: 'required'
				});
				var clearDiv = jQuery('<div/>', {
					style: 'clear: both;'
				});
				var label2 = jQuery('<label>', {
					class: 'label-form',
					for: 'account'+local,
					html: 'Contra do prof.<span class="required-indicator">*</span>',
					style: 'float: left; margin-left: 30px'
				});
				var textField = jQuery('<input>', {
					type: 'text',
					id: 'account'+local,
					name: 'account' + local,
					style: 'float: left; margin-left: 10px;',
					required: 'required'
				});
				var hiddenId = jQuery('<input>', {
					type: 'hidden',
					value: local,
					id: 'id'+local
				});
				//var deleteButton = $('<button type="button" id="deleteButton'+local+'" style="margin-left: 20px">X</button>');
				var deleteButton = jQuery('<button/>', {
					text: 'X',
					type: 'button',
					style: 'margin-left: 20px;',
					id: 'deleteButton'+local
				});
				
				$('#account-list').append(mainDiv);
				$('#main-div'+local).append(label1);
				$('#main-div'+local).append(select);
				$('#main-div'+local).append(label2);
				$('#main-div'+local).append(textField);
				$('#main-div'+local).append(hiddenId);
				$('#main-div'+local).append(deleteButton);
				$('#main-div'+local).append(clearDiv);

				$.ajax({
					url: "${createLink(action:'loadMoodleList')}",
					type: 'GET',
					data: {local: local},
					success: function(data, status){
						$("#moodle"+local).append(data);
					}
				});

				$('#deleteButton'+local).click(function() {
					var id = $('#id'+local).val();
					$('#main-div'+id).remove();
				})

				currentAccount++;
			}
		</script>
	</head>
	<body>
		<div>
			<h3>Jogo disponível para as contas:</h3>
			<g:form url="[action:'accountSave']" id="form">
				<div id="account-list">
					
				</div>

				<div style="margin-top: 10px;">
					<button type="button" id="new-account">+ conta</a>
				</div>
				<g:hiddenField name="moodleGameId" value="${moodleGameInstance.id}" />
				<br />
				<g:submitButton name="create" class="btn btn-primary btn-block btn-create" value="Salvar Configuração" />
				<hr />
			</g:form>
		</div>
	</body>
</html>
