<%@ page import="br.ufscar.sead.loa.remar.ProcessoJogo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'processoJogo.label', default: 'ProcessoJogo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<g:each in="${tarefas}" status="i" var="tarefa">
			<g:select name="user_id_${tarefa.id}" from="${usuarios}" optionValue="username" optionKey="id" />
		</g:each>
	</body>
</html>