<%@ page import="br.ufscar.sead.loa.escolamagica.remar.QuestionEscola" %>


<table>
    <tr>
        <td>
            <label for="title">
                <g:message code="question.title.label" default="Pergunta" /><span style="color:red">*</span>
            </label>
        </td>
        <td class="spaced_td">
            <g:textField id="title" name="title" required="" value="${questionEscolaInstance?.title}"/>
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
                <g:textField id="answers[0]" name="answers[0]" required="" value="${questionEscolaInstance.answers[0]}"/>
<g:radio name="correctAnswer" value="0" checked="${questionEscolaInstance.correctAnswer == 0}"/>

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
                <g:textField id="answers[1]" name="answers[1]" required="" value="${questionEscolaInstance.answers[1]}"/>
<g:radio name="correctAnswer" value="1" checked="${questionEscolaInstance.correctAnswer == 1}"/>

            </td>
        </div>
    </tr>

    <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
            <td>
                <label for="answers[2]">
                    <g:message code="questionEscola.answers.label" default="Alternativa 3" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField id="answers[2]" name="answers[2]" required="" value="${questionEscolaInstance.answers[2]}"/>
<g:radio name="correctAnswer" value="2" checked="${questionEscolaInstance.correctAnswer == 2}"/>

            </td>
        </div>
    </tr>

    <tr>
        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
            <td>
                <label for="answers[3]">
                    <g:message code="questionEscola.answers.label" default="Alternativa 4" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField id="answers[3]" name="answers[3]" required="" value="${questionEscolaInstance.answers[3]}"/>
<g:radio name="correctAnswer" value="3" checked="${questionEscolaInstance.correctAnswer == 3}"/>
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
                <g:select id="level" name="level" class="form-control" from="${questionEscolaInstance.constraints.level.inList}" required="" value="${questionEscolaInstance?.level}" valueMessagePrefix="questionEscola.level"/>
            </td>
        </div>
    </tr>
</table>
<br />
