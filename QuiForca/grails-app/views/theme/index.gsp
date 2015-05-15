
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Theme" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:javascript src="scriptTheme.js"/>
        <!--<g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />-->
        
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
                                        <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td align="center"> <g:submitButton  name="save" class="save btn btn-success" value="Escolher Tema"/> </td>

                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/icon.png" class="img img-responsive max"/></td>
                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/opening.png" class="img-responsive max"/></td>
                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/background.png" class="img-responsive max"/></td>
                                            <td align="center"><button class="btn btn-danger delete">Remover</button></td>


                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <fieldset class="buttons">
                <div class="col-xs-12 center">
                    <g:link class="btn btn-success btn-lg" action="create">Novo tema</g:link>
                    <div class="paginacao">
                        <g:paginate total="${questionInstanceCount ?: 0}" />
                    </div>
                </div>
            </fieldset>
        </div>
    </body>
</html>
