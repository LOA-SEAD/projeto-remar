<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 06/10/15
  Time: 10:44
--%>

<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
<head>
    %{--<meta name="layout" content="main">--}%
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
                    <g:form url="[resource:questionInstance, action:'update']" method="PUT" >
                        <g:hiddenField name="version" value="${questionInstance?.version}" />
                            <fieldset class="form">
                                <g:render template="form"/>
                            </fieldset>
                            <fieldset class="buttons">
                                <g:actionSubmit class="save btn btn-success btn-lg" action="update"
                                    value="${message(code: 'default.button.update.laasdbel', default: 'Salvar')}"/>
                                <g:link class="btn btn-warning btn-lg" action="index">Voltar</g:link>
                            </fieldset>
                    </g:form>
                </div>
            %{--<div class="modal-footer">--}%
            %{--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--}%
            %{--</div>--}%
        </div>
</body>
</html>