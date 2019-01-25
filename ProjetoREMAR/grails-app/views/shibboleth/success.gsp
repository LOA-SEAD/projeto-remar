<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<div id="status" role="complementary">
			<h1>Autenticando...</h1>
			<form name="shiblogin" action="/j_spring_security_check">
				<input type="hidden" name="username" value="${user.username}">
				<input type="password" style="display:none;" name="password" value="${user.password}">
				<p><a type="submit" href="#">Clique aqui</a> caso não seja redirecionado automaticamente.</p>
			</form>
		</div>
		<script type="text/javascript">document.forms.shiblogin.submit()</script>
	</body>
</html>
