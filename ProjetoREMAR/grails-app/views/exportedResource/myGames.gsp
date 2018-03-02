<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code="exportedResource.label.myGames" default="Meus Jogos" /></title>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="row cluster">
    <div class="cluster-header">
        <h4><g:message code="exportedResource.label.myGames" default="Meus Jogos" /></h4>
        <div class="divider"></div>
    </div>
    <div class="row">
        <div class="col s12">
            <ul class="tabs">
                    <li class="tab col s3"><a class="active" href="#test1"><g:message code="exportedResource.label.published" default="Publicados"/></a></li>
            </ul>
        </div>
        <section id="test1" class="col s12"> <!-- start my published games -->
            <div class="row search">
                <div class="input-field col s6">
                    <input id="search" type="text" placeholder="Buscar meus jogos"class="validate">
                    <label for="search"><i class="fa fa-search" data-tooltip="Buscar"></i></label>
                </div>
                <div class="input-field col s6">
                    <select class="material-select">
                        <option class="option" value="-1" selected><g:message code="exportedResource.label.all" default="Todas"/></option>
                        <g:if test="${categories.size() > 0}">
                            <g:each in="${categories}" var="category">
                                <option class="option" value="${category.id}">${category.name}</option>
                            </g:each>
                        </g:if>
                    </select>
                    <label><g:message code="exportedResource.label.category" default="Categoria"/></label>
                </div>
            </div>
            <div id="showCards" class="row">
                <article class="row">
                    <g:render template="customizedGameCard" model="[publicExportedResourcesList:myExportedResourcesList, page:'myGames']" />
                </article>
            </div>
        </section> <!-- finished my published games-->

        <section id="test2" class="col s12"> <!-- start processes-->
            <div class="row search">
                <div class="input-field col s12">
                    <input id="search-processes" type="text" class="validate">
                    <label for="search-processes">
                        <i class="fa fa-search" data-tooltip="Buscar"></i>
                    </label>
                </div>
            </div>
            <div id="showCardsProcess" class="row">
                <article class="row">
                    <g:render template="/process/process" model="[processes:processes]" />
                </article>
            </div>
        </section> <!-- finished processes-->
    </div>
</div>

<div id="userDetailsModal" class="modal remar-modal">
    %{-- Preenchido pelo Javascript --}%
</div>

<g:javascript src="remar/menu.js"/>
</body>
</html>
