
<%@ page import="br.ufscar.sead.loa.quimemoria.remar.Tile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:external dir="css" file="tiles.css"/>
    <g:javascript src="scriptTile.js"/>
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <%--<g:set var="entityName" value="${message(code: 'Tile.label', default: 'Tile')}" /> --%>

</head>
	<body>
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            QuiMemória - Peças
        </p>
    </div>

    <div class="row">
        <div>
            %{--<p> Download peça </p>--}%
            <p style="margin-left: 10px;">Download do modelo de peças<a class="btn-floating waves-effect waves-light my-orange" href="/quimemoria/samples/tilesample.zip"><i class="material-icons">file_download</i></a>
            </p>
        </div>
    </div>

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
                    <g:link class="btn btn-success btn-lg my-orange" action="create">Nova peça</g:link>
                </div>
            </div>
        </form>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>

    </body>
</html>
