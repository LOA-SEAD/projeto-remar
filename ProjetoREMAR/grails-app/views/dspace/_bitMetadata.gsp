<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="materialize-layout">
    <title>Adicionar metadados</title>
</head>
<body>
<article class="width-position left-align">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom title-page">
            <i class="medium material-icons left">cloud_upload</i>Submeter artefatos
        </p>
        <div class="divider"></div>
        <div class="clearfix"></div>
    </div>
    <g:form action="submitBitstream" method="POST">
        <section class="row">
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
                            <input id="description" type="text" name="description" class="validate" placeholder="Informe uma descrição">
                            <label for="description"></label>
                        </td>
                        <td>
                            <div class="center">
                               <a class="btn my-orange" target="_blank" href="/data/processes/${processId}/tmp/${taskId}/${bitstream.name}"><g:message code="dspace.metadata.button_view" /> </a>
                            </div>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
        </section>
        <section class="row">
            <div class="col s12 m12 l12">
                <input type="hidden" name="processId" value="${processId}">
                <input type="hidden" name="taskId" value="${taskId}">
                <input type="hidden" name="itemId" value="${itemId}">
                <div class="right">
                    <button class="btn my-orange" type="submit"> <g:message code="dspace.metadata.button_finish"/> </button>
                </div>
            </div>
        </section>
    </g:form>
</article>
<g:javascript src="licenseShow.js"/>
</body>
</html>

