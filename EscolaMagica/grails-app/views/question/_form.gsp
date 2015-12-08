<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>


<div class="input-field col s12">
    <input id="title" name="title" required="" value="${questionInstance?.title}" type="text" class="validate">
    <label for="title">Pergunta</label>
</div>
<div class="input-field col s12">
    <input id="answers[0]" name="answers[0]" required="" value="${questionInstance?.answers[0]}" type="text" class="validate">
    <label for="answers[0]">Alternativa 1</label>
</div>
<div class="input-field col s12">
    <input id="answers[1]" name="answers[1]" required="" value="${questionInstance?.answers[1]}" type="text" class="validate">
    <label for="answers[1]">Alternativa 2</label>
</div>
<div class="input-field col s12">
    <input id="answers[2]" name="answers[2]" required="" value="${questionInstance?.answers[2]}" type="text" class="validate">
    <label for="answers[2]">Alternativa 3</label>
</div>
<div class="input-field col s12">
    <input id="answers[3]" name="answers[3]" required="" value="${questionInstance?.answers[3]}" type="text" class="validate">
    <label for="answers[3]">Alternativa 4</label>
</div>

<div class="input-field col s12">
    <input id="level" name="level" required="" value="${questionInstance?.level}" type="text" class="validate">
    <label for="level">Nível</label>
</div>
<div class="input-field col s12">
    <input id="correctAnswer" name="correctAnswer" required="" value="${questionInstance?.correctAnswer}" type="text" class="validate">
    <label for="correctAnswer">Alternativa Correta</label>
</div>