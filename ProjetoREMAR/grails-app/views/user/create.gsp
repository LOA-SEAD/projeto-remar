<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title>Cadastro REMAR</title>

		<link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
	</head>
	<body>
	<header class="row">
		<div class="col-md-12">
			<h1>logo</h1>
		</div>
	</header>
	<article class="row">
		<div class="col-md-12">
			<section>
				<h3 class="">Criar um cadastro</h3>
			</section>
			<section>
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>

				<g:hasErrors bean="${userInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${userInstance}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
				</g:hasErrors>

				<g:form url="[resource:userInstance, action:'save']" >
					<g:hiddenField name="version" value="${userInstance?.version}" />
					<div>
						<g:render template="form"/>
					</div>
					<br />
					<fieldset class="buttons">
						<g:submitButton name="create" class="save btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>
			</section>
		</div>
	</article>
	<footer class="row">
		<div class="col-md-12">
		</div>
	</footer>

	</body>
</html>
