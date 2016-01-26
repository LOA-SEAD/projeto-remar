<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}">
        <!-- Let browser know website is optimized for mobile -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#5D4037">
        <!-- Import Google Icon Font -->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Import materialize.css -->
        <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "materialize.css")}" media="screen,projection"/>
        <!-- Import custom styles -->
        <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "style.css")}"/>

        <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.slick/1.5.9/slick.css"/>

        <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.slick/1.5.9/slick-theme.css"/>

        <link rel="stylesheet" href="${resource(dir: 'css', file: 'introjs.min.css')}" />

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

        <style>
            .slick-prev:before,
            .slick-next:before {
                font-size: 20px;
                line-height: 1;
                opacity: .75;
                color: black;
            }
            .slick-slide img {
                display: inline-block;
            }
        </style>

        <!-- js -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'intro.js')}"></script>

        <g:javascript src="materialize.min.js"/>

        <title><g:layoutTitle default="REMAR"/></title>
        <g:layoutHead/>
    </head>
    <body>
        <g:layoutBody/>

        <script type="text/javascript" src="//cdn.jsdelivr.net/jquery.slick/1.5.9/slick.min.js"></script>

        <g:javascript src="layout/dashboard.js"/>


    </body>
</html>