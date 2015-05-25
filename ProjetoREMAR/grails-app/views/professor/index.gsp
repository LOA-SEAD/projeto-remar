
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title>Prof page</title>
	</head>
	<body>
		<div class="row">
			<div class="col-sm-6">
				<h3>Tarefas do usuário</h3>
				<g:each in="${tarefasDoUsuario}" status="i" var="tarefa">
					<p>${tarefa.getId()} <g:link action="completar_tarefa" id="${tarefa.getId()}">completar</g:link></p>
				</g:each>
			</div>
			<div class="col-sm-6">
				<h3>Tarefas candidatas</h3>
				<g:each in="${tarefasCandidatas}" status="i" var="tarefa">
					<p><g:link action="tarefa" id="${tarefa.getId()}">${tarefa.getId()}</g:link></p>
				</g:each>
			</div>
		</div>
	</body>
</html>
