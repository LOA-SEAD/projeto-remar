<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Meus jogos</title>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="row cluster">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 24px;">
            Meus Jogos
        </p>
        <div class="divider"></div>
    </div>
    <div class="row">
        <div class="col s12">
            <ul class="tabs">
                <li class="tab col s3"><a href="#test2">Em customização</a></li>
                <li class="tab col s3"><a class="active" href="#test1">Publicados</a></li>
            </ul>
        </div>
        <section id="test1" class="col s12"> <!-- start my published games -->
            <div class="row search">
                <div class="input-field col s6">
                    <input id="search" type="text" placeholder="Buscar meus jogos"class="validate">
                    <label for="search"><i class="fa fa-search"></i></label>
                </div>
                <div class="input-field col s6">
                    <select>
                        <option class="option" value="-1" selected>Todas</option>
                        <g:if test="${categories.size() > 0}">
                            <g:each in="${categories}" var="category">
                                <option class="option" value="${category.id}">${category.name}</option>
                            </g:each>
                        </g:if>
                    </select>
                    <label>Categoria</label>
                </div>
            </div>
            <div id="showCards" class="row">
                <article class="row">
                    <g:render template="myCardGame" model="[myExportedResourcesList:myExportedResourcesList]" />
                </article>
            </div>
        </section> <!-- finished my published games-->

        <section id="test2" class="col s12"> <!-- start processes-->
            <div class="row search">
                <div class="input-field col s12">
                    <input id="search-processes" type="text" class="validate">
                    <label for="search-processes"><i class="fa fa-search"></i></label>
                </div>
            </div>
            <div id="showCardsProcess" class="row">
                <article class="row">
                    <g:render template="/process/process" model="[processes:processes]" />
                </article>
            </div>
        </section> <!-- finished processes-->
    </div>
</div>

<div id="userDetailsModal" class="modal remar-modal">
    <div class="modal-content">
        <h4>Informações de Usuário</h4>
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close btn waves-effect waves-light my-orange">OK</a>
    </div>
</div>

<script>
    $(document).ready(function(){
        $('.modal-trigger').leanModal();
    });
</script>
<g:javascript src="menu.js"/>
<g:javascript src="utility/utility-my-game.js"/>

</body>
</html>