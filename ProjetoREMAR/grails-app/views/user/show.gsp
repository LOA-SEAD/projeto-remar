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

%{--<div class="container container-create">--}%
	%{--<header class="row">--}%
		%{--<div class="col-md-12">--}%
			%{--<h1>logo</h1>--}%
		%{--</div>--}%
	%{--</header>--}%
	%{--<article class="row">--}%
		%{--<div class="col-md-12">--}%
			%{--<section>--}%
				%{--<h3 class="title-style">Obrigado por se cadastrar!</h3>--}%
				%{--<div class="divider"></div>--}%
			%{--</section>--}%
			%{--<section>--}%
				%{--<div class="form-group">--}%
					%{--<label class="label-info" for="firstName">--}%
						%{--<g:message code="user.email.label" default="Aguarde um recebimento de email no endere&ccedil;o " />--}%
						%{--<g:fieldValue bean="${userInstance}" field="email"/>--}%
						%{--<g:message code="user.email.label" default=" para confirmar seu cadastro" />--}%
					%{--</label>--}%
				%{--</div>--}%
			%{--</section>--}%
			%{--<section>--}%
				%{--<span class="footer-span" id="link-password"><g:link class="footer-span" controller="index" action="index">Home</g:link></span>--}%
			%{--</section>--}%
		%{--</div>--}%
	%{--</article>--}%
	%{--<footer class="row">--}%
		%{--<div class="col-md-12">--}%
		%{--</div>--}%
	%{--</footer>--}%
%{--</div>--}%
</body>
</html>
