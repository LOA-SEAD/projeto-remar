
<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">

    <%--<g:set var="entityName" value="${message(code: 'Tile.label', default: 'Tile')}" /> --%>
</head>

<body>
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            REMemória - Peças
        </p>
    </div>

    %{-- Download peça modelo --}%
    <div class="row">
        <div class="row col s4 valign-wrapper">
            <div class="col s8">
                <p style="margin-left: 10px;">Download do modelo de peças</p>
            </div>
            <div class="col s4">
                <a class="btn-floating waves-effect waves-light my-orange" href="/quimemoria/samples/tilesample.zip">
                    <i class="material-icons">file_download</i>
                </a>
            </div>
        </div>
    </div>

    %{-- Lista de peças do nível fácil --}%
    <div class="row">
        <ul class="collection with-header">
            <li class="collection-header">
                <h4>Nível Fácil</h4>
            </li>
            %{--
            <g:if test="${easyTilesList.size() < 1 }">
                <li class="collection-item">
                    <p>Você ainda não possui nenhuma peça</p>
                </li>
            </g:if>
            <g:else>
            --}%
                <g:each in="${easyTilesList}" var="tile">
                    <li class="collection-item">
                        <div>
                            ${tile.content}
                        </div>
                    </li>
                </g:each>
            %{--
            </g:else>
            --}%
        </ul>
    </div>

    %{-- Lista de peças do nível médio --}%
    <div class="row">
        <ul class="collection with-header">
            <li class="collection-header">
                <h4>Nível Médio</h4>
            </li>
            %{--
            <g:if test="${normalTilesList.size() < 1 }">
                <li class="collection-item">
                    <p>Você ainda não possui nenhuma peça</p>
                </li>
            </g:if>
            <g:else>
            --}%
                <g:each in="${normalTilesList}" var="tile">
                    <li class="collection-item">
                        <div>
                            ${tile.content}
                        </div>
                    </li>
                </g:each>
            %{--
            </g:else>
            --}%
        </ul>
    </div>

    %{-- Lista de peças do nível difícil --}%
    <div class="row">
        <ul class="collection with-header">
            <li class="collection-header">
                <h4>Nível Difícil</h4>
            </li>
            %{--
            <g:if test="${hardTilesList.size() < 1 }">
                <li class="collection-item">
                    <p>Você ainda não possui nenhuma peça</p>
                </li>
            </g:if>
            <g:else>
            --}%
                <g:each in="${hardTilesList}" var="tile">
                    <li class="collection-item">
                        <div>
                            ${tile.content}
                        </div>
                    </li>
                </g:each>
            %{--
            </g:else>
            --}%
        </ul>
    </div>


    %{--
    <div class="row">
        <form class="col s12" name="formName">
            <ul class="collapsible" data-collapsible="accordion">
                <li>
                    <div class="collapsible-header active"> <b>Minhas Peças </b></div>
                    <div class="collapsible-body">
                        <g:if test="${tileInstanceListMy.size() < 1 }">
                            <p> Você ainda não possui nenhuma peça</p>
                        </g:if>
                        <g:else>
                            <table class="" id="tableMyTile">
                                <thead>
                                <tr>
                                    <th class="simpleTable">Selecionar</th>
                                    <th class="simpleTable">Peça A</th>
                                    <th class="simpleTable">Peça B</th>
                                    <th class="simpleTable">Ação</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${tileInstanceListMy}" status="i" var="tileInstance">
                                    <tr data-id="${fieldValue(bean: tileInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td class="myTile simpleTable" align="center "><input class="with-gap " name="checkbox" type="checkbox" id="myTile${i}" data-tileid="${tileInstance.id}"
                                                                                              value="${fieldValue(bean: tileInstance, field: "id")}" > <label for="myTile${i}"></label>
                                        </td>
                                        <td align="center"><img width="142"
                                                                src="/quimemoria/data/${fieldValue(bean: tileInstance, field: "ownerId")}/tiles/tile${fieldValue(bean: tileInstance, field: "id")}-a.png"
                                                                class="img-responsive max"/></td>
                                        <td align="center"><img width="142"
                                                                src="/quimemoria/data/${fieldValue(bean: tileInstance, field: "ownerId")}/tiles/tile${fieldValue(bean: tileInstance, field: "id")}-b.png"
                                                                class="img-responsive max"/></td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </g:else>
                    </div>
                </li>
            </ul>
            <div class="row">
                <div class="col s12">
                    <g:submitButton name="save" class="save btn btn-success btn-lg my-orange" value="Enviar"/>

                </div>
            </div>
        </form>
    </div>
    --}%

    <g:link class="btn btn-success btn-lg my-orange" action="create">Nova peça</g:link>

    <g:javascript src="scriptTile.js"/>
</body>
</html>
