<%@ page import="grails.util.Environment" %>
<%@ page import="br.ufscar.sead.loa.remar.Report" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#5D4037">

        <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}">

        <g:external dir="css/jquery" file="jquery.introjs.min.css" />
        <g:external dir="css/libs" file="swiper.css" />
        <g:external dir="css/libs" file="slick.css" />
        <g:external dir="css/libs" file="slick-theme.css" />
        <g:external dir="css/libs" file="materialize.min.css" />
        <g:external dir="css/libs" file="font-awesome.min.css" />
        <g:external dir="css/libs" file="materialize-material-icons.css" />
        <g:external dir="css" file="materialize-tweaks.css"/>
        <g:external dir="css" file="style.css" />

        <g:javascript src="libs/jquery/jquery-2.1.4.min.js" />
        <g:javascript src="libs/js/html2canvas.min.js" />
        <g:javascript src="libs/js/materialize.min.js" />
        <g:javascript src="libs/js/intro.js" />
        <g:javascript src="libs/jquery/jquery.finiteStateMachine.js" />
        <g:javascript src="remar/layouts/base.js" />

        <title><g:layoutTitle default="REMAR"/></title>

        <g:layoutHead/>
    </head>

    <body id="html2canvas-target">
        <g:layoutBody/>

        %{-- Trigger is in menu.gsp --}%
        <div data-html2canvas-ignore="true" class="modal-wrapper-50">
            <div id="report-modal" class="modal remar-modal">
                <div class="modal-content">
                    <h4><g:message code="report.modal.title"/></h4>

                    <g:form url="[controller: 'report', action: 'save']">
                        <g:render template="/report/form"/>
                    </g:form>
                </div>

                <div class="modal-footer">
                    <a id="report-fsm-finish" href="#!"
                       class="report-fsm-next btn waves-effect waves-light remar-orange hidden">
                        <g:message code="default.button.submit.label"/>
                    </a>
                    <a id="report-fsm-next" href="#!"
                       class="report-fsm-next btn waves-effect waves-light remar-orange hidden">
                        <g:message code="default.button.next.label"/>
                    </a>
                    <a id="report-fsm-prev" href="#!"
                       class="btn waves-effect waves-light remar-orange hidden">
                        <g:message code="default.button.previous.label"/>
                    </a>
                    <a id="report-fsm-cancel" href="#!"
                       class="modal-action modal-close btn waves-effect waves-light remar-orange">
                        <g:message code="default.button.cancel.label"/>
                    </a>
                </div>
            </div>
        </div>

        <g:if test="${Environment.current != Environment.DEVELOPMENT}">
            <g:javascript>
                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

                ga('create', 'UA-47156714-2', 'auto');
                ga('send', 'pageview');
            </g:javascript>
        </g:if>
    </body>
</html>
