
<%@ page import="br.ufscar.sead.loa.santograu.remar.FaseGaleria" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:javascript src="faseGaleria.js"/>
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<title>Em Busca do Santo Grau</title>
	</head>
	<body>
	<div class="cluster-header">
		<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
			<i class="small material-icons left"></i>Fase Galeria - Customização
		</p>
	</div>
	<div class="row">
		<form class="col s12" name="formName">
			<div class="row">
				<div class="fieldcontain required">
					<label for="orientacao">
						<g:message code="faseGaleria.orientacao.label" default="Orientacao " />
						<span class="required-indicator">*</span>
					</label>
					<g:field name="orientacao" type="text" required="" length="250" maxlength="250"/>
				</div>
				<div class="col s12">
					<g:submitButton name="save" class="save btn btn-success btn-lg my-orange" value="Enviar" style="margin-right:20px"/>
					<g:link class="btn btn-success btn-lg my-orange" action="create">Novo tema</g:link>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
	</body>
</html>
