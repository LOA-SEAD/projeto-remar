<%@ page import="br.ufscar.sead.loa.erainclusiva.remar.Resource" %>
<link rel="stylesheet" type="text/css" href="/erainclusiva/css/resource.css">


<div class="input-field col s12">
    <input id="name" name="name" required="" value="${resourceInstance?.name}" type="text"
           class="validate remar-input" maxlength="150">
    <label for="name">Nome</label>
</div>

<div class="input-field col s12">
    <input id="source" name="source" required="" value="${resourceInstance?.source}" type="text"
           class="validate remar-input" maxlength="48">
    <label for="source">Link</label>
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

