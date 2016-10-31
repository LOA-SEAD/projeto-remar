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

<%@ page import="java.text.SimpleDateFormat" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Repositório</title>
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
                            <a href="/dspace/repository/${params.communityId}" class="breadcrumb">${communityName}</a>
                            <p class="breadcrumb active">${collectionName}</p>
                        </div>
                    </aside>
                    <div class="card-content text-justify">
                        <blockquote>Abaixo estão listados os items, bem como os artefatos (resultados de customização), da coleção ${collectionName}.
                            Para baixar um artefato, clique em visualizar e posteriormente em abrir.
                        </blockquote>
                    </div>
                </div>
            </section>
            <section class="row">
                <div class="col s12 m12 l12">
                    <ul class="collapsible" data-collapsible="accordion" >
                        <g:each in="${items}" var="item" status="i">
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">expand_more</i>
                                    <span style="font-weight: bold;">${item.name}</span>
                                    <span class="right complement hide-on-med-and-down">
                                        ${(metadata.getAt(i).find {it.key == 'dc.date.issued' }).value}
                                        |
                                        <g:each var="author"  status="j" in="${metadata.getAt(i).findAll({it.key == 'dc.contributor.author'})}">
                                            ${author.value};
                                        </g:each>
                                    </span>
                                </div>
                                <div class="collapsible-body">
                                    <div class="row">
                                        <g:if test="${(metadata.getAt(i).find {it.key == 'dc.description.abstract' }) != null}">
                                            <div class="col s12 m12 l12">
                                                    <g:link class="btn my-orange tooltipped right" action="exportZipFiles" params="[itemId: item.id]"
                                                            data-position="bottom" data-delay="50" data-tooltip="Baixar arquivos como zip">
                                                        <i class="fa fa-file-archive-o" aria-hidden="true"></i> Baixar
                                                    </g:link>
                                                    <p><span class="bold">Descrição: </span>
                                                    ${(metadata.getAt(i).find {it.key == 'dc.description.abstract' }).value}
                                                </p>
                                            </div>
                                        </g:if>
                                        <div class="col s12 m12">
                                            <g:if test="${(metadata.getAt(i).findAll {it.key == 'dc.contributor.author' }) != null}">
                                                <p>
                                                    <span class="bold">Autores: </span>
                                                    <g:each var="author"  status="j" in="${metadata.getAt(i).findAll({it.key == 'dc.contributor.author'})}">
                                                        ${author.value};
                                                    </g:each>
                                                </p>
                                            </g:if>
                                             <g:if test="${item.lastModified != null}">
                                                <p>
                                                    <span class="bold">Ultima modificação: </span>
                                                    ${(metadata.getAt(i).find {it.key == 'dc.date.issued' }).value}

                                                </p>
                                             </g:if>
                                            <p>
                                                <span class="bold">Link para o Dspace : </span>
                                                <a target="_blank" href="${linkArray.getAt(i)}">${linkArray.getAt(i)}</a>
                                            </p>
                                             <g:if test="${(metadata.getAt(i).find {it.key == 'dcterms.license' }) != null}">
                                                 <div class="div-license center">
                                                 <g:if test="${(metadata.getAt(i).find {it.key == 'dcterms.license' }) == "cc-by-sa"}">
                                                     <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>
                                                         <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/88x31.png' />
                                                     </a>
                                                     <br>
                                                     <span class="hide-on-med-and-down text-center">
                                                         Esta obra está licenciado com uma Licença
                                                         <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional</a>
                                                         .
                                                     </span>

                                                 </g:if>
                                                 <g:else>
                                                     <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>
                                                         <img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png' />
                                                     </a>
                                                     <br>
                                                     <span class="hide-on-med-and-down center">
                                                         Esta obra está licenciado com uma Licença
                                                         <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/4.0/'>Creative Commons Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>
                                                         .
                                                     </span>
                                                 </g:else>
                                                 </div>
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
                                                            <a href="#!" data-dspace-link="${(metadata.getAt(i).find {it.key == 'dc.identifier.uri' }).value}" class="view " data-bitstream-id="${bitstream.id}">
                                                                Visualizar
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </g:each>
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

<g:javascript src="dspace/dspace.js"/>
</body>
</html>