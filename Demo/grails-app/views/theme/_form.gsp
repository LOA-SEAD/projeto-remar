<%@ page import="br.ufscar.sead.loa.demo.remar.Theme" %>



<div class="fieldcontain ${hasErrors(bean: themeInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="theme.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${themeInstance.ownerId}" required=""/>

</div>

