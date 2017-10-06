<%@ page import="br.ufscar.sead.loa.remar.Report" %>

<g:set var="report" value="${new Report()}"/>

<div class="fsm">
	<div class="fsm-state fsm-initial" data-state="1" data-evaluator="fsmEval">
		<select id="type-select" name="type-select">
			<g:each var="type" in="${report.constraints.type.inList}">
				<option value="${it}"><g:message code="report.type.${type}"/></option>
			</g:each>
		</select>
	</div>

	<div class="fsm-state" data-state="2" data-evaluator="fsmEval">
		<div class="fieldcontain ${hasErrors(bean: report, field: 'description', 'error')} required">
			<label for="description">
				<g:message code="report.description.label" default="Description" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField name="description" required="" value="${report?.description}"/>
		</div>
	</div>

	<div class="fsm-state" data-state="3" data-evaluator="fsmEval">

	</div>

	<div class="fsm-state fsm-final" data-state="4" data-evaluator="fsmEval">

	</div>

<script>
	function fsmEval() {
	    // 1 - Type select
		// 2 - Description
		// 3 - Screenshot
		// 4 - Finish
		switch ($('.fsm').getCurrentState().data('state')) {
			case 1:
			    return 2;
			case 2:
                if ($('#type-select').val() == 1)
                    return 4;
                else
                    return 3;
			case 3:
				return 4;
		}
	}
</script>