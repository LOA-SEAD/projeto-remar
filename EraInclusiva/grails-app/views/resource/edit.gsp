<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 06/10/15
  Time: 10:44
--%>

<%@ page import="br.ufscar.sead.loa.erainclusiva.remar.Resource" %>
<!DOCTYPE html>
<html>
<head>
    %{--<meta statement="layout" content="main">--}%
    <g:javascript src="scriptTable.js"/>
</head>
<body>
    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"><i class="icon-table"></i> Editar Questão</h4>
        </div>
        <div class="modal-body">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="padded">
                <div class="table-responsive">
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}
                        </div>
                        <br />
                    </g:if>
                    <g:form url="[resource:resourceInstance, action:'update']" method="PUT" >
                        <g:hiddenField name="version" value="${resourceInstance?.version}" />
                            <fieldset class="form">
                                <g:render template="form"/>
                            </fieldset>
                            <fieldset class="buttons">
                                <g:actionSubmit class="save btn btn-success btn-lg" action="update"
                                    value="${message(code: 'default.button.update.laasdbel', default: 'Salvar')}"/>
                            </fieldset>
                    </g:form>
                </div>

        </div>
</body>
</html>