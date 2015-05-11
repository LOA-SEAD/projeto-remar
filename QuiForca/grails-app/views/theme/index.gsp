
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Theme" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="scriptTheme.js"/>
        <!--<g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />-->
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header">
            <h1> Meus Temas</h1>
        </div>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Visualização dos Meus Temas</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                    <tr>
                                        <th>Selecionar</th>
                                        <th>Ícone</th>
                                        <th>Tela de Fundo</th>
                                        <th>Tela de Abertura</th>
                                        <th>Remover</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${themeInstanceList}" status="i" var="themeInstance">
                                        <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}" onclick="select">
                                            <td align="center"> <input class="checkbox" type="checkbox"/> </td>

                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/icon.png" width="200" height="200"/></td>
                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/opening.png" width="200" height="200"/></td>
                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/background.png" width="200" height="200"/></td>
                                            <td align="center"><button class="btn btn-danger">Remover</button></td>


                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <fieldset class="buttons">
                <g:submitButton  name="save" class="save btn btn-success" value="Escolher Tema"/>
                <div class="pagination">
                    <g:paginate total="${questionInstanceCount ?: 0}" />
                </div>
            </fieldset>
        </div>
    </body>
</html>