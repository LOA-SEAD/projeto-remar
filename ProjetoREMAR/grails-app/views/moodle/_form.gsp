<%@ page import="br.ufscar.sead.loa.remar.Moodle" %>

<table>
	<tr>
		<div class="fieldcontain ${hasErrors(bean: moodleInstance, field: 'password', 'error')} required">
			<td>
				<label for="password">
					<g:message code="user.name.label" default="Password" /><span class="required-indicator">*</span>
				</label>
			</td>
			<td class="spaced_td">
				<g:textField name="password" required="" value="${moodleInstance?.password}"/>
			</td>
		</div>
	</tr>

	<tr>
		<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'domain', 'error')} required">
			<td>
				<label for="domain">
					<g:message code="user.email.label" default="Domain" /><span class="required-indicator">*</span>
				</label>
			</td>
			<td class="spaced_td">
				<g:textField name="domain" required="" value="${userInstance?.domain}"/>
			</td>
		</div>
	</tr>
</table>
<br />


