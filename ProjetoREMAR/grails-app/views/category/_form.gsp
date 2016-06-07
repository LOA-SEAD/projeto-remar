<%@ page import="br.ufscar.sead.loa.remar.Category" %>



<div class="fieldcontain ${hasErrors(bean: category, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${category?.name}"/>

</div>

