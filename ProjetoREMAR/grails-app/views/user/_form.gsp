<%@ page import="br.ufscar.sead.loa.remar.User" %>



<div class="fieldcontain ${hasErrors(bean: user, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${user?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${user?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="user.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${user?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${user?.email}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'camunda_id', 'error')} ">
	<label for="camunda_id">
		<g:message code="user.camunda_id.label" default="Camundaid" />
		
	</label>
	<g:textField name="camunda_id" value="${user?.camunda_id}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'facebookId', 'error')} ">
	<label for="facebookId">
		<g:message code="user.facebookId.label" default="Facebook Id" />
		
	</label>
	<g:textField name="facebookId" value="${user?.facebookId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${user?.accountExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${user?.accountLocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${user?.enabled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: user, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${user?.passwordExpired}" />

</div>

