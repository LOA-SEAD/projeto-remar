<%@ page import="br.ufscar.sead.loa.labteca.remar.Desafio" %>

<!DOCTYPE html>

<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'desafio.label', default: 'Desafio')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
	<g:external dir="css" file="desafio.css"/>

</head>

<body>

<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'composto', 'error')} required" style="overflow:auto">
	<div class="cluster-header">
		<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
			<i class="small material-icons left">grid_on</i>Customização - Desafios
		</p>
	</div>

	<div id="create-desafio" class="content scaffold-create" role="main">
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${desafioInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${desafioInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<g:form url="[resource:desafioInstance, action:'save']" >
			<fieldset class="form" style="border:none">
				<g:render template="form" except=""/>
			</fieldset>
			<!-- BOTÃO ENVIAR -->
			<fieldset class="buttons" style="border:none">
				<div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:20px">
					<button class="btn waves-effect waves-light my-orange" type="submit" name="save" class="save" id="submitButton">
						Enviar
					</button>
				</div>
			</fieldset>
			<!---->
		</g:form>
	</div>
</div>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<g:javascript src="iframeResizer.contentWindow.min.js"/>
<g:javascript src="desafio.js" />

</body>
</html>
