<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'icon	.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<r:require modules="bootstrap"></r:require>
		<g:layoutHead/>
	</head>
	<body>
		<div class="content">
			<nav class="navbar navbar-default">
			       <div class="container-fluid">
			         <div class="navbar-header">
			           <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			             <span class="sr-only">Toggle navigation</span>
			             <span class="icon-bar"></span>
			             <span class="icon-bar"></span>
			             <span class="icon-bar"></span>
			           </button>
			           <a class="navbar-brand" href="#">REMAR</a>
			         </div>
			         <div id="navbar" class="navbar-collapse collapse">
			           <ul class="nav navbar-nav">
			             <li><a href="#">Home</a></li>
			           </ul>
			           <ul class="nav navbar-nav navbar-right">
			           	 <li class="dropdown">
			               	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Vincius Nordi Esperança <span class="caret"></span></a>
			               	<ul class="dropdown-menu" role="menu">
			                 	<li><a href="#">Meus dados</a></li>
			                 	<li><a href="/logout">Sair</a></li>
			               	</ul>
			             </li>
			           </ul>
			         </div><!--/.nav-collapse -->
			       </div><!--/.container-fluid -->
			     </nav>
			<!-- <div align="center" id="grailsLogo" role="banner"><a target="_blank" href="http://www.loa.sead.ufscar.br/"><asset:image src="loa_banner.jpg" alt="REMAR" class="img-responsive"/></a></div> -->
			<g:layoutBody/>
			<div class="footer" role="contentinfo"></div>
			<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		</div>
	</body>
</html>
