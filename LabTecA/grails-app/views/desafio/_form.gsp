<%@ page import="br.ufscar.sead.loa.labteca.remar.Desafio" %>


<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'composto', 'error')} required">
	<div class="row">
		<div class="input-field col s6">
			<select required id="composto" name="composto.id">
				<option value="" disabled selected>Selecione um...</option>
				<g:each in="${br.ufscar.sead.loa.labteca.remar.Composto.list()}" var="composto">
					<option value="${composto.id}">${composto}</option>
				</g:each>
			</select>

			<label for="composto">
				<g:message code="desafio.composto.label" default="Composto" />
				<span class="required-indicator">*</span>
			</label>
		</div>
	</div>
</div>

<ul class="collapsible" data-collapsible="accordion" id="staggered-test" style="display: none">

	<!-- DESAFIO 1 :: TIPO DE COMPOSTO -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header">
			<div class="row">
				<div class="col s6">
					<i class="material-icons">mode_edit</i>Desafio 1
				</div>
				<!-- Modal Trigger -->
				<div class="col s6">
					<a class="modal-trigger" href="#desafio1-modal">
						<i class="waves-effect waves-light material-icons button-icon">info_outline</i>
					</a>
				</div>
			</div>
		</div>

		<div class="collapsible-body">
			<div class="row">
				<div class="input-field s6">
					<g:each status="i" in="${tiposCompostoList}" var="tipo">
						<div class="col">
							<input disabled name="group1" type="radio" id="tipo${i}"/>
							<label for="tipo${i}">${tipo}</label>
						</div>
					</g:each>

					<label class="active" style="color: rgba(0, 0, 0, 0.26);">
						<g:message code="composto.tipo.label" default="Tipo do Composto" />
					</label>
				</div>
			</div>
		</div>
	</li>

	<!-- DESAFIO 2 :: NOME/FÓRMULA DE COMPOSTO -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header">
			<div class="row">
				<div class="col s6">
					<i class="material-icons">mode_edit</i>Desafio 2
				</div>
				<!-- Modal Trigger -->
				<div class="col s6">
					<a class="modal-trigger" href="#desafio2-modal">
						<i class="waves-effect waves-light material-icons button-icon">info_outline</i>
					</a>
				</div>
			</div>
		</div>

		<div class="collapsible-body">
			<div class="row">
				<!-- Fórmula -->
				<div class="input-field col s6">
					<input disabled id="composto-formula" type="text" class="validate">
					<label id="composto-formula-label" for="composto-formula">Fórmula</label>
				</div>
				<!-- Nome -->
				<div class="input-field col s6">
					<input disabled id="composto-nome" type="text" class="validate">
					<label id="composto-nome-label" for="composto-nome">Nome do Composto</label>
				</div>
			</div>
		</div>
	</li>

	<!-- DESAFIO 3 (OCULTO) :: VOLUME E MOLARIDADE INICIAIS -->
	<li style="transform: translateX(0px); opacity: 0; display:none">
		<div class="collapsible-header">
			<div class="row">
				<div class="col s6">
					<i class="material-icons">mode_edit</i>Desafio 3
				</div>
				<!-- Modal Trigger -->
				<div class="col s6">
					<a class="modal-trigger" href="#desafio3-modal">
						<i class="waves-effect waves-light material-icons button-icon">info_outline</i>
					</a>
				</div>
			</div>
		</div>

		<div class="collapsible-body">
			<div class="row">

				<!-- Volume Inicial -->
				<div class="input-field col s6">
					<input disabled readonly id="volume-inicial" type="number" class="validate">
					<label for="volume-inicial">
						<g:message code="desafio.volInicial.label" default="Volume Inicial" />
					</label>
				</div>

				<!-- Molaridade Inicial -->
				<div class="input-field col s6">
					<input id="molaridade-inicial" type="number" class="validate">
					<label for="molaridade-inicial">
						<g:message code="desafio.molInicial.label" default="Molaridade Inicial" />
						<span class="required-indicator">*</span>
					</label>
				</div>
			</div>
		</div>
	</li>

	<!-- DESAFIO 3 (4) :: VOLUME E MOLARIDADE EXPERIMENTAIS -->
	<li style="transform: translateX(0px); opacity: 0;">
		<div class="collapsible-header">
			<div class="row">
				<div class="col s6">
					<i class="material-icons">mode_edit</i>Desafio 3
				</div>
				<!-- Modal Trigger -->
				<div class="col s6">
					<a class="modal-trigger" href="#desafio4-modal">
						<i class="waves-effect waves-light material-icons button-icon">info_outline</i>
					</a>
				</div>
			</div>
		</div>

		<div class="collapsible-body">
			<div class="row">
				<!-- Volume Final -->
				<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'volFinal', 'error')} required input-field col s6">
					<input id="volume-final" type="number" class="validate">
					<label class="active" for="volume-final">
						<g:message code="desafio.volInicial.label" default="Volume" />
						<span class="required-indicator">*</span>
					</label>
				</div>

				<!-- Molaridade Final -->
				<div class="fieldcontain ${hasErrors(bean: desafioInstance, field: 'molFinal', 'error')} required input-field col s6">
					<input id="molaridade-final" type="number" class="validate">
					<label class="active" for="molaridade-final">
						<g:message code="desafio.molFinal.label" default="Molaridade" />
						<span class="required-indicator">*</span>
					</label>
				</div>
			</div>
		</div>
	</li>
