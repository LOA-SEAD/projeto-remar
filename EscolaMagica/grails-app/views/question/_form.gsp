<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>

<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover" id="table">
        <tr>
            <td>
                <label for="title">
                    <g:message code="question.title.label" default="Pergunta" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField class="form-control" id="title" name="title" required="" value="${questionInstance?.title}"/>
            </td>
        </tr>

        <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required spaced_tr">
            <td>
                <label for="answers[0]">
                    <g:message code="question.answers.label" default="Alternativa 1" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField class="form-control" id="answers[0]" name="answers[0]" required="" value="${questionInstance.answers[0]}"/>
            </td><td><g:radio name="correctAnswer" value="0" checked="${questionInstance.correctAnswer == 0}"/>

            </td>
        </div>
        </tr>

        <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required spaced_tr">
            <td>
                <label for="answers[1]">
                    <g:message code="question.answers.label" default="Alternativa 2" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField class="form-control" id="answers[1]" name="answers[1]" required="" value="${questionInstance.answers[1]}"/>
            </td><td><g:radio name="correctAnswer" value="1" checked="${questionInstance.correctAnswer == 1}"/>

            </td>
        </div>
        </tr>

        <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
            <td>
                <label for="answers[2]">
                    <g:message code="question.answers.label" default="Alternativa 3" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField class="form-control" id="answers[2]" name="answers[2]" required="" value="${questionInstance.answers[2]}"/>
            </td><td><g:radio name="correctAnswer" value="2" checked="${questionInstance.correctAnswer == 2}"/>

            </td>
        </div>
        </tr>

        <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
            <td>
                <label for="answers[3]">
                    <g:message code="question.answers.label" default="Alternativa 4" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField class="form-control" id="answers[3]" name="answers[3]" required="" value="${questionInstance.answers[3]}"/>
            </td><td><g:radio name="correctAnswer" value="3" checked="${questionInstance.correctAnswer == 3}"/>
            </td>
        </div>
        </tr>

        <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
            <td>
                <label for="level">
                    Nível<span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:select id="level" name="level" class="form-control" from="${questionInstance.constraints.level.inList}" required="" value="${questionInstance?.level}" valueMessagePrefix="question.level"/>
            </td>
        </div>
        </tr>
    </table>
</div>
<br />
