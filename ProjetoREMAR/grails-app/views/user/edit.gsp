<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		%{--<meta name="layout" content="main">--}%
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="page-header">
            <h1> Admin - Usuários</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Edição de Usuário</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                    	<g:if test="${flash.message}">
							<div class="message" role="status">${flash.message}</div>
						</g:if>

						<g:hasErrors bean="${userInstance}">
							<ul class="errors" role="alert">
								<g:eachError bean="${userInstance}" var="error">
								<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
								</g:eachError>
							</ul>
						</g:hasErrors>

						<g:form url="[resource:userInstance, action:'update']" method="PUT" >
							<g:hiddenField name="version" value="${userInstance?.version}" />
							<fieldset class="form">
								<g:render template="form"/>
							</fieldset>
							<br />
							<fieldset class="buttons">
								<g:actionSubmit class="save btn btn-success" action="update" value="Salvar" />
							</fieldset>
						</g:form>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>
