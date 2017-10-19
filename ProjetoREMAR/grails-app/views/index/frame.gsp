<%--
Created by IntelliJ IDEA.
User: loa
Date: 10/06/15
Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout-frame">
    <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
    <g:javascript src="libs/js/iframe-resizer.js"/>
    <g:javascript src="remar/frame.js"/>
    <title></title>
</head>

<body>
<div class="content">
    <div class="row show">
        <div class="col s12">
            <iframe id='frame' src="${uri}" frameBorder="0"></iframe>
        </div>
    </div>
</div>
</body>
</html>