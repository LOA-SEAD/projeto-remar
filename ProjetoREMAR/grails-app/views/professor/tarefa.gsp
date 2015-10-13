
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		%{--<meta name="layout" content="main">--}%
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title>Prof page</title>
	</head>
	<body>
		<div class="row">
			<h3>Tarefa</h3>
			<div class="col-sm-6">
				<h4>Assumir tarefa</h4>
				<g:link action="assumir_tarefa" id="${tarefa.getId()}">Assumir</g:link>
			</div>
			<div class="col-sm-6">
				<h4>Delegar tarefa</h4>

				<form action="/professor/delegar_tarefa" method="post">
					<input type="hidden" value="${tarefa.id}" name="task_id" id="task_id"/>
					<h3>${tarefa.getName()}</h3>
					<div class="row">
						<div class="col-sm-3">
							<g:select name="user_id" from="${usuarios}" optionValue="username" optionKey="camunda_id"/>
						</div>
					</div>
					<input type="submit" value="Salvar"/>
				</form>
			</div>
		</div>
	</body>
</html>
