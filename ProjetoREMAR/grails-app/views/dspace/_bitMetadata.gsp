<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Adicionar metadados</title>
</head>
<body>
<article class="width-position left-align">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom title-page">
         Visualizar Submissão
        </p>
        <div class="divider"></div>
        <div class="clearfix"></div>
    </div>
    <section class="row">
        <div class="col s12">
            <div class="card-content text-justify">
                <p><span class="bold"><g:message code="dspace.metadata.author"/></span> ${author}</p>
                <p><span class="bold"><g:message code="dspace.metadata.editor"/></span> ${editor}</p>
                <p><span class="bold"><g:message code="dspace.metadata.title"/></span> ${title}</p>
                <p><span class="bold"><g:message code="dspace.metadata.abstract"/></span> ${abstractP}</p>
                <p><span class="bold"><g:message code="dspace.metadata.date_publication"/></span> ${date}</p>
                %{--<p><span class="bold"><g:message code="dspace.metadata.license"/></span> ${license}</p>--}%
                <input type="hidden" value="${license}" id="licenseValue">
                <div id="licenseInfo">

                </div>
                <p><span class="bold"></span></p>
            </div>
        </div>
        <div class="col s12">
            <table class="bordered">
                <thead>
                <tr>
                    <th data-field="answer">Arquivo</th>
                    <th data-field="name">Descrição</th>
                    <th data-field="action"> </th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${bitstreams}" var="bitstream">
                    <tr class="line">
                        <td>
                            ${bitstream.name}
                        </td>
                        <td>
                            <input id="description" type="text" class="validate">
                            <label for="description">First Name</label>
                        </td>
                        <td>
                            <div class="">
                                <span>ver</span>
                            </div>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </section>
</article>

<g:javascript src="licenseShow.js"/>
</body>
</html>

