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
                    <g:each in="${attrNames}" status="i" var="name">
                        <p>${name}: ${request.getAttribute(name)}</p>
                    </g:each>
                </ul>
            </div>
            </br></br>
        </div>
    </div>
<g:javascript src="static/home.js"/>
</body>