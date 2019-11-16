<%@ page import="br.ufscar.sead.loa.erainclusiva.remar.Resource" %>
<link rel="stylesheet" type="text/css" href="/erainclusiva/css/resource.css">


<div class="input-field col s12">
    <input id="statement" name="statement" required="" value="${resourceInstance?.statement}" type="text"
           class="validate remar-input" maxlength="150">
    <label for="statement">Nome</label>
</div>

<div class="input-field col s12">
    <input id="answer" name="answer" required="" value="${resourceInstance?.answer}" type="text"
           class="validate remar-input" maxlength="48">
    <label for="answer">Link</label>
</div>

<div class="input-field col s12">
    <g:select id="category" name="category" from="${Resource.categorias}"
              value="${resourceInstance?.category}"/>
    <label for="category">Categoria</label>
</div>

<div class="input-field col s12" style="display: none;">
    <input id="author" name="author" required="" readonly="readonly" value="${resourceInstance?.author}" type="text"
           class="validate remar-input">
    <label for="author">Autor</label>
</div>

