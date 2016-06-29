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
            <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom title-page">
                <i class="medium material-icons left">cloud</i>Repositório
            </p>
            <div class="divider"></div>
            <article class="width-position left-align">
                <section class="row">
                    <div class="col s12">
                        <aside class="nav-breadcrumb">
                            <div class="nav-wrapper">
                                <a href="." class="first-breadcrumb active">Comunidades</a>
                            </div>
                        </aside>
                        <div class="card-content text-justify">
                            <p>Neste espaço estão disponíveis alguns artefatos customizados por nossos usuários e
                                usados na criação dos jogos. Tais artefatos encontram-se no Dspace
                                (<a href="${jspuiUrl}" target="_blank">${jspuiUrl}</a>).
                                Este espaço faz uma abstração dos artefatos lá encontrados. Eles estão divididos em
                                comunidades, nomeadas pelo nome de cada jogo, coleções e os items de cada coleção.
                                O usuário pode baixar o artefato por este espaço e usá-lo, por exemplo, para customizar
                                um jogo.
                            </p>
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