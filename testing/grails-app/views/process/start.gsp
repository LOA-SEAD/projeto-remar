<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 4/27/15
  Time: 11:48 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Process ${processId} terminated</title>
</head>

<body>
    <g:link controller="process" action="start" params="[start: 'true']">Start process</g:link>

</body>
</html>