
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="page-header">
            <h1> Admin - Usuários</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Usuário</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                    	<g:if test="${flash.message}">
							<div class="message" role="status">${flash.message}</div>
						</g:if>
						<g:if test="${userInstance?.username}">
							<p>
								<b>
									<span id="username-label" class="property-label">
										<g:message code="user.username.label" default="Username" />: 
									</span>
								</b>
								<span class="property-value" aria-labelledby="username-label">
									<g:fieldValue bean="${userInstance}" field="username"/>
								</span>
							</p>
						</g:if>
					
						<g:if test="${userInstance?.name}">
							<p>
								<b>
									<span id="name-label" class="property-label">
										<g:message code="user.name.label" default="Name" />: 
									</span>
								</b>
								<span class="property-value" aria-labelledby="name-label">
									<g:fieldValue bean="${userInstance}" field="name"/>
								</span>
							</p>
						</g:if>
					
						<g:if test="${userInstance?.email}">
							<p>
								<b>
									<span id="email-label" class="property-label">
										<g:message code="user.email.label" default="Email" />: 
									</span>
								</b>
								<span class="property-value" aria-labelledby="email-label">
									<g:fieldValue bean="${userInstance}" field="email"/>
								</span>
							</p>
						</g:if>
					
						<g:if test="${userInstance?.enabled}">
							<p>
								<b>
									<span id="enabled-label" class="property-label">
										<g:message code="user.enabled.label" default="Enabled" />: 
									</span>
								</b>
								<span class="property-value" aria-labelledby="enabled-label">
									<g:formatBoolean boolean="${userInstance?.enabled}" />
								</span>
							</p>
						</g:if>
					
						<g:if test="${userInstance?.getRoles()}">
							<p>
								<b>
									<span id="roles-label" class="property-label">Roles: </span>
								</b>
								<span class="property-value" aria-labelledby="roles-label">${userInstance.getRoles()}</span>
							</p>
						</g:if>
            			
            			<br />
						<g:form url="[resource:userInstance, action:'delete']" method="DELETE">
							<fieldset class="buttons">
								<g:link class="edit btn btn-success" action="edit" resource="${userInstance}"><g:message code="default.button.edit.labelsd" default="Editar" /></g:link>
								<g:actionSubmit style="margin-left: 12px;" class="delete btn btn-danger" action="delete" value="Excluir" onclick="return confirm('Tem certeza que deseja excluir?');" />
							</fieldset>
						</g:form>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>
