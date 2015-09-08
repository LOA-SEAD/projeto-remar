<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="new-main-external">
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
	<title>Registre-se</title>

</head>
<body>
	<h3 class="label-info-title">Obrigado por se cadastrar!</h3>
	<div class="form-group">
		<label class="label-info-user" for="firstName">
			<g:message code="user.email.label" default="Aguarde um recebimento de email no endere&ccedil;o " />
			<g:fieldValue bean="${userInstance}" field="email"/>
			<g:message code="user.email.label" default=" para confirmar seu cadastro" />
		</label>
		%{--<g:link class="footer-span" controller="index" action="index">Home</g:link>--}%
	</div>
</body>
</html>
