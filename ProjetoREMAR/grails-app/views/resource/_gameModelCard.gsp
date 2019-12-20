<%@ page import="br.ufscar.sead.loa.remar.Rating" %>

<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
<link type="text/css" rel="stylesheet" href="${resource(dir: "css/jquery", file: "jquery.ratingField.css")}"/>

<main class="cardGames">
    <article class="row">
        <g:if test="${resourceInstanceList.size() > 0}">
            <g:each in="${resourceInstanceList}" var="resourceInstance">
                <div id="card${resourceInstance.id}" data-instance_id="${resourceInstance.id}" class="col l2 m4 s6 fullCard">
                    <div class="card hoverable">

                        <div class="card-image waves-effect waves-light">
                            <a href="/resource/show/${resourceInstance.id}">
                                <img alt="${resourceInstance.name}" src="/images/${resourceInstance.uri}-banner.png">
                            </a>
                        </div>

                        <div class="card-content">
                            <span class="card-title flow-text grey-text text-darken-4 valign-wrapper no-padding"
                                  data-category="${resourceInstance.category.id}" title="${resourceInstance.name}">
                                <p class="truncate no-margin">${resourceInstance.name}</p>
                            </span>

                            <div class="divider"></div>

                            <span>${resourceInstance.category.name}</span>
                            <span class="truncate">
                                Feito por:
                                <a href="#userDetailsModal" class="user-profile" id="user-id-${resourceInstance.owner.id}">
                                    ${resourceInstance.owner.username}
                                </a>
                            </span>
                            <span>
                                <g:if test="${resourceInstance.web}">
                                    <i class="fa fa-globe tooltipped" data-tooltip="Web"></i>
                                </g:if>
                                <g:if test="${resourceInstance.android}">
                                    <i class="fa fa-android tooltipped" data-tooltip="Android"></i>
                                </g:if>
                                <g:if test="${resourceInstance.desktop}">
                                    <i class="fa fa-windows tooltipped" data-tooltip="Windows"></i>
                                    <i class="fa fa-linux tooltipped" data-tooltip="Linux"></i>
                                    <i class="fa fa-apple tooltipped" data-tooltip="Mac"></i>
                                </g:if>
                                <g:if test="${resourceInstance.moodle}">
                                    <i class="fa fa-graduation-cap"></i>
                                </g:if>
                            </span>

                            <g:if test="${Rating.findByUserAndResource(session.user, resourceInstance)}">
                                <div class="row no-margin">
                                    <div class="col s12 no-padding rating-field-wrapper">
                                            <span>Sua avaliação:</span>
                                            <div class="rating-field"
                                                 data-user-id="${session.user.id}"
                                                 data-resource-id="${resourceInstance.id}"
                                                 data-user-rating="${Rating.findByUserAndResource(session.user, resourceInstance).stars / 10}"></div>
                                    </div>
                                </div>
                            </g:if>
                            <g:else>
                                <div class="row no-margin">
                                    <div class="col s12 no-padding rating-field-wrapper">
                                        <span>Sua avaliação:</span>

                                        <div class="rating-field"
                                             data-user-id="${session.user.id}"
                                             data-resource-id="${resourceInstance.id}"
                                             data-user-rating="0.0"></div>
                                    </div>
                                </div>
                            </g:else>


                        </div>
                    </div>
                </div>
            </g:each>
        </g:if>
    </article>

    <g:applyLayout name="pagination"/>
</main>

<g:javascript src="libs/jquery/jquery.ratingField.js"/>

<g:javascript>
    $(document).ready(function() {
        $('.rating-field').each(function() {
            $(this).ratingField('init');
        });
    });
</g:javascript>

