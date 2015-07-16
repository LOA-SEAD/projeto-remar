<%@ page import="br.ufscar.sead.loa.remar.User" %>
<div class="divider">
</div>
<div class="form-group">
	<label class="label-form" for="firstName">
		<g:message code="user.name.label" default="Nome" /><span class="required-indicator">*</span>
	</label>
	<g:textField name="name" class="form-control input-form" required="" value="${userInstance?.name}" />
</div>
<div class="form-group">
	<label class="label-form" for="firstName">
		<g:message code="user.email.label" default="Email" /><span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" class="form-control input-form" required="" value="${userInstance?.email}"  placeholder="nome@exemplo.com" />

</div>
<div class="form-group">
	<label class="label-form" for="username">
		<g:message code="user.username.label" default="Nome de usu&aacute;rio" /><span class="required-indicator">*</span>
	</label>
	<g:if test="${source == 'create'}">
		<g:textField id="Name" class="form-control input-form" name="username" required="" value="${userInstance?.username}" />
	</g:if>
	<g:if test="${source == 'update'}">
		<span name="username">${userInstance?.username}</span>
	</g:if>
</div>
<div class="form-group">
	<label class="label-form" for="password">
		<g:message   code="user.password.label" default="Password" /><span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" class="form-control input-form" required="" />
</div>


