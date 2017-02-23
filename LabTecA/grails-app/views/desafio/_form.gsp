<%@ page import="br.ufscar.sead.loa.labteca.remar.Desafio" %>


<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'composto', 'error')} required">
	<label for="composto">
		<g:message code="desafio.composto.label" default="Composto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="composto" name="composto.id" from="${br.ufscar.sead.loa.labteca.remar.Composto.list()}" optionKey="id" required=""
			  value="${desafioInstance?.composto?.id}"
			  class="many-to-one"
			  noSelection="${['null':'Selecione um...']}"/>

</div>



<ul class="collapsible" data-collapsible="accordion" id="staggered-test" style="display: none">

	<!-- DESAFIO 1 :: TIPO DE COMPOSTO -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header"><i class="material-icons">mode_edit</i>Desafio 1</div>
		<div class="collapsible-body">
			<g:each status="i" in="${tiposCompostoList}" var="tipo">
				<div class="tipo-composto-radio">
					<input name="group1" type="radio" id="tipo${i}" disabled="disabled"/>
					<label for="tipo${i}">${tipo}</label>
				</div>
			</g:each>
		</div>
	</li>

	<!-- DESAFIO 2 :: NOME/FÓRMULA DE COMPOSTO -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header"><i class="material-icons">mode_edit</i>Desafio 2</div>
		<div class="collapsible-body">
			<div class="row">
				<div class="input-field col s6">
					<input id="composto-formula" type="text" disabled="disabled">
					<label for="composto-formula">Fórmula</label>
				</div>
				<div class="input-field col s6">
					<input id="composto-nome" type="text" disabled="disabled">
					<label for="composto-nome">Nome do Composto</label>
				</div>
			</div>
		</div>
	</li>

	<!-- DESAFIO 3 :: VOLUME E MOLARIDADE INICIAIS -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header"><i class="material-icons">mode_edit</i>Desafio 3</div>
		<div class="collapsible-body">
			<!-- VOLUME INICIAL -->
			<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'volInicial', 'error')} required">
				<label for="volInicial">
					<g:message code="desafio.volInicial.label" default="Vol Inicial" />
					<span class="required-indicator">*</span>
				</label>
				<g:field name="volInicial" value="${fieldValue(bean: desafioInstance, field: 'volInicial')}" required=""/>

			</div>

			<!-- MOLARIDADE INICIAL -->
			<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'molInicial', 'error')} required">
				<label for="molInicial">
					<g:message code="desafio.molInicial.label" default="Mol Inicial" />
					<span class="required-indicator">*</span>
				</label>
				<g:field name="molInicial" value="${fieldValue(bean: desafioInstance, field: 'molInicial')}" required=""/>
			</div>
		</div>
	</li>

	<!-- DESAFIO 4 :: VOLUME E MOLARIDADE EXPERIMENTAIS -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header"><i class="material-icons">mode_edit</i>Desafio 4</div>
		<div class="collapsible-body">
			<!-- VOLUME FINAL -->
			<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'volFinal', 'error')} required">
				<label for="volFinal">
					<g:message code="desafio.volFinal.label" default="Vol Final" />
					<span class="required-indicator">*</span>
				</label>
				<g:field name="volFinal" value="${fieldValue(bean: desafioInstance, field: 'volFinal')}" required=""/>

			</div>

			<!-- MOLARIDADE FINAL -->
			<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'molFinal', 'error')} required">
				<label for="molFinal">
					<g:message code="desafio.molFinal.label" default="Mol Final" />
					<span class="required-indicator">*</span>
				</label>
				<g:field name="molFinal" value="${fieldValue(bean: desafioInstance, field: 'molFinal')}" required=""/>

			</div>
		</div>
	</li>
</ul>


