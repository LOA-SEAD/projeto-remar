<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<div id="status" role="complementary">
			<h1>Autenticando...</h1>
			<form name="shiblogin" action="/j_spring_security_check" method="POST">
				<input type="hidden" name="j_username" value="${user.username}">
				<input type="hidden" name="j_password" value="${password}">
				<input type="submit" href="#">Clique aqui </input><p>caso não seja redirecionado automaticamente.</p>
			</form>
		</div>
		<script type="text/javascript">document.forms.shiblogin.submit()</script>
	</body>
</html>
