<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Banco de Jogos</title>
        <meta name="layout" content="materialize-layout">
    </head>
    <body>
        <div class="row cluster">
            <div class="cluster-header">
                <h4>Banco de Jogos</h4>

                <div class="divider"></div>
            </div>

            <div class="row show search">
                <div class="input-field col s6">
                    <input id="search" type="text" placeholder="Buscar jogo" class="validate" autocomplete="off">
                    <label for="search"><i class="fa fa-search" ></i></label>
                </div>
                <div class="input-field col s6">
                    <select class="material-select">
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
                <g:render template="customizedGameCard" model="[publicExportedResourcesList: publicExportedResourcesList, mode: 'public']" />
            </div>
        </div>

        <div id="userDetailsModal" class="modal remar-modal">
            %{-- Preenchido pelo Javascript --}%
        </div>
        <!--g:applyLayout name="pagination"/-->
        <g:javascript src="remar/menu.js"/>
    </body>
</html>
