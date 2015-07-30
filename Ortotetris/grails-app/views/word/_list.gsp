<%@ page import="br.ufscar.sead.loa.remar.Word" %>
<section id="table" style="height: 300px">
    <h2>Palavras</h2>
    <table id="ListTable"  class="table table-responsive" style="height: 300px;">
        <thead>
        <tr>
            <th><input  type="text" id="SearchLabel"/> Buscar</th>
        </tr>
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
                    <td><g:link action="show" id="${wordInstance.id}">${wordInstance.answer.toUpperCase()} </g:link></td>
                    %{--<td>${fieldValue(bean: wordInstance, field: "word")}</td>--}%
                    %{--<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>--}%
                    <td><button id="button${wordInstance.id}" onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}',${wordInstance.initial_position}, ${wordInstance.id})">PERSONALIZAR</button></td>
                    <td>
                        <button onclick="editWord(${wordInstance.id},'${wordInstance.answer}')">EDITAR</button>
                    </td>
                    <td>
                        <button onclick="WordDelete('${wordInstance.id}')">REMOVER</button>
                        %{--<g:form  url="[resource:wordInstance, action:'delete']" method="DELETE">--}%
                            %{--<button onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">REMOVER</button>--}%
                        %{--</g:form>--}%
                    </td>
                </tr>
            </g:each>
        </tbody>

    </table>

</section>


<script type="text/javascript">
    $(function(){
        $("#ListTable input").keyup(function(){
            var index = $(this).parent().index();
            var nth = "#ListTable td:nth-child("+(index+1).toString()+")";
            var valor = $(this).val().toUpperCase();
            $("#ListTable tbody tr").show();
            $(nth).each(function(){
                if($(this).text().toUpperCase().indexOf(valor) < 0){
                    $(this).parent().hide();
                }
            });
        });

        $("#ListTable input").blur(function(){
            $(this).val("");
        });
    });
</script>
