<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 16/12/15
  Time: 12:32
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="materialize-layout">
</head>
<body>
    <div class="row">
    %{-- TODO mudar controlador --}%
        <g:form url="[action: 'update']" method="PUT" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${resourceInstance.id}" id="hidden">
            <div class="col-s12" >
                <g:render template="form"/>
            </div>
        </g:form>
    </div>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'game-index.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'edit.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
</body>
</html>