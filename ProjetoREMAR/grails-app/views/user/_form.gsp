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


