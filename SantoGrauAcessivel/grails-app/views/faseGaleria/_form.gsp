<%@ page import="br.ufscar.sead.loa.santograuacessivel.remar.FaseGaleria" %>



<div class="fieldcontain ${hasErrors(bean: faseGaleriaInstance, field: 'orientacao', 'error')} required">
	<label for="orientacao">
		<g:message code="faseGaleria.orientacao.label" default="Orientacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="orientacao" required="" value="${faseGaleriaInstance?.orientacao}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseGaleriaInstance, field: 'ownerId', 'error')} required">
	<label for="ownerId">
		<g:message code="faseGaleria.ownerId.label" default="Owner Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ownerId" type="number" value="${faseGaleriaInstance.ownerId}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: faseGaleriaInstance, field: 'taskId', 'error')} ">
	<label for="taskId">
		<g:message code="faseGaleria.taskId.label" default="Task Id" />
		
	</label>
	<g:textField name="taskId" value="${faseGaleriaInstance?.taskId}"/>

</div>

