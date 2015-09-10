<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="REMAR/Escola Mágica"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">

        <link rel="stylesheet" href="${resource(dir: 'css', file: 'fullcalendar.css')}"	type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css/datatables', file: 'datatables.css')}"	type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css/datatables', file: 'bootstrap.datatables.css')}"	type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'scripts/scss', file: 'chosen.css')}"	type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'scripts/scss', file: 'font-awesome.css')}"	type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'app.css')}"	type="text/css">

        <link href='http://fonts.googleapis.com/css?family=Oswald:300,400,700|Open+Sans:400,700,300' rel='stylesheet' type='text/css'>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>

        <script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'tab.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'dropdown.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'collapse.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'transition.js')}"></script>
        <g:layoutHead/>
    </head>
    <body>
        <div class="all-wrapper">
            <div class="row">
                <div class="col-md-3" id="menu-latera">
                    <div class="text-center">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="side-bar-wrapper collapse navbar-collapse navbar-ex1-collapse">
                        <a href="#" class="logo hidden-sm hidden-xs">
                            <i class="icon-cog"></i>
                            <span>Sistema Administrativo<br />REMAR - Escola Mágica</span>
                        </a>
                        <div class="relative-w">
                            <ul class="side-menu">
                                <li><g:link controller="process" action="startProcess">Novo Jogo</g:link></li>
                                <li><a href="/logout">Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">

                    <div class="content-wrapper wood-wrapper">
                        <div class="content-inner">
                            <g:layoutBody/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
