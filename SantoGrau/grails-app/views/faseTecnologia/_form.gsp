<%@ page import="br.ufscar.sead.loa.santograu.remar.FaseTecnologia" %>



<div class="fieldcontain ${hasErrors(bean: faseTecnologiaInstance, field: 'link', 'error')} required">
	<label for="link">
		<g:message code="faseTecnologia.link.label" default="Link: " />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="link" required="" value="${faseTecnologiaInstance?.link}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseTecnologiaInstance, field: 'tipoLink', 'error')} required">
	<label for="tipoLink">
		<g:message code="faseTecnologia.tipoLink.label" default="Tipo Link: " />
		<span class="required-indicator">*</span>
	</label>
	<div class="input-field col s12">
		<div class="input-field col s6">
			<select>
				<g:if test="${faseTecnologiaInstance.constraints.tipoLink.inList.size() > 0}">
					<g:each in="${faseTecnologiaInstance.constraints.tipoLink.inList}" var="tipoLink">
						<option class="option" value="${tipoLink}">${tipoLink}</option>
					</g:each>
				</g:if>
			</select>
		</div>
		<!--g:select name="tipoLink" from="${faseTecnologiaInstance.constraints.tipoLink.inList}" required="" value="${faseTecnologiaInstance?.tipoLink}" valueMessagePrefix="faseTecnologia.tipoLink"/>
		-->
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: faseTecnologiaInstance, field: 'palavras1', 'error')} required">
	<label for="palavras1">
		<g:message code="faseTecnologia.palavras1.label" default="Palavra 1: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="palavras1" type="text" value="${faseTecnologiaInstance.palavras[0]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseTecnologiaInstance, field: 'palavras2', 'error')} required">
	<label for="palavras2">
		<g:message code="faseTecnologia.palavras2.label" default="Palavra 2: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="palavras2" type="text" value="${faseTecnologiaInstance.palavras[1]}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseTecnologiaInstance, field: 'palavras3', 'error')} required">
	<label for="palavras3">
		<g:message code="faseTecnologia.palavras3.label" default="Palavra 3: " />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="palavras3" type="text" value="${faseTecnologiaInstance.palavras[2]}" required=""/>
</div>

