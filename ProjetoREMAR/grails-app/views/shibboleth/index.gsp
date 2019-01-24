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
                    <td>Key</td>
                    <td>Value</td>
                </tr>
			<g:each var='attr' in="${requestAttrs}">
                <tr>
                    <td>${attr.key}</td>
                    <td>${attr.value}</td>
                </tr>
			</g:each>
			</table>
		</div>
	</body>
</html>
