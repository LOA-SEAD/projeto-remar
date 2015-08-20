<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 19/08/15
  Time: 09:44
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-beta">

    <title></title>
</head>

<body>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<g:form>
    <fieldset class="form">
        <g:render template="formDeveloper"/>
    </fieldset>
    <fieldset class="buttons">
        <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </fieldset>
</g:form>
    </div>
</body>
</html>