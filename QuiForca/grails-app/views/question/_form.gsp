<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover" id="table">
        <tr>
            <td>
                <label for="statement">
                    <g:message code="question.statement.label" default="Pergunta" /><span style="color:red">*</span>
                </label>
            </td>
            <td class="spaced_td">
                <g:textField class="form-control" id="statement" name="statement" required="" value="${questionInstance?.statement}"/>
            </td>
        </tr>

        <tr>
            <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required spaced_tr">
                <td>
                    <label for="answer">
                        <g:message code="question.answer.label" default="Resposta" /><span style="color:red">*</span>
                    </label>
                </td>
                <td class="spaced_td">
                    <g:textField class="form-control" id="answer" name="answer" required="" value="${questionInstance?.answer}"/>
                </td>

            </td>
            </div>
        </tr>

        <tr>
            <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required spaced_tr">
                <td>
                    <label for="category">
                        <g:message code="question.category.label" default="Tema" /><span style="color:red">*</span>
                    </label>
                </td>
                <td class="spaced_td">
                    <g:textField class="form-control" id="category" name="category" required="" value="${questionInstance?.category}"/>
                </td>

            </td>
            </div>
        </tr>

        <tr>
            <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
                <td>
                    <label for="author">
                        <g:message code="question.author.label" default=" Autor" /><span style="color:red">*</span>
                    </label>
                </td>
                <td class="spaced_td">
                    <g:textField class="form-control" id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}"/>
                </td>

            </td>
            </div>
        </tr>
    </table>
</div>
<br />
