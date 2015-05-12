<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>

<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'id_deploy', 'error')} required">
	<label for="id_deploy">
		<g:message code="deploy.id_deploy.label" default="Nome do jogo" />
		<span class="required-indicator">*</span>
	</label>
	<input type="text" name="id_deploy"/>
</div>

<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war_filename', 'error')} required">
	<label for="war_file">
		<g:message code="deploy.war_file.label" default="Arquivo .war" />
		<span class="required-indicator">*</span>
	</label>
	<input type="file" name="war_file"/>
</div>