</ul>

<!-- Botão Enviar -->
<div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:20px">
	<button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="submitButton">
		Enviar
	</button>
</div>

<!-- Conteúdos dos Modals -->
<!-- Modal Desafio 1 -->
<div id="desafio1-modal" class="modal">
	<div class="modal-content">
		<h4>Desafio 1</h4>
		<p>Nesse desafio, o jogador deve descobrir qual a classe do composto. O desafio não é editável pois a classe é resgatada automaticamente de nosso banco de dados, basta escolher o composto!</p>
	</div>
	<div class="modal-footer col s1 m1 l1 offset-s8 offset-m10 offset-l10">
		<a href="#!" class=" btn modal-close waves-effect waves-light my-orange">OK</a>
	</div>
</div>

<!-- Modal Desafio 2 -->
<div id="desafio2-modal" class="modal">
	<div class="modal-content">
		<h4>Desafio 2</h4>
		<p>Nesse desafio, o jogador deve descobrir qual o composto, dizendo o nome e a fórmula dele. O desafio não é editável pois essas informações são resgatadas automaticamente de nosso banco de dados, basta escolher o composto!</p>
	</div>
	<div class="modal-footer col s1 m1 l1 offset-s8 offset-m10 offset-l10">
		<a href="#!" class=" btn modal-close waves-effect waves-light my-orange">OK</a>
	</div>
</div>

<!-- Modal Desafio 3 (OCULTO) -->
<div id="desafio3-modal" class="modal">
	<div class="modal-content">
		<h4>Desafio 3</h4>
		<p>A bunch of text</p>
	</div>
	<div class="modal-footer col s1 m1 l1 offset-s8 offset-m10 offset-l10">
		<a href="#!" class=" btn modal-close waves-effect waves-light my-orange">OK</a>
	</div>
</div>

<!-- Modal Desafio 4 (3) -->
<div id="desafio4-modal" class="modal">
	<div class="modal-content">
		<h4>Desafio 3</h4>
		<p>Nesse desafio, o jogador deve alterar a solução para atender as especificações inseridas (volume mínimo e molaridade).</p>
	</div>
	<div class="modal-footer col s1 m1 l1 offset-s8 offset-m10 offset-l10">
		<a href="#!" class=" btn modal-close waves-effect waves-light my-orange">OK</a>
	</div>
</div>

<!-- Modal de erro para campos não preenchidos -->
<div id="errorSubmitingModal" class="modal">
	<div class="modal-content">
		Preencha todos os campos antes de finalizar a customização.
	</div>
	<div class="modal-footer col s1 m1 l1 offset-s8 offset-m10 offset-l10">
		<a href="#!" class=" btn modal-close waves-effect waves-light my-orange">OK</a>
	</div>
</div>

