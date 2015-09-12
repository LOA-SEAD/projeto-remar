<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'theme.label', default: 'theme')}" />
        
    </head>
    <body>

        <div class="page-header">
            <h1> Criar Tema</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${themeInstance}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${themeInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                    </g:eachError>
                            </ul>
                        </g:hasErrors>
                        <g:form url="[resource:themeInstance, action:'ImagesManager']"  enctype="multipart/form-data">
                            <!-- action mudado de "save" para "ImagesManager" -->
                            <fieldset class="form">
                                <g:render template="form"/>
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
