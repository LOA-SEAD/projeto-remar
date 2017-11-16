<%@ page import="br.ufscar.sead.loa.demo.remar.Phrase" %>



<div class="fieldcontain ${hasErrors(bean: phraseInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="phrase.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="content" maxlength="150" required="" value="${phraseInstance?.content}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: phraseInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="phrase.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${phraseInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: phraseInstance, field: 'taskId', 'error')} ">
	<label for="taskId">
		<g:message code="phrase.taskId.label" default="Task Id" />
		
	</label>
	<g:textField name="taskId" value="${phraseInstance?.taskId}"/>

</div>

