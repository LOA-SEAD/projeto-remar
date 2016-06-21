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
                     <h5>
                        Confira os modelos disponíveis para customização!
                     </h5>
                </p>
            </div>
            <div class="row">
                <div class="center">
                    <g:each in="${gameInstanceList}" var="gameInstance">
                        <div class="col l3 s6 offset-s3">
                            <div  style="position: relative; left: 1em;" class="card hoverable">
                                <a href="/resource/show/${gameInstance.id}">
                                    <div class="card-image waves-effect waves-block waves-light">
                                        <img  alt="${gameInstance.name}" class="activator" src="/images/${gameInstance.uri}-banner.png">
                                    </div>
                                </a>
                                <div class="card-content">
                                    <a href="/resource/show/${gameInstance.id}">
                                        <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate data-category="${gameInstance.category.id}" title="${gameInstance.name}">${gameInstance.name}</span>
                                    </a>
                                    <div class="divider"></div>
                                    <span style="color: dimgrey; font-size: 0.9em" class="center">${gameInstance.category.name}</span>
                                    <span style="color: dimgrey; font-size: 0.9em" class="center truncate">Feito por: ${gameInstance.owner.username}</span>
                                    <span style="color: dimgrey;" class="center">
                                        <i class="fa fa-globe"></i>
                                        <g:if test="${gameInstance.android}">
                                            <i class="fa fa-android"></i>
                                        </g:if>
                                        <g:if test="${gameInstance.desktop}">
                                            <i class="fa fa-windows"></i>
                                            <i class="fa fa-linux"></i>
                                            <i class="fa fa-apple"></i>
                                        </g:if>
                                        <g:if test="${gameInstance.moodle}">
                                            <i class="fa fa-graduation-cap"></i>
                                        </g:if>
                                    </span>
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
