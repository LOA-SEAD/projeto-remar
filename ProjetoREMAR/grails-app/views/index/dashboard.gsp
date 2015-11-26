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
</head>
<body>

%{--<div class="container">--}%
    <div class="row"> <!-- REA personalizaveis-->
        <div class="col s12 m12 l12 session-title" >
            <p class="session-title text-teal text-darken-3">
              <i class="left small material-icons">open_in_new</i>R.E.A.s personalizáveis

            </p>

            <div class="divider"></div>
        </div>

        <g:if test="${gameInstanceList.size() == 0}">
            <p>Não há nenhum R.E.A disponível para ser personalizado :(</p>
        </g:if>
        <g:each in="${gameInstanceList}" var="gameInstance">
            <div class="col l2 m3 s12">
                <div class="card-resource">
                    <a href="/resource/show/${gameInstance.id}" >
                        <div class="card hoverable">
                            <div class="card-content-bg">
                                <div class="card-image">
                                    <img class="activator" src="/images/${gameInstance.uri}-banner.png">
                                </div>
                            </div>
                            <ul class="card-image card-action-buttons">
                                <li>
                                    <span class="btn-icon disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                </li>
                                <g:if test="${gameInstance.android}">
                                    <li>
                                        <span class="btn-icon disabled"  style="background-color: #FF5722 !important;">
                                            <i class="fa fa-android"></i>
                                        </span>
                                    </li>
                                </g:if>
                                <g:if test="${gameInstance.linux}">
                                    <li>
                                        <span class="btn-icon disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-linux"></i>
                                        </span>
                                    </li>
                                </g:if>
                                <g:if test="${gameInstance.moodle}">
                                    <li>
                                        <span class="btn-icon disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-graduation-cap"></i>
                                        </span>
                                    </li>
                                </g:if>
                            </ul>

                            <div class="card-title center">
                                <span class="truncate">${gameInstance.name}</span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </g:each>
        %{--<div class="developer">--}%
            %{--<img src="../data/users/${gameInstance.owner.username}/profile-picture"--}%
                 %{--class="circle left">--}%
            %{--<span class="truncate">${gameInstance.owner.firstName}</span>--}%
        %{--</div>--}%
    </div> <!-- End Row R.E.A Personalizaveis -->

    <div class="row"> <!-- R.E.A. publicos -->
        <div class="col s12 m12 l12 session-title" >
            <p class="session-title text-teal text-darken-3">
                <i class="left small material-icons">supervisor_account</i>R.E.A.s públicos

            </p>

            <div class="divider"></div>
        </div>
        <g:if test="${publicExportedResourcesList.size() == 0}">
            <p>Não há nenhum R.E.A público :(</p>
        </g:if>
        <g:each in="${publicExportedResourcesList}" var="exportedResourceInstance">
            <div class="col l2 m4 s12">
                <div class="card-resource ">
                    <div class="card hoverable">
                        <div class="card-content-bg">
                            <div class="card-image">
                                <img class="activator" src="/images/${exportedResourceInstance.resource.uri}-banner.png">
                            </div>
                        </div>
                        <ul class="card-image card-action-buttons">
                            <g:if test="${exportedResourceInstance.webUrl != null}">
                                <li>
                                    <span  class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                </li>
                            </g:if>
                            <g:if test="${exportedResourceInstance.androidUrl != null}">
                                <li>
                                    <span class="btn-floating disabled"  style="background-color: #FF5722 !important;">
                                        <i class="fa fa-android"></i>
                                    </span>
                                </li>
                            </g:if>
                            <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                <li>
                                    <span class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-linux"></i>
                                    </span>
                                </li>
                            </g:if>
                            <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                <li>
                                    <span class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-graduation-cap"></i>
                                    </span>
                                </li>
                            </g:if>
                        </ul>
                        <div class="card-title center">
                            <span class="truncate">${exportedResourceInstance.name}</span>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title"><i class="material-icons right">close</i></span>
                            <span class="card-title truncate" style="margin-bottom: 10px;">${exportedResourceInstance.name}</span>

                            <g:if test="${exportedResourceInstance.webUrl != null}">
                                <div class="card-action no-padding padding-bottom">
                                    <span class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.webUrl}" style="color: #FF5722;">WEB <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </g:if>
                            <g:if test="${exportedResourceInstance.androidUrl != null}">
                                <div class="card-action no-padding padding-bottom">
                                    <span class="btn-floating disabled"  style="background-color: #FF5722 !important;">
                                        <i class="fa fa-android"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.androidUrl}" style="color: #FF5722;">ANDROID <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </g:if>
                            <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                <div class="card-action no-padding padding-bottom">
                                    <span href="${exportedResourceInstance.linuxUrl}" class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-linux"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.linuxUrl}" style="color: #FF5722;">LINUX <i class="fa fa-arrow-right"></i>
                                    </a>

                                </div>
                            </g:if>
                            <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                <div class="card-action no-padding">
                                    <span  class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                        <i class="fa fa-graduation-cap"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.moodleUrl}" style="color: #FF5722;">MOODLE <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </g:if>
                        </div> <!-- End card-reveal -->
                    </div>
                </div>
            </div>
        </g:each>
    </div> <!-- End Row -->

    <div class="row"> <!-- Meus R.E.A.  -->
        <div class="col s12 m12 l12 session-title" >
            <p class="session-title text-teal text-darken-3">
                <i class="left small material-icons">https</i>Meus R.E.A.s
            </p>

            <div class="divider"></div>
        </div>

        <g:if test="${myExportedResourcesList.size() == 0}">
            <p>Você ainda não tem nenhum R.E.A. publicado :(</p>
        </g:if>
        <g:else>
            <g:each in="${myExportedResourcesList}" var="myExportedResourceInstance">
                <div class="col l2 m4 s12">
                    <div class="card-resource ">
                        <div class="card hoverable">
                            <div class="card-content-bg">
                                <div class="card-image">
                                    <img class="activator" src="/images/${myExportedResourceInstance.resource.uri}-banner.png">
                                </div>
                            </div>
                            <ul class="card-image card-action-buttons">
                                <g:if test="${myExportedResourceInstance.webUrl != null}">
                                    <li>
                                        <a href="${myExportedResourceInstance.webUrl}" class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-globe"></i>
                                        </a>
                                    </li>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                    <li>
                                        <a href="${myExportedResourceInstance.androidUrl}" class="btn-floating disabled"  style="background-color: #FF5722 !important;">
                                            <i class="fa fa-android"></i>
                                        </a>
                                    </li>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                    <li>
                                        <a href="${myExportedResourceInstance.linuxUrl}" class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-linux"></i>
                                        </a>
                                    </li>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                    <li>
                                        <a href="${myExportedResourceInstance.moodleUrl}" class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-graduation-cap"></i>
                                        </a>
                                    </li>
                                </g:if>
                            </ul>
                            <div class="card-title center">
                                <span class="truncate">${myExportedResourceInstance.name}</span>
                            </div>
                            <div class="card-reveal">
                                <span class="card-title"><i class="material-icons right">close</i></span>
                                <span class="card-title truncate" style="margin-bottom: 10px;">${myExportedResourceInstance.name}</span>

                                <g:if test="${myExportedResourceInstance.webUrl != null}">
                                    <div class="card-action no-padding padding-bottom">
                                        <span class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-globe"></i>
                                        </span>
                                        <a href="${myExportedResourceInstance.webUrl}" style="color: #FF5722;">WEB <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                    <div class="card-action no-padding padding-bottom">
                                        <span class="btn-floating disabled"  style="background-color: #FF5722 !important;">
                                            <i class="fa fa-android"></i>
                                        </span>
                                        <a href="${myExportedResourceInstance.androidUrl}" style="color: #FF5722;">ANDROID <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                    <div class="card-action no-padding padding-bottom">
                                        <span href="${myExportedResourceInstance.linuxUrl}" class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-linux"></i>
                                        </span>
                                        <a href="${myExportedResourceInstance.linuxUrl}" style="color: #FF5722;">LINUX <i class="fa fa-arrow-right"></i>
                                        </a>

                                    </div>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                    <div class="card-action no-padding">
                                        <span  class="btn-floating disabled" style="background-color: #FF5722 !important;">
                                            <i class="fa fa-graduation-cap"></i>
                                        </span>
                                        <a href="${myExportedResourceInstance.moodleUrl}" style="color: #FF5722;">MOODLE <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </g:if>
                                <a href="#">Remover</a>
                            </div> <!-- End card-reveal -->
                        </div>
                    </div>
                </div>
            </g:each>
        </g:else>
    </div> <!-- End Row -->


%{--</div> <!-- End Container -->--}%


</body>
</html>
