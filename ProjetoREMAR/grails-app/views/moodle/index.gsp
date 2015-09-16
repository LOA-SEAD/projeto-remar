<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 9/15/15
  Time: 5:06 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<form action="/moodle/link">
    Moodle: <g:select name="domain" from="${moodleInstanceList}" optionValue="name" optionKey="domain" /><br>
    Usuário: <input type="text" name="username"><br>
    <input type="submit" value="Enviar">
</form>
</body>
</html>