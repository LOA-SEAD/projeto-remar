<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="scriptTheme.js"/>
        <!--<g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />-->
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header">
            <h1> Criar Questões</h1>
        </div>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Criar uma questão</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${questionEscolaInstance}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${questionEscolaInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                    </g:eachError>
                            </ul>
                        </g:hasErrors>
                        <h3 class="section-title first-title"><i class="icon-question"></i> Utilize o botão ao lado do campo de texto para indicar a questão certa</h3>
                        <g:form url="[resource:questionEscolaInstance, action:'save']" >
                            <fieldset class="form">
                                <g:render template="form"/>
                            </fieldset>
                            <br />
                            <fieldset class="buttons">
                                <g:submitButton name="create" class="btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                                <g:link class="btn btn-warning btn-lg" action="index">Voltar</g:link>
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
