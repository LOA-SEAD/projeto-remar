<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 4/27/15
  Time: 11:08 PM
--%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Task ${taskId}</title>
</head>

<body>
    <g:link controller="process" action="complete" id="${taskId}">Next task</g:link>
</body>
</html>