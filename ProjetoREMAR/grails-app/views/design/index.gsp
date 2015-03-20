
<%@ page import="projetoremar.Design" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'design.label', default: 'Design')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-design" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-design" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>

					
						<g:sortableColumn property="icone" title="${message(code: 'design.icone.label', default: 'Icone')}" />
					
						<g:sortableColumn property="telaFundo" title="${message(code: 'design.telaFundo.label', default: 'Tela Fundo')}" />
					
						<g:sortableColumn property="telaAbertura" title="${message(code: 'design.telaAbertura.label', default: 'Tela Abertura')}" />
					
					</tr>
				</thead>
				<tbody>

                        <td><asset:image  src="icon.png" width="100" height="100"/></td>


                        <td><asset:image  src="open.png" width="100" height="100"/></td>


                         <td><asset:image  src="background.png" width="100" height="100"/></td>

				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${designInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
