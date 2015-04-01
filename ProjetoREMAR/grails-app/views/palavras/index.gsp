
<%@ page import="projetoremar.Palavras" %>
<!DOCTYPE html>
<html>
	<head>
        <g:javascript src="editableTable.js"/>
        <g:javascript src="scriptTable.js"/>
        <meta property="user_name" content="${user_name}"/>

		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'palavras.label', default: 'Palavras')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'index.css')}" />
	</head>
	<body>
		<a href="#list-palavras" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="list-palavras" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="table">
			<thead>
					<tr>
                        <th>Selecionar</th>
						<g:sortableColumn property="dica" title="${message(code: 'palavras.dica.label', default: 'Dica')}" />

						<g:sortableColumn property="resposta" title="${message(code: 'palavras.resposta.label', default: 'Resposta')}" />

						<g:sortableColumn property="contribuicao" title="${message(code: 'palavras.contribuicao.label', default: 'Contribuicao')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${palavrasInstanceList}" status="i" var="palavrasInstance">
					<tr data-id="${fieldValue(bean: palavrasInstance, field: "id")}" data-checked="false" class="${(i % 2) == 0 ? 'even' : 'odd'}">
					    <td class="_not_editable"> <input class="checkbox" type="checkbox"/>  </td>

						<td>${fieldValue(bean: palavrasInstance, field: "dica")}</td>

						<td>${fieldValue(bean: palavrasInstance, field: "resposta")} </td>

						<td >${fieldValue(bean: palavrasInstance, field: "contribuicao")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
            <fieldset class="buttons">
                <g:submitButton  name="create" class="create" value="Criar nova questão" />
                <g:submitButton  name="delete" class="delete" value="Remover questões selecionadas"/>

            </fieldset>
			<div class="pagination">
				<g:paginate total="${palavrasInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
