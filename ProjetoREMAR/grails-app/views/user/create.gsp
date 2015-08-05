<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>

		<link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
		<link href="${resource(dir: 'assets/css', file: 'icomoon.css')}" rel="stylesheet" >
		%{--<g:javascript src="recaptcha.js" />--}%

		<g:javascript src="../assets/js/jquery.min.js" />
		<g:javascript src="../assets/js/jquery.validate.js" />

		<script>
			$(function() {

				var existUser = false;

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
							required: "por favor digite uma senha",
							minlength: "A senha deve ter no minimo 5 caracteres"
						},
						confirm_password: {
							required: "por favor confirme sua senha",
							minlength: "sua senha deve ter no minimo 5 caracteres",
							equalTo: "As senhas não coincidem"
						},
						agree: "Para concluir o cadastro no REMAR você deve aceitar nossos  termos de compromisso" +
						" e política de privacidade"
					},
					highlight: function (element) {
						$(element).closest('.form-group').addClass('has-error');
					},
					unhighlight: function (element) {
						if(existUser == false) {
							$(element).closest('.form-group').removeClass('has-error');
						}
					},
					errorElement: 'span',
					errorClass: 'help-block help-block-create',
					errorPlacement: function (error, element) {
						error.insertAfter(element.parent());
					},

				});

				$('#username').on('keyup', function() {
					var url = location.origin + '/user/exists';
					var data = { username: $("#username").val()};


					$.ajax({
						type:'GET',
						data: data,
						url: url,
						success:function(data){
							if(data == "true"){

								if(!$('#div-username-error').length){
									existUser = true;
									console.log("existe");
									$('#div-username').addClass('has-error')
											.append($("<span/>")
													.attr("id","span-username-error")
													.addClass("icon-close")
													.addClass("icon-style"))

											.after($("<div/>")
													.attr("id","div-username-error")
													.addClass("help-block")
													.addClass("help-block-create")
													.text("Esse nome de usuário já está em uso"));
								}
							}else{
								existUser = false;
								console.log("nao existe");
								$('#div-username').removeClass('has-error');
								$('#span-username-error').remove();
								$('#div-username-error').remove();
							}
						},
						error:function(XMLHttpRequest,textStatus,errorThrown){}});
				});
			});
		</script>

	</head>
	<body>
		<div class="container container-create">
			<header class="row">
				<div class="col-md-12">
					<h1>logo</h1>
				</div>
			</header>
			<article class="row">
				<div class="col-md-12">
					<section>
						<h2 class="password-text-align">Participe do REMAR</h2>
					</section>
					<section>
						<div id="create-user" class="content scaffold-create" role="main">

							<g:form url="[resource:user, action:'save']" >
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
								<fieldset class="buttons">
									<g:submitButton id="submitBtn" name="create" class="btn btn-primary btn-block btn-create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
								</fieldset>
							</g:form>

							<g:hasErrors bean="${user}">
								<g:eachError bean="${user}" var="error">
									<g:if test="${error in org.springframework.validation.FieldError}">
										<g:if test="${error.field == 'username'}">

										</g:if>
										<g:if test="${error.field == 'email'}">
											%{--<script>--}%
												%{--$('#div-email').addClass('has-error')--}%
																	%{--.append($("<div/>")--}%
																	%{--.addClass("help-block")--}%
																	%{--.addClass("help-block-create")--}%
																	%{--.text("Esse email já esta cadastrado"))--}%

																%{--.append($("<span/>")--}%
																	%{--.addClass("icon-close")--}%
																	%{--.addClass("icon-style"));--}%

												%{--$("#email").focus(function(){--}%
													%{--$('.form-group').removeClass('has-error');--}%
													%{--$('.help-block').remove();--}%
													%{--$('.icon-close').remove();--}%
													%{--$('input').off("focus");--}%
												%{--});--}%

											%{--</script>--}%
										</g:if>
									</g:if>
								%{--<g:message error="${error}"/>--}%
								</g:eachError>
							</g:hasErrors>

						</div>
					</section>
				</div>
			</article>
			<footer class="row">
				<div class="col-md-12">
				</div>
			</footer>
		<div>
	</body>
</html>
