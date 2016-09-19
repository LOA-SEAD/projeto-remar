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
            <i class="medium material-icons left">cloud_upload</i>Adicionar Metadados

        </p>
        <div class="divider"></div>
        <div class="clearfix"></div>
        <div class="right">
            <span>3/3</span>
        </div>
        <div class="subtitle space">
            <h3 class="text-teal text-darken-3 center truncate">
                ${task.definition.name}
            </h3>
            <h5 class="center date">
               Conferindo os dados
            </h5>
        </div>
        <div class="row center">
            <p>
                Atenção! Antes de finalizar o envio, por favor confira os dados atentamente. Uma vez enviado
                para o respositório o conteúdo só podera ser alterado ou removido mediante contanto com o
                administrador da plataforma.
            </p>
        </div>
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
                    <input type="hidden" id="itensCount" value="${bitstreams.size()}" />
                    <g:each in="${bitstreams}" var="bitstream" status="i">
                        <tr class="line">
                            <td>
                                ${bitstream.name}
                            </td>
                            <td>
                                <input id="description${i}" type="text" name="description" class="validate" placeholder="Informe uma descrição">
                                <label for="description${i}"></label>
                                <span id="description${i}-error" class="description-error" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                            </td>
                            <td>
                                <div class="center">
                                   <a class="" target="_blank" href="/data/processes/${task.process.id}/tmp/${task.id}/${bitstream.name}"><g:message code="dspace.metadata.button_view" /> </a>
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
                <input type="hidden" name="taskId" value="${task.id}">
                <div class="right">
                    <a id="finishLabel" class="btn disabled"><g:message code="dspace.metadata.button_finish"/></a>
                    <button class="btn my-orange hide" id="finishButton" type="submit"> <g:message code="dspace.metadata.button_finish"/> </button>
                </div>
            </div>
        </section>
    </g:form>
</article>
<g:javascript src="dspace/validateDescription.js"/>
</body>
</html>

