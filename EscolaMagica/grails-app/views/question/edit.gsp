<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
	<head>
		%{--<meta name="layout" content="main">--}%
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	</head>
	<body>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> <i class="fa fa-table"></i> Editar Questão</h4>
    </div>
    <div class="widget-content-white glossed">
        <div class="padded">
            <div class="table-responsive">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
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
                                <g:link class="delete btn btn-danger btn-lg" action="delete"
                                params='[id: "${questionInstance.id}"]' onclick="return confirm('Você tem certeza?')">Remover</g:link>
                        </fieldset>
				</g:form>
            </div>
        </div>
    </div>


	</body>
</html>
