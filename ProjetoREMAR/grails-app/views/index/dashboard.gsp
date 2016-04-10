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
    <meta name="layout" content="materialize-layout">
    <g:javascript src="materialize.min.js"/>

</head>
<body>
<div class="row cluster">
    <div class="row show">
            <div class="subtitle">
                <p class="text-teal text-darken-3 left-align margin-bottom">
                     <blockquote>
                        <i class="material-icons left">create</i> Confira os modelos disponíveis para customização!
                     </blockquote>
                </p>
            </div>
            <div class="row">
                <div class="center slick">
                    <g:each in="${gameInstanceList}" var="gameInstance">
                        <div class="card square-cover small dashboard">
                            <div class="card-content">
                                <div class="cover">
                                    <div class="cover-image-container">
                                        <div class="cover-outer-align">
                                            <div class="cover-inner-align">
                                                <img alt="${gameInstance.name}" class="cover-image img-responsive image-bg "  src="/images/${gameInstance.uri}-banner.png">
                                            </div>
                                        </div>
                                    </div>
                                    <a class="card-click-target"  href="/resource/show/${gameInstance.id}"></a>
                                </div>
                                <div class="details">
                                    <a class="card-click-target"  href="/resource/show/${gameInstance.id}" aria-hidden="true" tabindex="-1"></a>
                                    <a class="title card-name" data-category="${gameInstance.category.id}" href="/resource/show/${gameInstance.id}" title="${gameInstance.name}" aria-hidden="true" tabindex="-1">${gameInstance.name}</a>
                                    <div class="subtitle-container">
                                        <p class="subtitle">Feito por: ${gameInstance.owner.firstName}</p>
                                    </div>
                                    <div class="gray-color subtitle-container">
                                        <i class="fa fa-globe"></i>
                                        <g:if test="${gameInstance.android}">
                                            <i class="fa fa-android"></i>
                                        </g:if>
                                        <g:if test="${gameInstance.desktop}">
                                            <i class="fa fa-desktop"></i>
                                        </g:if>
                                        <g:if test="${gameInstance.moodle}">
                                            <i class="fa fa-graduation-cap"></i>
                                        </g:if>
                                    </div>
                                </div>
                                <div class="row no-margin margin-top ">
                                    <div class="col s12 no-padding">
                                        <div class="left">
                                            <g:if test="${gameInstance.sumUser == 0}">
                                                <div class="rating-dashboard"
                                                     data-stars="0"></div>
                                            </g:if>
                                            <g:else>
                                                <div class="rating-dashboard"
                                                     data-stars="${gameInstance.sumStars / gameInstance.sumUser}"></div>
                                            </g:else>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
    </div>
</div>
<g:javascript src="layout/dashboard.js"/>
</body>
</html>
