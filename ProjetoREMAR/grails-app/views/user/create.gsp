<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="new-main-external">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title>Registrar-se</title>

		<g:javascript src="recaptcha.js" />

		<script>
			$(function() {

				var existUser = false;
				var existEmail = false;

				$('form').validate({
					rules: {
						name: {
							required: true
						},
						email: {
							email: true,
							required: true
						},
						username: {
							minlength: 2,
							required: true
						},
						password: {
							minlength: 5,
							required: true
						},
						confirm_password: {
							required: true,
							minlength: 5,
							equalTo: "#password"
						},
						agree: "required"
					},
					messages: {
						name: {
							required: "Por favor digite o seu nome"
						},
						email: {
							required: "Por favor digite um email",
							email: "Digite um email no formato: nome@exemplo"
						},
						username: {
							required: "Por favor digite um nome de usuário",
							minlength: "O nome de usuário de ter ao menos 2 caracteres"
						},
						password: {
							required: "Por favor digite uma senha",
							minlength: "A senha deve ter no minimo 5 caracteres"
						},
						confirm_password: {
							required: "Por favor confirme sua senha",
							minlength: "Sua senha deve ter no minimo 5 caracteres",
							equalTo: "As senhas não coincidem"
						},
						agree: ""
					},
					highlight: function (element) {
						$(element).closest('.form-group')
								  .addClass('has-error');

//						if(element.closest("input").name == "agree"){
//							$(element).closest('.form-group')
//									.addClass('has-error');
//						}

					},
					unhighlight: function (element) {

						if(element.closest("input").name == "igree") {
							$(element).closest('.control-label').removeClass('has-error')
						}


						if(!(element.closest("input").name == "username")&&
								!(element.closest("input").name == "email")) {

							$(element).closest('.form-group').removeClass('has-error')
										.closest('.control-label').remove();
						}else{
							if((element.closest("input").name == "username") && !existUser){
								$(element).closest('.form-group').removeClass('has-error')
										.closest('.control-label').remove();

							}else if((element.closest("input").name == "email") && !existEmail){
								$(element).closest('.form-group').removeClass('has-error')
										.closest('.control-label').remove();
							}
						}
					},
					errorElement: 'div',
					errorClass: 'control-label',
					errorPlacement: function (error, element) {
						error.insertAfter(element.next());
					}

				});

				$('#username').on('keyup', function() {
					var url = location.origin + '/user/exists';
					var data = { username: $("#username").val()};
					var text = data;

					$.ajax({
						type:'GET',
						data: data,
						url: url,
						success:function(data){
							if(data == "true"){
								if(!$('#div-username-error').length){
									existUser = true;
									$('#div-username').addClass('has-error')
														.append($("<div/>")
																.attr("id","div-username-error")
																.addClass("control-label")
																.text("Esse nome de usuário já está em uso"));
								}
							}else{
								if(text.username.length > 1 && existUser){
									existUser = false;
									$('#div-username').removeClass('has-error');
									$('#div-username-error').remove();
								}
							}
						},
						error:function(XMLHttpRequest,textStatus,errorThrown){}});
				});

				$('#email').on('keyup', function() {
					var url = location.origin + '/user/existsEmail';
					var data = { email: $("#email").val()};
					var text = data;

					$.ajax({
						type:'GET',
						data: data,
						url: url,
						success:function(data){
							if(data == "true"){
								if(!$('#div-email-error').length){
									existEmail = true;
									$('#div-email').addClass('has-error')
													.append($("<div/>")
															.attr("id","div-email-error")
															.addClass("control-label")
															.text("Esse email já está em uso"));
								}
							}else{
								if(text.email.length > 1 && existEmail){
									existEmail = false;
									$('#div-email').removeClass('has-error');
									$('#div-email-error').remove();
								}
							}
						},
						error:function(XMLHttpRequest,textStatus,errorThrown){}});
				});

			});
		</script>

	</head>
	<body>
		<p class="login-box-msg">Registrar um novo membro</p>
		<g:form url="[resource:user, action:'save']" >
			<div class="row">
				<g:render template="form"/>
				<div class="col-xs-12">
					<button type="submit" class="btn btn-primary btn-block btn-flat" name="create" id="submitBtn">Registrar</button>
				</div><!-- /.col -->
			</div>
		</g:form>
	</body>
</html>
