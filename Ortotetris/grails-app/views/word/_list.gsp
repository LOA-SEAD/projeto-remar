<%@ page import="br.ufscar.sead.loa.remar.Word" %>
<script type="text/javascript" src="${resource(dir: 'js', file: 'order.js')}"></script>

<section id="table">

    <table  id="ListTable" class="highlight centered">
       <thead>
        <tr>
            <th id="AnswerLabel" >Palavra</th>
            %{--<th>Word</th>--}%
            %{--<th>Initial Position</th>--}%
            <th>Ações</th>
        </tr>
       </thead>
        <tbody>
            <g:each in="${wordInstanceList}" status="i" var="wordInstance">
                <tr style="height: 50px; top: -10px; ">
                    <td>${wordInstance.answer.toUpperCase()}</td>
                    %{--<td>${fieldValue(bean: wordInstance, field: "word")}</td>--}%
                    %{--<td>${fieldValue(bean: wordInstance, field: "initial_position")}</td>--}%
                    <td>
                        <i class="material-icons" id="button${wordInstance.id}" onclick="ShowWord('${wordInstance.word}','${wordInstance.answer.toUpperCase()}',${wordInstance.initial_position}, ${wordInstance.id})">games</i>
                        <i class="material-icons modal-trigger" data-target="editModal${i}" onclick="editWord(${wordInstance.id},'${wordInstance.answer}')">edit</i>
                        <i class="material-icons" onclick="WordDelete('${wordInstance.id}')">delete</i>
                    </td>
                </tr>

                <!-- Modal Structure -->
                <div id="editModal${i}" class="modal">
                    <div class="modal-content">
                        <h4>Editar Palavra</h4>
                        <div class="row">
                            %{--<g:form url="[resource:wordInstance, action:'save']" >--}%
                            <div class="row">
                                <div class="input-field col s6 offset-s3">
                                    <input id="EditWordLabel${i}" value="${wordInstance?.answer}"  type="text" name="answer"> <label for="EditWordLabel${i}">Digite uma nova palavra</label>
                                    <input type="hidden" value="none" name="word"> <label></label>
                                    <input type="hidden" value="0" name="initialPosition"> <label></label>
                                </div>
                            </div>
                            %{--<g:submitButton name="update"> Salvar</g:submitButton>--}%
                            <button name="edit" onclick="UpdateWord(${wordInstance?.id}, ${i})" class="btn btn-success btn-lg">Salvar</button>
                            %{--</g:form>--}%
                        </div>
                    </div>
                </div>

            </g:each>
        </tbody>
    </table>
</section>


