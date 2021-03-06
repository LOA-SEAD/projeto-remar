<!DOCTYPE html>
<html>
    <head>
        <g:javascript src="scriptTheme.js"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'stylesheet.css')}" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <g:external dir="css" file="question.css"/>
    </head>
    <body>

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"> <i class="fa fa-table"></i>  Criar Questão</h4>
            </div>
            <div class="widget-content-white glossed">
                <div class="padded">
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${questionInstance}">
                        <ul class="errors" role="alert">
                        <g:eachError bean="${questionInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                        </ul>
                        </g:hasErrors>
                        <h3 class="section-title first-title"><i class="icon-question"></i> Utilize o botão ao lado do campo de texto para indicar a alternativa correta </h3>
                        <g:form url="[resource:questionInstance, action:'save']" >
                            <fieldset class="form">
                                <g:render template="form"/>
                            </fieldset>
                            <br />
                                <a href="#!" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" class="btn waves-effect waves-light remar-orange">
                                    Enviar
                                </a>
                                %{--<g:submitButton name="create" class="btn btn-success btn-lg" value="${message(code: 'default.button.create.label', default: 'Create')}" />--}%
                        </g:form>
                </div>
            </div>
    </body>
</html>
