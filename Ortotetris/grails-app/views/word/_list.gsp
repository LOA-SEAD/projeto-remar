<%@ page import="br.ufscar.sead.loa.ortotetris.remar.Word" %>
<script type="text/javascript" src="${resource(dir: 'js', file: 'order.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'principal.js')}"></script>
<section id="table">
    <table id="ListTable" class="highlight centered">
        <thead>
        <tr>
            <th>Selecionar
                <div class="row" style="margin-bottom: -10px;">
                    <button style="margin-left: -15px; background-color: #795548" class="btn-floating " id="BtnCheckAll"
                            onclick="check_all()"><i class="material-icons">check_box_outline_blank</i></button>
                    <button style="margin-left: -15px; background-color: #795548" class="btn-floating "
                            id="BtnUnCheckAll" onclick="uncheck_all()"><i class="material-icons">done</i></button>
                </div>
            </th>
            <th id="AnswerLabel">Palavra</th>
            %{--<th> Word</th>--}%
            %{--<th> Posição Inicial</th>--}%
            %{--<th> ID</th>--}%
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${wordInstanceList}" status="i" var="wordInstance">
            <tr class="selectable_tr" style="cursor: pointer;"
                data-id="${fieldValue(bean: wordInstance, field: "id")}" data-checked="false">
            <td class="_not_editable"><input style="background-color: #727272" id="checklabel${i}" class="filled-in"
                                             type="checkbox"> <label for="checklabel${i}"></label></td>

            <td>${wordInstance.answer.toUpperCase()}
                <input type="hidden" value="${wordInstance.answer.toUpperCase()}" id="answerNew${wordInstance.id}">
            </td>
        %{--<td > ${wordInstance.word.toUpperCase()}--}%
            <input type="hidden" value="${wordInstance.word}" id="wordNew${wordInstance.id}">
            </td>
        %{--<td >${wordInstance.initial_position}--}%
            <input id="position${wordInstance.id}" value="${wordInstance.initial_position}" type="hidden">
            </td>
        %{--<td>${wordInstance.id}</td>--}%
            <td>
                <i class="material-icons" id="button${wordInstance.id}"
                   onclick="showWordAndModal('${wordInstance.word}', '${wordInstance.answer.toUpperCase()}', ${wordInstance.initial_position}, ${wordInstance.id})">games</i>
                <i class="material-icons"
                   onclick="EditWord('${wordInstance.answer.toUpperCase()}', ${wordInstance.id})">edit</i>
                <i class="material-icons" onclick="WordDelete('${wordInstance.id}')">delete</i>
            </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</section>


<!-- Modal Structure -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="row">
            <div class="col s12 m12 l12">
                <h4>Criar Palavra</h4>
            </div>
        </div>
        <div class="row">
            <div class="col s12 m6 offset-m3 l6 offset-l3">
                <div class="input-field" id="editDiv">
                    <input id="EditWordLabel"  maxlength="10" type="text" name="answer"> <label for="EditWordLabel"></label>
                    <input id="wordId" type="hidden" name="id"> <label></label>
                    <input type="hidden" value="none" name="word"> <label></label>
                    <input type="hidden" value="0" name="initialPosition"> <label></label>
                </div>
                <div class=" center-align s12 m3 l3">
                    <a onclick="UpdateWord()" class="btn btn-success btn-lg modal-close my-orange">Salvar</a>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Modal Structure -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <h4>Excluir Palavra</h4>

        <div class="row">
            <div class="row">
                <div style="text-align: center;" id="warningLabel">
                    <input id="wordIdDelete" type="hidden" name="id"> <label></label>
                </div>
            </div>

            <div class="col offset-s8">
                <button class="btn grey waves-effect waves-light modal-close">Não</button>
                <button id="deleteButton" class="btn waves-effect waves-light modal-close my-orange"
                        onclick="Delete()">Sim</button>
            </div>

        </div>
    </div>
</div>



<script>

    function EditWord(answer, id) {
        $("#editDiv").empty();
        $("#editDiv").append("<input class='center' maxlength='10' id='EditWordLabel' value='" + answer + "' type='text' name='answer'> <label for='EditWordLabel'></label>");
        $("#editDiv").append("<input id='wordId' type='hidden' value='" + id + "' name='id'> <label></label>");
        $("#editDiv").append("<input type='hidden' value='none' name='word'> <label></label>");
        $("#editDiv").append("<input type='hidden' value='0' name='initialPosition'> <label></label>");
        $('#editModal').openModal();
    }

    function UpdateWord() {
        var ans = document.getElementById("EditWordLabel").value;
        var id = document.getElementById("wordId").value;
        var parameters = {"id": id, "new_answer": ans};
        <g:remoteFunction action="editWord" params="parameters" update="TableWordList"/>
    }

    function WordDelete(id) {
        $('#warningLabel').empty();
        $("#warningLabel").append("<div> <p> Você tem certeza ?  </p> </div>");
        $("#warningLabel").append("<input id='wordIdDelete' value='" + id + "' type='hidden' name='id'> <label></label>");
        $('#deleteModal').openModal();
    }

    function Delete() {
        var deleteID = document.getElementById("wordIdDelete").value;
        var parameters = {"id": deleteID};
        <g:remoteFunction action="WordDelete" params="parameters" update="TableWordList"/>
    }

</script>


