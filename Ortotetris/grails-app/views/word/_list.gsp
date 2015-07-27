<%@ page import="br.ufscar.sead.loa.remar.Word" %>
<div id="table" style="width:960px; height:350px; overflow: auto;" id="list-word" class="content scaffold-list" role="main" >
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table id="tabela">
        <thead>
        <tr>
            <th><input  type="text" id="SearchLabel"/> Buscar</th>
        </tr>
        <tr>
            <g:sortableColumn property="answer" title="${message(code: 'word.answer.label', default: 'Answer')}" />
            <g:sortableColumn property="word" title="${message(code: 'word.word.label', default: 'Word')}" />
            <g:sortableColumn property="initial_position" title="${message(code: 'word.initial_position.label', default: 'Initialposition')}" />
            <g:sortableColumn property="Personalizar" title="${message(code: 'word.initial_position.label', default: 'Personalizar')}" />
            <g:sortableColumn property="Editar" title="${message(code: 'word.initial_position.label', default: 'Editar')}" />
            <g:sortableColumn property="Remover" title="${message(code: 'word.initial_position.label', default: 'Remover')}" />
        </tr>

        </thead>
        <tbody>
        <g:each in="${wordInstanceList}" status="i" var="wordInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="show" id="${wordInstance.id}">${wordInstance.answer.toUpperCase()} </g:link></td>
                <td>${fieldValue(bean: wordInstance, field: "word")}</td>
                <td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>
                <td><button id="button${wordInstance.id}" onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}',${wordInstance.initial_position}, ${wordInstance.id})">PERSONALIZAR</button></td>
                <td>
                    <button onclick="editWord(${wordInstance.id},'${wordInstance.answer}')">EDITAR</button>
                    %{--<g:link class="edit" action="edit" resource="${wordInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>--}%
                </td>
                <td>
                    <g:form url="[resource:wordInstance, action:'delete']" method="DELETE">
                        <fieldset class="buttons">
                            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </fieldset>
                    </g:form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function(){
        $("#tabela input").keyup(function(){
            var index = $(this).parent().index();
            var nth = "#tabela td:nth-child("+(index+1).toString()+")";
            var valor = $(this).val().toUpperCase();
            $("#tabela tbody tr").show();
            $(nth).each(function(){
                if($(this).text().toUpperCase().indexOf(valor) < 0){
                    $(this).parent().hide();
                }
            });
        });

        $("#tabela input").blur(function(){
            $(this).val("");
        });
    });
</script>
