
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Theme" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:javascript src="scriptTheme.js"/>
    <!--<g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />-->

</head>
<body>

<nav class="layout-top-nav">
    <div class="nav-wrapper">
        <h3 style="margin: 10px;">Meus Temas</h3>
    </div>
</nav>

<div class="row">
</div>

<div class="row">
    <div>
        %{--<p> Download tema ESR</p>--}%
        <p style="margin-left: 10px;"> Download tema ESR <a class="btn-floating waves-effect waves-light" href="../data/samples/tema-escola-magica-esr.zip"> <i class="material-icons">file_download</i> </a>
        </p>
    </div>
</div>

<div class="row">
    <h4 style="margin-left: 10px;">Visualização dos Meus Temas</h4>
</div>
<div class="row">
    <form class="col s12" name="formName">
        <table class="responsive-table" id="table">
            <thead>
            <tr>
                <th>Selecionar</th>
                <th>Porta nível 1</th>
                <th>Porta nível 2</th>
                <th>Porta nível 3</th>
                <th>Ação</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${themeInstanceList}" status="i" var="themeInstance">
                <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td align="center"><input class="with-gap" name="radio" type="radio" id="theme${i}"
                                              value="${fieldValue(bean: themeInstance, field: "id")}" ${i == 0 ? "checked" : ""}> <label for="theme${i}"></label>
                    </td>
                    <td align="center"><img
                            src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portaa-sheet1.png"
                            class="img-responsive max door"/></td>
                    <td align="center"><img
                            src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portab-sheet1.png"
                            class="img-responsive max door"/></td>
                    <td align="center"><img
                            src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portac-sheet1.png"
                            class="img-responsive max door"/></td>
                    <td align="center"><i id="deleteIcon${i}" style="color: #26A69A" class="material-icons delete">delete</i></td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="row">
            <div class="col s12">
                <g:submitButton name="save" class="save btn btn-success btn-lg" value="Enviar"/>
                <g:link class="btn btn-success btn-lg" action="create">Novo tema</g:link>
            </div>
        </div>
    </form>
</div>
</body>
</html>
