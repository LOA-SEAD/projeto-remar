<%@ page import="br.ufscar.sead.loa.remar.Group; br.ufscar.sead.loa.remar.UserGroup" contentType="text/html;charset=UTF-8" %>
<li id="user-group-card-${userGroup.id}" class="collection-item avatar left-align">
    <img alt src="/data/users/${userGroup.user.username}/profile-picture" class="circle">
    <span class="title">${userGroup.user.firstName + " " + userGroup.user.lastName}</span>
    <span class="admin-text" id="admin-${userGroup.id}-text"> <g:if test="${userGroup.admin}">(Administrador)</g:if></span>
        <p class=""><g:message code="group.label.user" default="Usuário"/>: ${userGroup.user.username}</p>
    <g:if test="${userGroup.group.owner.id == session.user.id}">
        <a href="#" id="${userGroup.id}" style="position: relative; top: -2.5em; left: -1.6em;" class="secondary-content delete-modal"><i class="material-icons">delete</i></a>
        <g:if test="${!userGroup.admin}">
            <a id="make-admin-${userGroup.id}"  data-user-group-id="${userGroup.id}" href="#" data-position="left" data-tooltip="Tornar admin" class="secondary-content manage-user tooltipped"><i id="admin-${userGroup.id}" class="material-icons">star_border</i></a>
        </g:if>
        <g:else>
            <a id="remove-admin-${userGroup.id}" data-user-group-id="${userGroup.id}" href="#" class="secondary-content manage-user tooltipped"><i id="admin-star-${userGroup.id}" class="material-icons">star</i></a>
        </g:else>
    </g:if>
</li>
