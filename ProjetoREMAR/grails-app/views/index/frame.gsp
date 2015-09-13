<%--
Created by IntelliJ IDEA.
User: loa
Date: 10/06/15
Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
    <g:javascript src="frame.js"/>
    <g:if test="${development}">
        <script>window.development = true</script>
    </g:if>
    <title></title>
</head>
<body>


<div class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-body box-info">
                <iframe id='frame' src="${uri}" frameBorder="0" class="col-lg-12 col-md-12 col-sm-12"></iframe>
            </div>
        </div>
    </div>
</div>

</body>
</html>