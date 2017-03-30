<%@ page import="br.ufscar.sead.loa.labteca.remar.Desafio" %>

<!DOCTYPE html>

<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'desafio.label', default: 'Desafio')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:external dir="css" file="desafio.css"/>
	</head>

	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Customização - Desafios
			</p>
		</div>

		<div id="list-desafio" class="content scaffold-list row" role="main">
			<div class="form" id="myForm" >
				<g:render template="form"/>
			</div>
		</div>

		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<g:javascript src="desafio.js" />
	</body>
</html>
