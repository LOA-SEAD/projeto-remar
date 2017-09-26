<%@ page import="grails.util.Environment" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#5D4037">

        <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}">

        <link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/icon?family=Material+Icons"/>
        <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"/>
        <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/css/swiper.css"/>
        <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.slick/1.5.9/slick.css"/>
        <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.slick/1.5.9/slick-theme.css"/>

        <g:external dir="css/jquery" file="jquery.introjs.min.css" />
        <g:external dir="css/libs" file="materialize.css" />
        <g:external dir="css" file="style.css" />

        <g:javascript src="jquery/jquery-2.1.4.min.js" />
        <g:javascript src="libs/materialize.min.js" />
        <g:javascript src="libs/intro.js" />

        <title><g:layoutTitle default="REMAR"/></title>

        <g:layoutHead/>
    </head>

    <body>
        <g:layoutBody/>

        <script type="text/javascript">
            $(document).ready(function() {
                $(".button-collapse").sideNav();

                $('.dropdown-button').dropdown({
                    alignment: 'left'
                });

                $('.collapsible').collapsible();

                $('.tooltipped').tooltip({delay: 50});

                $('select').material_select();

            });

            function startWizard(){
                if(window.innerWidth > 992) { //desktop
                    introJs().start();
                }
            }
        </script>

        <g:if test="${Environment.current != Environment.DEVELOPMENT}">
            <script type="text/javascript">

                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

                ga('create', 'UA-47156714-2', 'auto');
                ga('send', 'pageview');
            </script>
        </g:if>
    </body>
</html>
