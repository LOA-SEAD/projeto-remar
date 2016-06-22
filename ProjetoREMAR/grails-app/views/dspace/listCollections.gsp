<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 21/06/16
  Time: 15:28
--%>

<%--
Created by IntelliJ IDEA.
User: lucasbocanegra
Date: 07/06/16
Time: 08:58
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Categorias</title>
</head>
<body>
<div class="row cluster">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">list</i>Repositório
        </p>
        <div class="divider"></div>
        <article class="width-position left-align">
            <section class="row">
                <div class="col s12">
                    <aside class="nav-breadcrumb">
                        <div class="nav-wrapper">
                            <a href="/dspace/index.gsp" class="first-breadcrumb">Comunidades</a>
                            <a href="javascript:location.reload()" class="breadcrumb">${communityName}</a>
                        </div>
                    </aside>
                </div>
            </section>
            <section class="row">
                <div class="col s12" >
                    <ul class="collection">
                        <g:each in="${collections}" var="obj">
                            <li class="collection-item avatar left-align">
                                <img src="${restUrl}${obj.retrieveLink}" alt="" class="circle">
                                <g:link controller="dspace" action="listItems/${obj.id}?names=${communityName}&names=${obj.name}"
                                        params="[lastURL:request.getRequestURL()]" data-id="${obj.id}"
                                        class="collection-link">${obj.name}</g:link>
                                %{--<a href="/dspace/listItems/${obj.id}?names=${communityName}&names=${obj.name}"--}%
                                   %{--class="collection-link" data-id="${obj.id}">${obj.name}</a>--}%
                                <p>${obj.shortDescription}</p>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </section>
        </article>
    </div>
</div>
</body>
</html>