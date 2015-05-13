
<%@ page import="br.ufscar.sead.loa.remar.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title>Admin page</title>
	</head>
	<body>
		<div class="page-header">
            <h1>Professor</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Jogos personalizáveis</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                    	<li><h3><a href="/forca">Forca</a></h3></li>
						<li><h3><a href="/escolamagica">Escola Mágica</a></h3></li>
						<li><h3><a href="/mathjong">MathJong</a></h3></li>
                    </div>
                </div>
            </div>
        </div>

		
	</body>
</html>
