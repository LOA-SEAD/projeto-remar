<%@ page import="br.ufscar.sead.loa.remar.User" %>
<div class="divider">
</div>
<div class="form-group">
	<label class="label-form" for="firstName">
		<g:message code="user.name.label" default="Nome" /><span class="required-indicator">*</span>
	</label>
	<g:textField name="name" class="form-control input-form" required="" value="${userInstance?.name}" />
</div>
<div class="form-group">
	<label class="label-form" for="firstName">
		<g:message code="user.email.label" default="Email" /><span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" class="form-control input-form" required="" value="${userInstance?.email}"  placeholder="nome@exemplo.com" />

</div>
<div class="form-group">
	<label class="label-form" for="username">
		<g:message code="user.username.label" default="Nome de usu&aacute;rio" /><span class="required-indicator">*</span>
	</label>
	<g:if test="${source == 'create'}">
		<g:textField id="Name" class="form-control input-form" name="username" required="" value="${userInstance?.username}" />
	</g:if>
	<g:if test="${source == 'update'}">
		<span name="username">${userInstance?.username}</span>
	</g:if>
</div>

<div class="form-group">
	<label class="label-form" for="password">
		<g:message   code="user.password.label" default="Crie um senha" /><span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" class="form-control input-form" required="" />
</div>

<div class="form-group">
	<label class="label-form" for="password">
		<g:message   code="user.password.label" default="Confirme sua senha" /><span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" class="form-control input-form" required="" />
</div>


<div class="form-group captcha">
	<span class="footer-span">CAPTCHA</span>
    <div class="g-recaptcha" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"></div>${flash.message}

    <recaptcha:script/>
</div>

<div class="form-group">
	<div class="ck-style ck-style-create">
		<input type="checkbox" name="remember" id="remember">
	</div>

	<div class="footer-span span-create">
		<span><label for="remember">Eu concordo com os <a>Termos e Servi&ccedil;os</a> e a
			<a>Politica de Privacidade</a> do REMAR</label></span>
	</div>

</div>




