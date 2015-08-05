<%@ page import="br.ufscar.sead.loa.remar.Word" %>

<section id="table" style="height: 300px">

    <table id="ListTable"  class="table table-responsive" style="height: 250px;">
        <thead>
        <tr>
            <th>Palavra</th>
            %{--<th>Word</th>--}%
            %{--<th>Initial Position</th>--}%
            <th>Editar</th>
            <th>Personalizar</th>
            <th>Remover</th>
        </tr>
        </thead>

        <tbody>
            <g:each in="${wordInstanceList}" status="i" var="wordInstance">
                <tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td style="color: #006dba">${wordInstance.answer.toUpperCase()}</td>
                    %{--<td><g:link action="show" id="${wordInstance.id}">${wordInstance.answer.toUpperCase()} </g:link></td>--}%
                    %{--<td>${fieldValue(bean: wordInstance, field: "word")}</td>--}%
                    %{--<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>--}%
                    <td><button id="button${wordInstance.id}" onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}',${wordInstance.initial_position}, ${wordInstance.id})">PERSONALIZAR</button></td>
                    <td>
                        <button onclick="editWord(${wordInstance.id},'${wordInstance.answer}')">EDITAR</button>
                    </td>
                    <td>
                        <button onclick="WordDelete('${wordInstance.id}')">REMOVER</button>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</section>


<script type="text/javascript">

</script>
