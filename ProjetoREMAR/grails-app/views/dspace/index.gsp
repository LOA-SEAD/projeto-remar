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
                                <a href="." class="first-breadcrumb">Comunidades</a>
                                %{--<a href="#!" class="breadcrumb">Second</a>--}%
                                %{--<a href="#!" class="breadcrumb">Third</a>--}%
                            </div>
                        </aside>
                        <div class="card-content">
                            <p>I am a very simple card. I am good at containing small bits of information.
                            I am convenient because I require little markup to use effectively.</p>
                        </div>
                    </div>
                </section>
                <section class="row">
                    <div class="col s12" >
                        %{--<g:render template="list" model="[objects:subCommunities]" />--}%
                        <ul class="collection">
                            <g:each in="${subCommunities}" var="obj">
                                <li class="collection-item avatar left-align">
                                    <img src="${restUrl}${obj.retrieveLink}" alt="" class="circle">
                                    <a href="/dspace/listCollections/${obj.id}?names=${obj.name}" class="collection-link" data-id="${obj.id}">${obj.name}</a>
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