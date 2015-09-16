
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Theme" %>
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
                <div class="alert alert-danger">
                    <i class="fa fa-info-circle"></i>
                    <a href="/escolamagica/data/samples/tema-escola-magica-esr.zip">Download tema ESR</a>
                </div>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="table">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">Selecionar</th>
                                        <th class="col-md-3">Porta nível 1</th>
                                        <th class="col-md-3">Porta nível 2</th>
                                        <th class="col-md-3">Porta nível 3</th>
                                        <th class="col-md-3">Remover</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${themeInstanceList}" status="i" var="themeInstance">
                                        <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td align="center"> <g:submitButton  name="save" class="save btn btn-success" value="Escolher Tema"/> </td>

                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portaa-sheet1.png" class="img-responsive door"/></td>
                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portab-sheet1.png" class="img-responsive door"/></td>
                                            <td align="center"><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/portac-sheet1.png" class="img-responsive door"/></td>
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
