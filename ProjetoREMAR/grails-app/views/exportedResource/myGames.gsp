<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 21/01/16
  Time: 13:57
  Desc: Tela que lista os jogos do usuário
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Meus jogos</title>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="row cluster">

    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">recent_actors</i>Meus jogos
        </p>
        <div class="divider"></div>
    </div>
    <div class="row">
        <div class="col s12">
            <ul class="tabs">
                <li class="tab col s3"><a class="active" href="#test2">Em customização</a></li>
                <li class="tab col s3"><a href="#test1">Publicados</a></li>
            </ul>
        </div>
        <section id="test1" class="col s12">
            <div class="row search">
                <div class="input-field col s6">
                    <input id="search" type="text" class="validate">
                    <label for="search"><i class="fa fa-search"></i></label>
                </div>
                <div class="input-field col s6">
                    <select>
                        <option class="option" value="-1" selected>Todas</option>
                        <g:if test="${categories.size() > 0}">
                            <g:each in="${categories}" var="category">
                                <option class="option" value="${category.id}">${category.name}</option>
                            </g:each>
                        </g:if>
                    </select>
                    <label>Categoria</label>
                </div>
            </div>
            <g:render template="myCardGame" model="[myExportedResourcesList:myExportedResourcesList]" />

        </section>
        <section id="test2" class="col s12">
            <div class="row search">
                <div class="input-field col s6">
                    <input id="search-processes" type="text" class="validate">
                    <label for="search"><i class="fa fa-search"></i></label>
                </div>
                <div class="input-field col s6">
                    <select>
                        <option class="option" value="-1" selected>Todas</option>
                        <g:if test="${categories.size() > 0}">
                            <g:each in="${categories}" var="category">
                                <option class="option" value="${category.id}">${category.name}</option>
                            </g:each>
                        </g:if>
                    </select>
                    <label>Categoria</label>
                </div>
            </div>
            <div class="row show cards">
                <article class="row">
                    <g:render template="/process/process" model="[processes:processes]" />
                </article>
            </div>
        </section>
    </div>
</div>
<g:javascript src="menu.js"/>
%{--<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "tabs.css")}"/>--}%
%{--<g:javascript src="prefixfree.min.js"/>--}%

</body>
</html>