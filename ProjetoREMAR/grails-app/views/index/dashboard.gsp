<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'user.label', default: 'User')}" />
    <title>Admin page</title>
</head>
<body>
<h1>DASHBOARD</h1>
<div class="page-header">
    <h1>Professor</h1>
</div>
<div class="main-content">
    <div class="widget">
        <h3 class="section-title first-title">
            <i class="icon-table"></i> Jogos personalizáveis
        </h3>
        <div class="widget-content-white glossed">
            <div class="padded">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered" id="table">
                        <tbody>
                        <tr>
                            <td align="center"><a href="/forca" target="_blank"><img
                                    src="${resource(dir:'images', file: 'forca.jpg')}"
                                    class="img img-responsive max onhove" /></a></td>
                            <td align="center"><a href="/mathjong" target="_blank"><img
                                    src="${resource(dir:'images', file: 'mathjong.png')}"
                                    class="img img-responsive max onhove" /></a></td>
                            <td align="center"><a href="/escolamagica" target="_blank"><img
                                    src="${resource(dir:'escolamagica', file: 'escolamagica.png')}"
                                    class="img img-responsive max onhove" /></a></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>