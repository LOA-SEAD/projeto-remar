<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 01/04/16
  Time: 10:08
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Estatísticas</title>
    <meta name="layout" content="materialize-layout">
</head>

<body>

<div class="row cluster">

    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">assessment</i>Estatísticas
        </p>
        <div class="divider"></div>
    </div>

    <div class="row show">
        <a href="#" class="swiper-button-prev" >‹</a>
        <div class="carousel-wrapper">
            <div class="swiper-container">
                <!-- Additional required wrapper -->
                <div class="swiper-wrapper" id="mainSwiper">
                    <!-- Slides -->
                    <g:each in="${moodleList}" var="moodleInstance">
                        <div class="swiper-slide card" data-hash="${moodleInstance.id}" style="width: 150px;">
                            <div class="card-content">
                                <img alt="${moodleInstance.name}" height="150" class="cover-image img-responsive image-bg no-margin-top"  src="/published/${moodleInstance.image}">
                                <div>
                                    <g:if test="${moodleInstance.name.length() <= 17}">
                                        <p>${moodleInstance.name}</p>
                                    </g:if>
                                    <g:else>
                                        <p class="truncate tooltipped" data-position="bottom" data-delay="35" data-tooltip="${moodleInstance.name}">${moodleInstance.name}</p>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
        <a href="#" class="jcarousel-control next swiper-button-next">›</a>

        <div class="clearfix"></div>

        <div class="row">
            <br />
            <h5>Dados</h5>

            <div class="game-stat">

            </div>
        </div>
    </div>

</div>

<g:javascript src="remar/game-info.js"/>

</body>
</html>