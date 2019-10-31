<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<article class="width-position left-align">
  <!-- Se não for a tela de preview dos dados -->
    <section class="row">
        <div class="col s12">
            <table class="bordered centered">
                <thead>
                    <tr>
                        <th data-field="answer">Arquivo</th>
                        <th data-field="action">Ação </th>
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
</article>

