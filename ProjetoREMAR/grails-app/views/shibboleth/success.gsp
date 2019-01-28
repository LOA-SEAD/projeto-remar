<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<div id="status" role="complementary">
			<h1>Autenticando...</h1>
			<form name="shiblogin" action="${redirectUrl}" method="POST">
				<input type="hidden" name="j_username" value="${user.username}">
				<input type="hidden" name="j_password" value="${user.password}">
				<p><a type="submit" href="#">Clique aqui</a> caso não seja redirecionado automaticamente.</p>
			</form>
		</div>
		<script type="text/javascript">document.forms.shiblogin.submit()</script>
	</body>
</html>
