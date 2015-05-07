
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<script type="text/javascript">
			$(document).ready(function() {
				var val = $("#filter").val()
				$.ajax({
					url: "/user/filteredList?filter=" + val,
					type: "POST",
					failure: function() { console.log("error"); },
					success: function(response) { $("#grid").html(response); }
				});


				$("#filter").keyup(function(event) {
					var val = $("#filter").val()
					$.ajax({
						url: "/user/filteredList?filter=" + val,
						type: "POST",
						failure: function() { console.log("error"); },
						success: function(response) { $("#grid").html(response); }
					});
				});
			});

			//Turn all sorting and paging links into AJAX requests for grid
			function ajaxFilter() {
				console.log("ajax Filter");
			}
		</script>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<br />
			<label for="filter">Seach: </label>
			<input class="filter" name="filter" id="filter" type="text" value="${filter}" />
			<br />
			<br />
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<div id="grid">
				<g:render template="grid" model="model" />
			</div>

		</div>
	</body>
</html>
