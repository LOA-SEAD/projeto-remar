<%@ page import="br.ufscar.sead.loa.escolamagica.remar.QuestionEscola" %>


<div class="fieldcontain ${hasErrors(bean: questionEscolaInstance, field: 'answers', 'error')} required col-xs-6">
    <div class="input-group">
        <span class="input-group-addon">
            <g:message code="question.title.label" default="Pergunta" />*
        </span>
        <g:textField name="title" required="" value="${questionEscolaInstance?.title}"/>
    </div>
</div>
<div class="clearfix"></div>
<div class="fieldcontain ${hasErrors(bean: questionEscolaInstance, field: 'answers', 'error')} required col-xs-6">
    <div class="input-group">
        <span class="input-group-addon"><g:message code="question.answers.label" default="Alternativa 1" />*</span>
        <g:textField name="answers[0]" required=""/> <input type="radio" value="0" name="correctAnswer" />
    </div>
</div>
<div class="clearfix"></div>
<div class="fieldcontain ${hasErrors(bean: questionEscolaInstance, field: 'answers', 'error')} required col-xs-6">
    <div class="input-group">
        <span class="input-group-addon"><g:message code="question.answers.label" default="Alternativa 2" />*</span>
        <g:textField name="answers[1]" required=""/> <input type="radio" value="1" name="correctAnswer" />
    </div>
</div>
<div class="clearfix"></div>
<div class="fieldcontain ${hasErrors(bean: questionEscolaInstance, field: 'answers', 'error')} required col-xs-6">
    <div class="input-group">
        <span class="input-group-addon"><g:message code="questionEscola.answers.label" default="Alternativa 3" />*</span>
        <g:textField name="answers[2]" required=""/> <input type="radio" value="2" name="correctAnswer" />
    </div>
</div>
<div class="clearfix"></div>
<div class="fieldcontain ${hasErrors(bean: questionEscolaInstance, field: 'answers', 'error')} required col-xs-6">
    <div class="input-group">
        <span class="input-group-addon"><g:message code="questionEscola.answers.label" default="Alternativa 4" />*</span>
        <g:textField name="answers[3]" required=""/> <input type="radio" value="3" name="correctAnswer" />
    </div>
</div>

<div class="clearfix"></div>
<div class="fieldcontain ${hasErrors(bean: questionEscolaInstance, field: 'answers', 'error')} required col-xs-6">
    <div class="input-group">
        <span class="input-group-addon"><g:message code="questionEscola.level.label" default="Classe" />*</span>
        <g:select name="level" class="form-control" from="${questionEscolaInstance.constraints.level.inList}" required="" value="${questionEscolaInstance?.level}" valueMessagePrefix="questionEscola.level"/>
    </div>
</div>

<div class="clearfix"></div>