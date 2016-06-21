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
<g:set var="i" value="${0}"/>
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
                            <a href="#!" class="breadcrumb">${communityName}</a>
                            <a href="." class="breadcrumb">${collectionsName}</a>
                            %{--<a href="#!" class="breadcrumb">Third</a>--}%
                        </div>
                    </aside>
                </div>
            </section>
            <section class="row">
                <div class="col s12" >
                    <ul class="collapsible" data-collapsible="accordion" >
                        <g:each in="${items}" var="obj">
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">filter_drama</i>
                                    ${obj.name}
                                </div>
                                <div class="collapsible-body">
                                    <p>Lorem ipsum dolor sit amet.</p>

                                    <table class="striped">
                                        <thead>
                                            <tr>
                                                <th data-field="id">Arquivo</th>
                                                <th data-field="name">Description</th>
                                                <th data-field="price">Format</th>
                                                <th data-field="price">Ação</th>
                                            </tr>
                                        </thead>
                                
                                        <tbody>
                                            <g:each in="${bitstreams.getAt(i)}" var="bitstream">
                                                <tr>
                                                    <td class="truncate">${bitstream.name}</td>
                                                    <td class="">${bitstream.description}</td>
                                                    <td class="">${bitstream.format}</td>
                                                    <td>
                                                        <a href="#!">
                                                            <i class="material-icons">visibility</i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </g:each>
                                            <g:set var="i" value="${i+1}"/>
                                        </tbody>
                                    </table>

                                </div>
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