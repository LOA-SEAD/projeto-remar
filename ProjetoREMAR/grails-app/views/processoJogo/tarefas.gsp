<%@ page import="br.ufscar.sead.loa.remar.ProcessoJogo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'processoJogo.label', default: 'ProcessoJogo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<form action="/processoJogo/vincular_tarefas" method="post">
			<div class="row">
				<g:each in="${tarefas}" status="i" var="tarefa">
					<div class="col-sm-3">
						<h3>${tarefa.getName()}</h3>
						<input type="hidden" value="${tarefa.id}" name="task_id[]" id="task_id[]"/>
						<g:select name="user_id[]" from="${usuarios}" optionValue="username" optionKey="camunda_id" noSelection="['':'Escolha um ajudante']"/>
					</div>
				</g:each>
			</div>
			<input type="submit" value="Salvar"/>
		</form>
	</body>
</html>