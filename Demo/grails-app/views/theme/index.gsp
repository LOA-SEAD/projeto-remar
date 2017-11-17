
<%@ page import="br.ufscar.sead.loa.demo.remar.Theme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'theme.label', default: 'Theme')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-theme" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-theme" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
						<td>ID</td>
						<td>Imagem</td>
						<td>Selecionar</td>
					</tr>
				</thead>
				<tbody>
				<g:each in="${themeInstanceList}" status="i" var="themeInstance">
					<tr data-id="${themeInstance.id}" class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${themeInstance.id}</td>
						<td><img src="/demo/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/bg.png" alt="" height="60px" width="60px"></td>
					
						<td>
							<a class="waves-effect waves-light btn btn-select">X</a>
						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${themeInstanceCount ?: 0}" />
			</div>
		</div>

		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script>
		$(".btn-select").click(function(){
		    var id = $(this).closest("tr").attr("data-id");
			window.top.location.href = "/demo/theme/finish/" + id;
		})
	</script>

	</body>
</html>
