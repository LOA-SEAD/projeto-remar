<%@ page import="br.ufscar.sead.loa.respondasepuder.remar.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'answer', 'error')} required">
    <label for="answer">
        <g:message code="question.answer.label" default="Answer"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="answer1" type="text" value="${questionInstance.answer[0]}" required=""/>
    <g:field name="answer2" type="text" value="${questionInstance.answer[1]}" required=""/>
    <g:field name="answer3" type="text" value="${questionInstance.answer[2]}" required=""/>
    <g:field name="answer4" type="text" value="${questionInstance.answer[3]}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'correctAnswer', 'error')} required">
    <label for="correctAnswer">
        <g:message code="question.correctAnswer.label" default="Correct Answer"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="correctAnswer" type="number" value="${questionInstance.correctAnswer}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'ownerId', 'error')} required">
    <label for="ownerId">
        <g:message code="question.ownerId.label" default="Owner Id"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="ownerId" type="number" value="${questionInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'taskId', 'error')} required">
    <label for="taskId">
        <g:message code="question.taskId.label" default="Task Id"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="taskId" required="" value="${questionInstance?.taskId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'tip', 'error')} required">
    <label for="tip">
        <g:message code="question.tip.label" default="Tip"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="tip" required="" value="${questionInstance?.tip}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="question.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${questionInstance?.title}"/>

</div>

