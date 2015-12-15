<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>

<div class="row">
    <div class="input-field col s12">
        <label for="title">Pergunta</label>
        <input id="title" name="title" required="" value="${questionInstance?.title}" type="text" class="validate">
    </div>
</div>

<div class="row">
    <div class="input-field col s10">
        <label for="answers[0]">Alternativa 1</label>
        <input type="text" class="validate" id="answers[0]" name="answers[0]" required="" value="${questionInstance?.answers[0]}"/>
    </div>
    <div class="col s2">
        <input type="radio" id="radio0${count}" name="correctAnswer" value="0" checked="${questionInstance?.correctAnswer == 0}"/>
        <label for="radio0${count}">Alternativa correta</label>
    </div>
</div>

<div class="row">
    <div class="input-field col s10">
        <label for="answers[1]">Alternativa 2</label>
        <input type="text" class="validate" id="answers[1]" name="answers[1]" required="" value="${questionInstance?.answers[1]}"/>
    </div>
    <div class="col s2">
        <input type="radio" id="radio1${count}" name="correctAnswer" value="1" checked="${questionInstance?.correctAnswer == 1}"/>
        <label for="radio1${count}">Alternativa correta</label>
    </div>
</div>

<div class="row">
    <div class="input-field col s10">
        <label for="answers[2]">Alternativa 3</label>
        <input type="text" class="validate" id="answers[2]" name="answers[2]" required="" value="${questionInstance?.answers[2]}"/>
    </div>
    <div class="col s2">
        <input type="radio" id="radio2${count}" name="correctAnswer" value="2" checked="${questionInstance?.correctAnswer == 2}"/>
        <label for="radio2${count}">Alternativa correta</label>
    </div>
</div>

<div class="row">
    <div class="input-field col s10">
        <label for="answers[3]">Alternativa 4</label>
        <input type="text" class="validate" id="answers[3]" name="answers[3]" required="" value="${questionInstance?.answers[3]}"/>
    </div>
    <div class="col s2">
        <input type="radio" id="radio3${count}" name="correctAnswer" value="3" checked="${questionInstance?.correctAnswer == 3}"/>
        <label for="radio3${count}">Alternativa correta</label>
    </div>
</div>


<div class="row">
    <div class="col s2 offset-s3">
        <input type="radio" id="level1${count}" name="level" value="1" checked="${questionInstance?.level == 1}"/>
        <label for="level1${count}">Nível 1</label>

    </div>

    <div class="col s2">
        <input type="radio" id="level2${count}" name="level" value="2" checked="${questionInstance?.level == 2}"/>
        <label for="level2${count}">Nível 2</label>
    </div>

    <div class="col s2">
        <input type="radio" id="level3${count}" name="level" value="3" checked="${questionInstance?.level == 3}"/>
        <label for="level3${count}">Nível 3</label>
        %{--<input type="text" name="level" id="level" value="${questionInstance?.level}">--}%
        %{--<g:select id="level" name="level" from="${1..3}" value="${questionInstance?.level}"/>--}%
        %{--<label for="level${count}">Nível</label>--}%
        %{--<select name="level" id="level${count}">--}%
            %{--<option value="1">1</option>--}%
            %{--<option value="2">2</option>--}%
            %{--<option value="3">3</option>--}%
        %{--</select>--}%
    </div>
</div>

<div class="row">

</div>

<div class="row">

</div>

<script>
    $(document).ready(function(){
        // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
        $('select').material_select();
    });

</script>