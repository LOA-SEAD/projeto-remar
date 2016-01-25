<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>

<div class="input-field col s12">
    <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate">
    <label for="statement">Pergunta</label>
</div>
<div class="input-field col s12">
    <input id="answer" name="answer" required="" value="${questionInstance?.answer}" type="text" class="validate">
    <label for="answer">Resposta</label>
</div>
<div class="input-field col s12">
    <input id="category" name="category" required="" value="${questionInstance?.category}" type="text" class="validate">
    <label for="category">Tema</label>
</div>

<div class="input-field col s12">
    <input id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}" type="text" class="validate">
    <label for="author">Autor</label>
</div>
