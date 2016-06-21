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
            <article class="">
                <ul class="collection">
                    <g:each in="${subCommunities}" var="community">
                        <li class="collection-item avatar">
                            <img src="images/yuna.jpg" alt="" class="circle">
                            <span class="title">${community.name}</span>
                            <p>${community.shortDescription}</p>
                        </li>
                    </g:each>
                </ul>
            </article>
        </div>
    </div>
</body>
</html>