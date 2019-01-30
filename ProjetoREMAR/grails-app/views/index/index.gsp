<%@ page import="br.ufscar.sead.loa.remar.Announcement" %>
<head>
    <meta name="layout" content="materialize-layout-index">
</head>

<body>
    <div class="row" style="padding: 20px;">
        <div class="col-lg-12">
            <div class="slider">
                <ul class="slides" id="static-slider">
                    <li>
                        <img src="images/slider/slider1.png">
                        <div class="caption center-align">
                        </div>
                    </li>
                    <g:each in="${announcementList}" status="i" var="announcementInstance">
                        <g:render template="announcement" model= "['announcement': announcementInstance, 'i': i+2]"/>
                    </g:each>
                </ul>
            </div>
            </br></br>
        </div>
    </div>
<g:javascript src="static/home.js"/>
</body>