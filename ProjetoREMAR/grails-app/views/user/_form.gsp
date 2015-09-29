<%@ page import="br.ufscar.sead.loa.remar.User" %>

%{--<div class="divider">--}%
%{--</div>--}%

<div class="form-group has-feedback">
	<input type="text" class="form-control-remar" placeholder="Primeiro nome" value=""  name="firstName" />
	<span class="glyphicon glyphicon-edit form-control-feedback"></span>
</div>

<div class="form-group has-feedback">
	<input type="text" class="form-control-remar" placeholder="Sobrenome" value=""  name="lastName" />
	<span class="glyphicon glyphicon-edit form-control-feedback"></span>
</div>

<div id="div-email" class="form-group has-feedback">
	<input type="email" class="form-control-remar" placeholder="Email" value="${user?.email}"  name="email"  id="email"/>
	<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
</div>

<div id="div-username" class="form-group has-feedback">
	<input type="text" class="form-control-remar" placeholder="Nome de usuário" name="username" id="username" />
	<span class="glyphicon glyphicon-user form-control-feedback"></span>
</div>

<div class="form-group has-feedback">
	<input type="password" class="form-control-remar" placeholder="Crie uma senha" name="password" id="password" />
	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
</div>

<div class="form-group has-feedback">
	<input type="password" class="form-control-remar" placeholder="Confirme sua senha" name="confirm_password">
	<span class="glyphicon glyphicon-log-in form-control-feedback"></span>
</div>


<div class="form-group has-feedback ">
	<span class="control-label" style="margin-right: 15px;">Sexo:</span>
	<input type="radio" name="gender" value="female" checked>
	<span class="control-label" style="margin-right: 15px;">Feminino</span>
	<input type="radio" name="gender" value="male" >
	<span class="control-label" style="margin-right: 15px;">Masculino</span>
</div>

<div class="form-group container-fluid">
	<div class="g-recaptcha" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"> </div>
	<g:if test='${flash.message}'>
		${flash.message}
	</g:if>
	<recaptcha:script/>
</div>



<div class="form-group has-feedback">
	<input type="checkbox" name="agree" id="remember">
	<span class="control-label">Eu concordo com os <a>Termos e privacidade</a> do remar.</span>
</div>




<!--
<div class="form-group">
	%{--<div class="ck-style ck-style-create">--}%
	%{--</div>--}%
	<input type="checkbox" name="agree" id="remember">

	%{--<div class="footer-span span-create">--}%
	<span class="footer-span span-create" ><label for="remember">Eu concordo com os <a>Termos e Servi&ccedil;os</a> e a
		<a>Politica de Privacidade</a> do REMAR</label></span>
	%{--</div>--}%
</div>
-->