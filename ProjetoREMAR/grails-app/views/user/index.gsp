
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		%{--<meta name="layout" content="main">--}%
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
		<div class="page-header">
            <h1>Admin - Usuários</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Lista de Usuários</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                    	<label for="filter">Buscar: </label>
                    	<input class="filter" name="filter" id="filter" type="text" value="${filter}" />
                    	<br />
                    	<br />
                    	<g:if test="${flash.message}">
							<div class="message" role="status">${flash.message}</div>
						</g:if>
                        <div class="table-responsive">
                            <div id="grid">
								<g:render template="grid" model="model" />
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>
