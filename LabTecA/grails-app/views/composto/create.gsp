<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'composto.label', default: 'Composto')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>

	<body>
		<div id="create-composto" class="content scaffold-create" role="main">
			<div class="cluster-header">
				<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
					<i class="small material-icons left">grid_on</i>Criação de Composto
				</p>
			</div>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${compostoInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${compostoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:compostoInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons" style="border:none">
					<div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:0px">
						<button class="btn waves-effect waves-light my-orange" type="submit" name="save" class="save" id="submitButton">
							Criar
						</button>
					</div>
				</fieldset>
			</g:form>
		</div>

	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<g:javascript src="desafio.js" />
	</body>
</html>
