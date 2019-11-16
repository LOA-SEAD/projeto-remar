<%@ page import="br.ufscar.sead.loa.erainclusiva.remar.Resource" %>
<link rel="stylesheet" type="text/css" href="/erainclusiva/css/resource.css">


<div class="input-field col s12">
    <input id="statement" name="statement" required="" value="${resourceInstance?.statement}" type="text" class="validate remar-input" maxlength="150">
    <label for="statement">Pergunta</label>
</div>
<div class="input-field col s12">
    <input id="answer" name="answer" required="" value="${resourceInstance?.answer}" type="text" class="validate remar-input"  onkeypress="validate(event)" maxlength="48">
    <label for="answer">Resposta</label>
</div>
<div class="input-field col s12">
    <input id="category" name="category" required="" value="${resourceInstance?.category}" type="text" class="validate remar-input">
    <label for="category">Tema</label>
</div>

<div class="input-field col s12" style="display: none;">
    <input id="author" name="author" required="" readonly="readonly" value="${resourceInstance?.author}" type="text" class="validate remar-input">
    <label for="author">Autor</label>
</div>

