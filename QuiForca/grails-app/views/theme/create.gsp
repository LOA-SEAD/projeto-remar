<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'theme.label', default: 'theme')}" />
        
    </head>
    <body>

    <nav class="layout-top-nav">
        <div class="nav-wrapper">
            <h3 style="margin: 10px;">Criar novo Tema</h3>
        </div>
    </nav>

    <div class="row">
    </div>

    %{--<div class="row">--}%
        %{--<h4 style="margin-left: 10px;">Criando meu próprio tema</h4>--}%
    %{--</div>--}%

    <div class="row">
        <div class="col s12">
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
                <div class="form">
                    <g:render template="form"/>
                </div>
            </g:form>
        </div>
    </div>



    %{--<div class="main-content">--}%
            %{--<div class="widget">--}%
                %{--<h3 class="section-title first-title"><i class="icon-table"></i> Criando meu próprio tema</h3>--}%
                %{--<div class="widget-content-white glossed">--}%
                    %{--<div class="padded">--}%
                        %{----}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    </body>
</html>
