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
                            <a href="/dspace/repository" class="first-breadcrumb">Comunidades</a>
                            <p class="breadcrumb active">${communityName}</p>
                        </div>
                    </aside>
                    <div class="card-content">
                        <blockquote>
                            Abaixo estão listados as coleções da comunidade ${communityName}.
                        </blockquote>
                    </div>
                </div>
            </section>
            <section class="row">
                <div class="col s12" >
                    <ul class="collection">
                        <g:each in="${collections}" var="collection">
                            <li class="collection-item avatar left-align">
                                <g:if test="${collection.retrieveLink != null}">
                                    <img src="${restUrl}${collection.retrieveLink}" alt="" class="circle">
                                </g:if>
                                <a href="/dspace/repository/${params.communityId}/${collection.id}" class="collection-link">
                                    ${collection.name}
                                </a>
                                <p>${collection.shortDescription}</p>
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