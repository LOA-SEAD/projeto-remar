<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		<div class="page-header">
            <h1> Questões - Escola Mágica</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Visualização das Minhas Questões</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <g:if test="${flash.message}">
                                <div class="message" role="status">${flash.message}</div>
                                <br />
                            </g:if>
                             <g:form url="[resource:questionEscolaInstance, action:'update']" method="PUT" >
								<g:hiddenField name="version" value="${questionEscolaInstance?.version}" />
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
								<fieldset class="buttons">
									<g:actionSubmit class="save btn btn-success" action="update" value="${message(code: 'default.button.update.laasdbel', default: 'Salvar')}" />
									<g:link class="btn btn-warning btn-lg" action="index">Voltar</g:link>
								</fieldset>
							</g:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>
