<%@ page import="br.ufscar.sead.loa.forca.remar.Question" %>
<link rel="stylesheet" type="text/css" href="/forca/css/question.css">


<div class="input-field col s12">
    <input id="statement" name="statement" required="" value="${questionInstance?.statement}" type="text" class="validate remar-input" maxlength="150">
    <label for="statement">Pergunta</label>
</div>
<div class="input-field col s12">
    <input id="answer" name="answer" required="" value="${questionInstance?.answer}" type="text" class="validate remar-input"  onkeypress="validate(event)" maxlength="48">
    <label for="answer">Resposta</label>
</div>
<div class="input-field col s12">
    <input id="category" name="category" required="" value="${questionInstance?.category}" type="text" class="validate remar-input">
    <label for="category">Tema</label>
</div>

<div class="input-field col s12" style="display: none;">
    <input id="author" name="author" required="" readonly="readonly" value="${questionInstance?.author}" type="text" class="validate remar-input">
    <label for="author">Autor</label>
</div>

