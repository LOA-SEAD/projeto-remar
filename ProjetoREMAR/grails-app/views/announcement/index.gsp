<%@ page import="br.ufscar.sead.loa.remar.Announcement" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
        <g:set var="entityName" value="${message(code: 'announcement.label', default: 'Announcement')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-announcement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-announcement" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
            <thead>
                    <tr>

                        <g:sortableColumn property="title" title="${message(code: 'announcement.title.label', default: 'Title')}" />

                        <g:sortableColumn property="type" title="${message(code: 'announcement.type.label', default: 'Type')}" />

                        <th><g:message code="announcement.author.label" default="Author" /></th>

                        <g:sortableColumn property="body" title="${message(code: 'announcement.body.label', default: 'Body')}" />

                    </tr>
                </thead>
                <tbody>
                <g:each in="${announcementList}" status="i" var="announcement">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show" id="${announcement.id}">${fieldValue(bean: announcement, field: "title")}</g:link></td>

                        <td>${fieldValue(bean: announcement, field: "type")}</td>

                        <td>${fieldValue(bean: announcement, field: "author")}</td>

                        <td>${fieldValue(bean: announcement, field: "body")}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${announcementCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
