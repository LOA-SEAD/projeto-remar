<%@ page import="br.ufscar.sead.loa.remar.User" %>

<div class="divider">
</div>
<div class="form-group">
	<label class="label-form" for="firstName">
		<g:message code="user.name.label" default="Nome" /><span class="required-indicator">*</span>
	</label>
	<g:textField name="name" class="form-control input-form"  value="${user?.name}" />
</div>
<div id="div-email" class="form-group">
	<label class="label-form" for="firstName">
		<g:message code="user.email.label" default="Email" /><span class="required-indicator">*</span>
	</label>
	<g:field id="email" type="email" name="email" class="form-control input-form"  value="${user?.email}"  placeholder="nome@exemplo.com" />

</div>

<div id="div-username" class="form-group">

	<label class="label-form" for="username">
		<g:message code="user.username.label" default="Nome de usu&aacute;rio" /><span class="required-indicator">*</span>
	</label>
	<g:textField id="username" class="form-control input-form" name="username" required="" />

	%{--<g:if test="${source == 'update'}">--}%
	%{--<span name="username">${userInstance?.username}</span>--}%
	%{--</g:if>--}%

</div>

<div class="form-group">
	<label class="label-form" for="password">
		<g:message   code="user.password.label" default="Crie um senha" /><span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" class="form-control input-form"  />
</div>

<div class="form-group">
	<label class="label-form" for="password">
		<g:message   code="user.password.label" default="Confirme sua senha" /><span class="required-indicator">*</span>
	</label>
	<g:passwordField name="confirm_password" class="form-control input-form"  />
</div>


<div class="form-group captcha">
	<div class="g-recaptcha" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"></div>
	<g:if test='${flash.message}'>
		${flash.message}
	</g:if>
	<recaptcha:script/>
</div>

<div class="form-group">
	%{--<div class="ck-style ck-style-create">--}%
	%{--</div>--}%
	<input type="checkbox" name="agree" id="remember">

	%{--<div class="footer-span span-create">--}%
	<span class="footer-span span-create" ><label for="remember">Eu concordo com os <a>Termos e Servi&ccedil;os</a> e a
		<a>Politica de Privacidade</a> do REMAR</label></span>
	%{--</div>--}%
</div>




%{--<%@ page import="br.ufscar.sead.loa.remar.User" %>--}%

%{--<div class="divider">--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'username', 'error')} required">--}%
	%{--<label for="username">--}%
		%{--<g:message code="user.username.label" default="Username" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="username" required="" value="${user?.username}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'password', 'error')} required">--}%
	%{--<label for="password">--}%
		%{--<g:message code="user.password.label" default="Password" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="password" required="" value="${user?.password}"/>--}%

%{--</div>--}%

%{--<div class="form-group">--}%
	%{--<label class="label-form" for="firstName">--}%
		%{--<g:message code="user.name.label" default="Nome" /><span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="name" class="form-control input-form" required="" value="${userInstance?.name}" />--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'name', 'error')} required">--}%
	%{--<label for="name">--}%
		%{--<g:message code="user.name.label" default="Name" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="name" required="" value="${user?.name}"/>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'email', 'error')} required">--}%
	%{--<label for="email">--}%
		%{--<g:message code="user.email.label" default="Email" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:field type="email" name="email" required="" value="${user?.email}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'camunda_id', 'error')} ">--}%
	%{--<label for="camunda_id">--}%
		%{--<g:message code="user.camunda_id.label" default="Camundaid" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:textField name="camunda_id" value="${user?.camunda_id}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'facebookId', 'error')} ">--}%
	%{--<label for="facebookId">--}%
		%{--<g:message code="user.facebookId.label" default="Facebook Id" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:textField name="facebookId" value="${user?.facebookId}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'accountExpired', 'error')} ">--}%
	%{--<label for="accountExpired">--}%
		%{--<g:message code="user.accountExpired.label" default="Account Expired" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:checkBox name="accountExpired" value="${user?.accountExpired}" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'accountLocked', 'error')} ">--}%
	%{--<label for="accountLocked">--}%
		%{--<g:message code="user.accountLocked.label" default="Account Locked" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:checkBox name="accountLocked" value="${user?.accountLocked}" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'enabled', 'error')} ">--}%
	%{--<label for="enabled">--}%
		%{--<g:message code="user.enabled.label" default="Enabled" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:checkBox name="enabled" value="${user?.enabled}" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: user, field: 'passwordExpired', 'error')} ">--}%
	%{--<label for="passwordExpired">--}%
		%{--<g:message code="user.passwordExpired.label" default="Password Expired" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:checkBox name="passwordExpired" value="${user?.passwordExpired}" />--}%

%{--</div>--}%

