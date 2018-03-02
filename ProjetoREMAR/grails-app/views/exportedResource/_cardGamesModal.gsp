<%@ page import="br.ufscar.sead.loa.remar.GroupExportedResources" %>

<h4 data-instance_id="${instance.name}"><g:message code="exportedResource.label.shareWithGroups" default="Compartilhar para grupos"/> - ${instance.name}</h4>

<div class="shareBlock">
    <ul class="no-margin">
        <g:if test="${!myGroups.empty}">
            <g:each var="group" in="${myGroups}">
                <li class="row">
                    <div class="col s10 shareDesc">
                        <p><strong><g:message code="exportedResource.label.groupName" default="Nome do grupo:"/></strong>
                            ${group.name}</p>
                        <p>
                            <strong><g:message code="exportedResource.label.owner" default="Dono:"/>:</strong> ${group.owner.firstName + " " + group.owner.lastName}<br>
                        </p>
                    </div>
                    <div class="col s2 shareCheck">
                        <p>
                            <g:if test="${!GroupExportedResources.findByGroupAndExportedResource(group,instance)}">
                                <input type="checkbox" class="filled-in" typeGroup="myGroup" data-group_id="${group.id}" data-instance_id="${instance.id}" id="groups-${group.id}-instance-${instance.id}"/>
                            </g:if>
                            <g:else>
                                <input type="checkbox" class="filled-in" typeGroup="myGroup" data-group_id="${group.id}" data-instance_id="${instance.id}" id="groups-${group.id}-instance-${instance.id}" checked="checked"/>
                            </g:else>
                            <label for="groups-${group.id}-instance-${instance.id}"></label>
                        </p>
                    </div>
                </li>
            </g:each>
        </g:if>
        <g:if test="${!groupsIAdmin.empty}">
            <g:each var="group" in="${groupsIAdmin}">
                <li class="row">
                    <div class="col s10 shareDesc">
                        <p><strong>Nome do grupo:</strong>
                            ${group.name}</p>
                        <p>
                            <strong>Dono:</strong> ${group.owner.firstName + " " + group.owner.lastName}<br>
                        </p>
                    </div>
                    <div class="col s2 shareCheck">
                        <p>
                            <g:if test="${!GroupExportedResources.findByGroupAndExportedResource(group,instance)}">
                                <input type="checkbox" class="filled-in" typeGroup="adminGroup" data-group_id="${group.id}" data-instance_id="${instance.id}" id="groups-${group.id}-instance-${instance.id}"/>
                            </g:if>
                            <g:else>
                                <input type="checkbox" class="filled-in" typeGroup="adminGroup" data-group_id="${group.id}" data-instance_id="${instance.id}" id="groups-${group.id}-instance-${instance.id}" checked="checked"/>
                            </g:else>
                            <label for="groups-${group.id}-instance-${instance.id}"></label>
                        </p>
                    </div>
                </li>
            </g:each>
        </g:if>
        <g:if test="${groupsIAdmin.empty && myGroups.empty}">
            <li class="collection-header"><h5>Você não possui grupos disponíveis</h5></li>
        </g:if>
    </ul>
</div>

<g:javascript src="remar/group/add-resource-to-group.js" />
<g:external dir="css" file="card.css" />
