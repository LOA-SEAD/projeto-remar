<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<h1> Hello Grails! </h1>
		<div id="status" role="complementary">
			<h1>Application Status</h1>
			<table>
                <tr>
                    <td>Hello</td>
                    <td>World</td>
                </tr>
                <tr>
                    <td>Logged in as: ${user.username}</td>
                    <td>${user.email}</td>
                </tr>
			</table>
		</div>
	</body>
</html>
