<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:javascript src="../assets/js/jquery.min.js"/>
    <g:set var="entityName" value="${message(code: 'theme.label', default: 'theme')}" />
    <g:external dir="css" file="themes.css"/>
</head>
<body>

<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
    </p>
</div>

<div class="row">
</div>


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


</body>
</html>
