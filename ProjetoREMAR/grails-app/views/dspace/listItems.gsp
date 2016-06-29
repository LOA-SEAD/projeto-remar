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
                            <a href="${communityUrl}" class="breadcrumb">${communityName}</a>
                            <a href="javascript:location.reload()" class="breadcrumb active">${collectionName}</a>
                        </div>
                    </aside>
                    <div class="card-content text-justify">
                        <p>Abaixo estão listados os items, bem como os artefatos (resultados de customização), da coleção ${collectionName}.
                            Para baixar um artefato, clique em visualizar e posteriormente em abrir.
                        </p>
                    </div>
                </div>
            </section>
            <section class="row">
                <div class="col s12 m12 l12">
                    <ul class="collapsible" data-collapsible="accordion" >
                        <g:each in="${items}" var="obj">
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">expand_more</i>
                                    ${obj.name}
                                </div>
                                <div class="collapsible-body">
                                    <div class="row">
                                        <g:if test="${(metadata.getAt(i).find {it.key == 'dc.description' }) != null}">
                                            <div class="col s12">
                                                    <p><span class="bold">Descrição: </span>
                                                    ${(metadata.getAt(i).find {it.key == 'dc.description' }).value}
                                                </p>
                                            </div>
                                        </g:if>
                                        <div class="col s12 m6">
                                             <g:if test="${obj.lastModified != null}">
                                                <p>
                                                    <span class="bold">Ultima modificação: </span>
                                                    ${obj.lastModified}
                                                </p>
                                             </g:if>
                                             <g:if test="${(metadata.getAt(i).find {it.key == 'dcterms.license' }) != null}">
                                                <p>
                                                    <span class="bold">Licença: </span>
                                                    ${(metadata.getAt(i).find {it.key == 'dcterms.license' }).value}
                                                </p>
                                             </g:if>
                                        </div>
                                        <div class="col s12 m6">
                                            <g:if test="${(metadata.getAt(i).find {it.key == 'dc.contributor.author' }) != null}">
                                             <p><span class="bold">Autores: </span>
                                                ${(metadata.getAt(i).find {it.key == 'dc.contributor.author' }).value}
                                             </p>
                                            </g:if>
                                            <g:if test="${(metadata.getAt(i).find {it.key == 'dc.identifier.citation' }) != null}">
                                             <p><span class="bold">Citação: </span>
                                                 ${(metadata.getAt(i).find {it.key == 'dc.identifier.citation' }).value}
                                             </p>
                                            </g:if>
                                            <g:if test="${(metadata.getAt(i).find {it.key == 'dc.contributor.author' }) != null}">
                                              <p><span class="bold">Editor: </span>
                                                ${(metadata.getAt(i).find {it.key == 'dc.contributor.author' }).value}
                                              </p>
                                            </g:if>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col s12 m12 l12">
                                            <table class="highlight">
                                                <thead>
                                                <tr>
                                                    <th data-field="id">Arquivo</th>
                                                    %{--<th data-field="name">Description</th>--}%
                                                    <th data-field="price">Format</th>
                                                    <th data-field="price">Ação</th>
                                                </tr>
                                                </thead>

                                                <tbody>
                                                <g:each in="${bitstreams.getAt(i)}" var="bitstream">
                                                    <tr>
                                                        <td class="">${bitstream.name}</td>
                                                        %{--<td class="">${bitstream.description}</td>--}%
                                                        <td class="">${bitstream.format}</td>
                                                        <td>
                                                            <a href="#!" class="view tooltipped" data-bitstream-id="${bitstream.id}"
                                                               data-position="right" data-delay="50" data-tooltip="Visualizar">
                                                                <i class="material-icons">visibility</i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </g:each>
                                                <g:set var="i" value="${i+1}"/>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </section>
        </article>
    </div>
</div>

<!-- Modal Structure edit -->
<div id="modal" class="modal">
</div>

<g:javascript src="dspace.js"/>
</body>
</html>