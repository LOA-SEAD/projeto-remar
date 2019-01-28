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
				<input type="hidden" name="username" value="admin">
				<input type="submit" href="#">Clique aqui </input><p>caso não seja redirecionado automaticamente.</p>
			</form>
		</div>
		<script type="text/javascript">document.forms.shiblogin.submit()</script>
	</body>
</html>
