<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>
<section>
    <div class="row">
        <div class="col s12 div-author">
            %{--<span class="description-input">Entre com o nome do autor do item. </span>--}%
                <g:if test="${metadata != null}">
                    <g:each in="${metadata.authors}" var="author">
                        <div class="input-field col m6 s12">
                            <input name="author" id="author" type="text" class="validate" value="${author.name}">
                            <label for="author">
                                <g:message code="dspace.metadata.author"/>
                            </label>
                        </div>
                    </g:each>
                </g:if>
                <g:else>
                    <div class="input-field col s12">
                        <input name="author" id="author" type="text" class="validate" value="${session.user.firstName}">
                        <span id="author-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                        <label for="author">
                            <g:message code="dspace.metadata.author"/>
                        </label>
                    </div>
                </g:else>
            <div class="right">
                <span class="btn my-orange" id="add-author">adicionar autor</span>
            </div>
        </div>

        <div class="col s12">
            %{--<span class="description-input">Entre com um nome padrão de citação. </span>--}%
            <div class="input-field col s12">
                <input name="citation" id="citation" type="text" class="validate" value="${metadata!=null? metadata.citation : ''}">
                <span id="citation-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                <label for="citation"><g:message code="dspace.metadata.citation"/> </label>
            </div>
        </div>

        <div class="col s12">
            %{--<span class="description-input">Entre com o título item. </span>--}%
            <div class="input-field col s12">
                <input name="title" id="title" type="text" class="" value="${metadata!=null? metadata.title : ''}">
                <span id="title-error" class="invalid-textarea" style="left: 0.75rem; top: 45px;">Este campo não pode ser vazio!</span>
                <label for="title"><g:message code="dspace.metadata.title"/> </label>
            </div>
        </div>

        <div class="col s12">
            %{--<span class="description-input">Entre com o resumo do item. </span>--}%
            <div class="input-field col s12">
                <textarea name="description" id="description" class="materialize-textarea">${metadata!=null? metadata.abstract : ''}</textarea>
                <span id="description-error" class="invalid-textarea" style="left: 0.75rem;">Este campo não pode ser vazio!</span>
                <label for="description"><g:message code="dspace.metadata.abstract"/> </label>
            </div>
        </div>
    </div>
</section>
<g:javascript src="dspace/validateSubmit.js"/>
<g:javascript src="dspace/item.js"/>
