<%@ page import="br.ufscar.sead.loa.remar.Word" %>

<section id="table" style="height: 300px">

    <table  id="ListTable" class="table">
       <thead>
        <tr style="top: -10px;">
            <th style="text-align: center">Palavra</th>
            %{--<th>Word</th>--}%
            %{--<th>Initial Position</th>--}%
            <th style="text-align: center">Editar</th>
            <th style="text-align: center">Personalizar</th>
            <th style="text-align: center">Remover</th>
        </tr>
       </thead>
        <tbody>
            <g:each in="${wordInstanceList}" status="i" var="wordInstance">
                <tr style="height: 50px; top: -10px; ">
                    <td style="color: #006dba; text-align: center">${wordInstance.answer.toUpperCase()}</td>
                    %{--<td>${fieldValue(bean: wordInstance, field: "word")}</td>--}%
                    %{--<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>--}%
                    <td style="text-align: center">
                        <button id="button${wordInstance.id}" onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}',${wordInstance.initial_position}, ${wordInstance.id})">PERSONALIZAR</button>
                    </td>
                    <td style="text-align: center">
                        <button onclick="editWord(${wordInstance.id},'${wordInstance.answer}')">EDITAR</button>
                    </td>
                    <td style="text-align: center">
                        <button onclick="WordDelete('${wordInstance.id}')">REMOVER</button>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</section>


<script type="text/javascript" defer="defer">
    $(document).ready(function() {
        $("#MessageDivTemplate").delay(1000).fadeOut(500);
    });
</script>
