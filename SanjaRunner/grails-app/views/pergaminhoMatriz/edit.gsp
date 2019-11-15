<%@ page import="br.ufscar.sead.loa.sanjarunner.remar.PergaminhoMatriz" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pergaminhoMatriz.label', default: 'PergaminhoMatriz')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Fase Matriz - Editar pergaminho
			</p>
		</div>
		<div class="row">
			<g:form method="post" action="update" resource="${pergaminhoMatrizInstance}">
				<div class="row">
					<div class="input-field col s12">
						<label id="labelInformation1" class="active" for="editInformation0">Texto 1</label>
						<input type="text" class="validate" id="editInformation0" name="information1" required=""/>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s12">
						<label id="labelInformation2" class="active" for="editInformation1">Texto 2</label>
						<input type="text" class="validate" id="editInformation1" name="information2" required=""/>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s12">
						<label id="labelInformation3" class="active" for="editInformation2">Texto 3</label>
						<input type="text" class="validate" id="editInformation2" name="information3" required=""/>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s12">
						<label id="labelInformation4" class="active" for="editInformation3">Texto 4</label>
						<input type="text" class="validate" id="editInformation3" name="information4" required=""/>
					</div>
				</div>

				<div class="col l10">
					<g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
				</div>
			</g:form>
		</div>
	</body>
</html>
