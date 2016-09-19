<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<article class="width-position left-align">
      <!-- Se não for a tela de preview dos dados -->
    <g:if test="${metadata == null}">
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
                            <input id="description${i}" type="text" name="bit_description" class="validate" placeholder="Informe uma descrição">
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
    </g:if>
    <g:else>
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
                                <input id="description${i}" type="text" name="bit_description" class="validate" placeholder="Informe uma descrição"
                                    value="${bitstream.description}" />
                                <label for="description${i}"></label>
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
    </g:else>
</article>
<g:javascript src="dspace/validateDescription.js"/>

