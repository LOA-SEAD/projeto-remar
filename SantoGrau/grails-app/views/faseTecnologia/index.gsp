
<%@ page import="br.ufscar.sead.loa.santograu.remar.FaseTecnologia" %>
<!DOCTYPE html>
<html>
	<head>
        <meta name="layout" content="main">
        <title>Fase Tecnologia</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<script type="text/javascript" src="/santograu/js/faseTecnologia.js"></script>
        <g:javascript src="iframeResizer.contentWindow.min.js"/>
		<script type="text/javascript">//<![CDATA[
		window.onload=function(){
			$(document).ready(function() {
				$('select').material_select();
			});
		}//]]>

		</script>
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Customização - Fase Tecnologia
			</p>
		</div>
		<div id="list-faseTecnologia" class="content scaffold-list row" role="main">
			<g:form url="[resource:faseTecnologiaInstance, action:'save']" >
				<div class="form" id="myForm" >
					<g:render template="form"/>
				</div>
				<div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:20px">
					<input id="btnSave" type="submit" class="btn btn-success btn-lg my-orange" value="Enviar" onclick="_submit()"/>
				</div>
			</g:form>
		</div>
	</body>
</html>
