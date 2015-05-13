<%@ page import="br.ufscar.sead.loa.remar.User" %>



<table>
	<tr>
		<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
			<td>
				<label for="username">
					<g:message code="user.username.label" default="Username" /><span class="required-indicator">*</span>
				</label>
			</td>
			<td class="spaced_td">
				<g:if test="${source == 'create'}">
					<g:textField name="username" required="" value="${userInstance?.username}" />
				</g:if>
				<g:if test="${source == 'update'}">
					<span name="username">${userInstance?.username}</span>
				</g:if>
			</td>
		</div>
	</tr>

	<tr>
		<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required spaced_tr">
			<td>
				<label for="password">
					<g:message code="user.password.label" default="Password" /><span class="required-indicator">*</span>
				</label>
			</td>
			<td class="spaced_td">
				<g:passwordField name="password" required=""/>
			</td>
		</div>
	</tr>

	<tr>
		<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
			<td>
				<label for="firstName">
					<g:message code="user.name.label" default="Name" /><span class="required-indicator">*</span>
				</label>
			</td>
			<td class="spaced_td">
				<g:textField name="name" required="" value="${userInstance?.name}"/>
			</td>
		</div>
	</tr>

	<tr>
		<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
			<td>
				<label for="firstName">
					<g:message code="user.email.label" default="Email" /><span class="required-indicator">*</span>
				</label>
			</td>
			<td class="spaced_td">
				<g:field type="email" name="email" required="" value="${userInstance?.email}"/>
			</td>
		</div>
	</tr>
</table>
<br />
<div class="fieldcontain">
	<fieldset class="fielset_border">
		<legend><b>Roles</b></legend>
		
		<div style="float: left;">
			<label style="font-weight: normal;" for="ROLE_ADMIN">Admin</label>
			<g:checkBox name="ROLE_ADMIN" value="${admin}" />
		</div>

		<div class="role_div">
			<label style="font-weight: normal;" for="ROLE_PROF">Professor</label>
			<g:checkBox name="ROLE_PROF" value="${prof}" />
		</div>

		<div class="role_div">
			<label style="font-weight: normal;" for="ROLE_STUD">Student</label>
			<g:checkBox name="ROLE_STUD" value="${stud}" />
		</div>

		<div class="role_div">
			<label style="font-weight: normal;" for="ROLE_DESENVOLVEDOR">Desenvolvedor</label>
			<g:checkBox name="ROLE_DESENVOLVEDOR" value="${dev}" />
		</div>

		<div class="role_div">
			<label style="font-weight: normal;" for="ROLE_EDITOR">Editor</label>
			<g:checkBox name="ROLE_EDITOR" value="${editor}" />
		</div>
	</fieldset>
</div>
<br />

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
	<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
	<label style="font-weight: normal;" for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />		
	</label>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
	<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
	<label style="font-weight: normal;" for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
	</label>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
	<g:checkBox name="enabled" value="${userInstance?.enabled}" />
	<label style="font-weight: normal;" for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
	</label>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
	<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
	<label style="font-weight: normal;" for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
	</label>
</div>
