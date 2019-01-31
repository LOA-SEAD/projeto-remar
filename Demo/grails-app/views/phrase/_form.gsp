<%@ page import="br.ufscar.sead.loa.demo.remar.Phrase" %>

<div class="fieldcontain ${hasErrors(bean: phraseInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="phrase.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="content" maxlength="150" required="" value="${phraseInstance?.content}"/>

</div>