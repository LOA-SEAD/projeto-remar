<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<div id="status" role="complementary">
			<h1>Autenticando...</h1>
			<form name="shiblogin" action="http://${grailsApplication.config.host.url}/j_spring_security_check" method="POST">
				<input type="hidden" name="j_username" value="${user.username}">
				<input type="hidden" name="j_password" value="${password}">
				<p><input type="submit" value="Clique aqui"> caso não seja redirecionado automaticamente.</p>
			</form>
		</div>
		<script type="text/javascript">document.forms.shiblogin.submit()</script>
	</body>
</html>
