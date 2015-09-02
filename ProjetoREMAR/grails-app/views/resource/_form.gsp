<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>

<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">
	<label for="war">
		<g:message code="deploy.war_file.label" default="WAR file:" />
		<span class="required-indicator">*</span>
	</label>
	<span class="btn">
		<input type="file" name="war" />
	</span>
</div>
