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
    <meta name="layout" content="dashboard">
</head>
<body>

%{--<div class="container">--}%
    <div class="row"> <!-- REA personalizaveis-->
        <div class="col s12 m12 l12 session-title" >
            <p class="session-title text-teal text-darken-3">
              <i class="left small material-icons">open_in_new</i>R.E.A. personalizáveis
                <span class="new badge orange" style="right: inherit; margin-left: 5px;"></span>
            </p>
            <a class="right btn-floating  waves-effect waves-light red"><i class="material-icons">add</i></a>
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
                                    <span class="btn-icon green accent-4 disabled" style="background-color: #00C853 !important;">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                </li>
                                <g:if test="${gameInstance.android}">
                                    <li>
                                        <span class="btn-icon deep-purple disabled"  style="background-color: #673ab7 !important;">
                                            <i class="fa fa-android"></i>
                                        </span>
                                    </li>
                                </g:if>
                                <g:if test="${gameInstance.linux}">
                                    <li>
                                        <span class="btn-icon red disabled" style="background-color: #F44336 !important;">
                                            <i class="fa fa-linux"></i>
                                        </span>
                                    </li>
                                </g:if>
                                <g:if test="${gameInstance.moodle}">
                                    <li>
                                        <span class="btn-icon amber darken-4 disabled" style="background-color: #ff6f00 !important;">
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
                <i class="left small material-icons">supervisor_account</i>R.E.A. públicos
                <span class="new badge orange" style="right: inherit; margin-left: 5px;"></span>
            </p>
            <a class="right btn-floating  waves-effect waves-light red"><i class="material-icons">add</i></a>
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
                                    <span  class="btn-floating green accent-4 disabled" style="background-color: #00C853 !important;">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                </li>
                            </g:if>
                            <g:if test="${exportedResourceInstance.androidUrl != null}">
                                <li>
                                    <span class="btn-floating deep-purple disabled"  style="background-color: #673ab7 !important;">
                                        <i class="fa fa-android"></i>
                                    </span>
                                </li>
                            </g:if>
                            <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                <li>
                                    <span class="btn-floating red disabled" style="background-color: #F44336 !important;">
                                        <i class="fa fa-linux"></i>
                                    </span>
                                </li>
                            </g:if>
                            <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                <li>
                                    <span class="btn-floating amber darken-4 disabled" style="background-color: #ff6f00 !important;">
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
                                <div class="card-action">
                                    <span class="btn-floating green accent-4 disabled" style="background-color: #00C853 !important;">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.webUrl}">
                                        <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </g:if>
                            <g:if test="${exportedResourceInstance.androidUrl != null}">
                                <div class="card-action">
                                    <span class="btn-floating deep-purple disabled"  style="background-color: #673ab7 !important;">
                                        <i class="fa fa-android"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.androidUrl}">
                                        <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </g:if>
                            <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                <div class="card-action">
                                    <span href="${exportedResourceInstance.linuxUrl}" class="btn-floating red disabled" style="background-color: #F44336 !important;">
                                        <i class="fa fa-linux"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.linuxUrl}" >
                                        <i class="fa fa-arrow-right"></i>
                                    </a>

                                </div>
                            </g:if>
                            <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                <div class="card-action">
                                    <span  class="btn-floating amber darken-4 disabled" style="background-color: #ff6f00 !important;">
                                        <i class="fa fa-graduation-cap"></i>
                                    </span>
                                    <a href="${exportedResourceInstance.moodleUrl}">
                                        <i class="fa fa-arrow-right"></i>
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
                <i class="left small material-icons">https</i>Meus R.E.A.
                <span class="new badge orange" style="right: inherit; margin-left: 5px;"></span>
            </p>
            <a class="right btn-floating  waves-effect waves-light red"><i class="material-icons">add</i></a>
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
                                         <a href="${myExportedResourceInstance.webUrl}" class="btn-floating green accent-4 disabled" style="background-color: #00C853 !important;">
                                             <i class="fa fa-globe"></i>
                                         </a>
                                     </li>
                                 </g:if>
                                 <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                     <li>
                                         <a href="${myExportedResourceInstance.androidUrl}" class="btn-floating deep-purple disabled"  style="background-color: #673ab7 !important;">
                                             <i class="fa fa-android"></i>
                                         </a>
                                     </li>
                                 </g:if>
                                 <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                     <li>
                                         <a href="${myExportedResourceInstance.linuxUrl}" class="btn-floating red disabled" style="background-color: #F44336 !important;">
                                             <i class="fa fa-linux"></i>
                                         </a>
                                     </li>
                                 </g:if>
                                 <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                     <li>
                                         <a href="${myExportedResourceInstance.moodleUrl}" class="btn-floating amber darken-4 disabled" style="background-color: #ff6f00 !important;">
                                             <i class="fa fa-graduation-cap"></i>
                                         </a>
                                     </li>
                                 </g:if>
                             </ul>
                             <div class="card-title center">
                                 <span class="truncate">${myExportedResourceInstance.name}</span>
                             </div>
                             <div class="card-reveal arrow card-title">
                                 <g:if test="${myExportedResourceInstance.webUrl != null}">
                                     <div class="card-action">
                                         <i class="fa fa-arrow-right right"></i>
                                     </div>
                                 </g:if>
                                 <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                     <div class="card-action">
                                         <i class="fa fa-arrow-right right"></i>
                                     </div>
                                 </g:if>
                                 <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                     <div class="card-action">
                                         <i class="fa fa-arrow-right right"></i>
                                     </div>
                                 </g:if>
                                 <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                     <div class="card-action">
                                         <i class="fa fa-arrow-right right"></i>
                                     </div>
                                 </g:if>
                                 <span class="card-title"><i class="fa fa-caret-down left"></i></span>
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
