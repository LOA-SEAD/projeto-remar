
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Theme" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:external dir="css" file="themes.css"/>
    <g:javascript src="scriptTheme.js"/>
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <!--<g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />-->

</head>
<body>

<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
        Escola Mágica - Temas
    </p>
</div>

<div class="row">
    <div>
        %{--<p> Download tema ESR</p>--}%
        <p style="margin-left: 10px;">Download do tema modelo <a class="btn-floating waves-effect waves-light my-orange" href="/escolamagica/samples/portas-escola-magica.zip"><i class="material-icons">file_download</i></a>
        </p>
    </div>
</div>

<div class="row">
    <form class="col s12" name="formName">
        <ul class="collapsible" data-collapsible="accordion">
            <li>
                <div class="collapsible-header active"> <b>Meus Temas </b></div>
                <div class="collapsible-body">
                    <g:if test="${themeInstanceListMy.size() < 1 }">
                        <p> Você ainda não possui nenhum tema</p>
                    </g:if>
                    <g:else>
                        <table class="" id="tableMyTheme">
                            <thead>
                            <tr>
                                <th class="simpleTable">Selecionar</th>
                                <th class="simpleTable">Porta nível 1</th>
                                <th class="simpleTable">Porta nível 2</th>
                                <th class="simpleTable">Porta nível 3</th>
                                <th class="simpleTable">Ação</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${themeInstanceListMy}" status="i" var="themeInstance">
                                <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td class="myTheme simpleTable" align="center "><input class="with-gap " name="radio" type="radio" id="myTheme${i}"
                                                                               value="${fieldValue(bean: themeInstance, field: "id")}" > <label for="myTheme${i}"></label>
                                    </td>
                                    <td align="center"><img width="142"
                                            src="/escolamagica/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portaa-sheet1.png"
                                            class="img-responsive max door"/></td>
                                    <td align="center"><img width="142"
                                            src="/escolamagica/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portab-sheet1.png"
                                            class="img-responsive max door"/></td>
                                    <td align="center"><img width="142"
                                            src="/escolamagica/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portac-sheet1.png"
                                            class="img-responsive max door"/></td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:else>
                </div>
            </li>
            <li>
                <div class="collapsible-header"><b>Temas Públicos</b></div>
                <div class="collapsible-body">
                    <table class="" id="tablePublicTheme">
                        <thead>
                        <tr>
                            <th class="simpleTable">Selecionar</th>
                            <th class="simpleTable">Porta nível 1</th>
                            <th class="simpleTable">Porta nível 2</th>
                            <th class="simpleTable">Porta nível 3</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${themeInstanceListPublic}" status="i" var="themeInstance">
                            <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td class="simpleTable" align="center "><input class="with-gap " name="radio" type="radio" id="pTheme${i}"
                                                                                       value="${fieldValue(bean: themeInstance, field: "id")}" > <label for="pTheme${i}"></label>
                                </td>
                                <td align="center"><img width="142"
                                        src="/escolamagica/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portaa-sheet1.png"
                                        class="img-responsive max door"/></td>
                                <td align="center"><img width="142"
                                        src="/escolamagica/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portab-sheet1.png"
                                        class="img-responsive max door"/></td>
                                <td align="center"><img width="142"
                                        src="/escolamagica/data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portac-sheet1.png"
                                        class="img-responsive max door"/></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </li>
            </ul>
        <div class="row">
            <div class="col s12">
                <g:submitButton name="save" class="save btn btn-success btn-lg my-orange" value="Enviar"/>
                <g:link class="btn btn-success btn-lg my-orange" action="create">Novo tema</g:link>
            </div>
        </div>
    </form>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>

</body>
</html>
