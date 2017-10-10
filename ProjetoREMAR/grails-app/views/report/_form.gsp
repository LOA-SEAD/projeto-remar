<%@ page import="br.ufscar.sead.loa.remar.Report" %>

<g:set var="report" value="${new Report()}"/>

<div class="fsm">
	<div id="s1" class="fsm-state fsm-initial" data-state="1" data-evaluator="fsmEval">
		<g:each var="type" in="${report.constraints.type.inList}">
			<div class="row">
				<div class="col s12">
					<a href="#!" class="report-fsm-next"><g:message code="report.type.${type}"/></a>
					<br/>
					<label><g:message code="report.type.${type}.description"/></label>
				</div>
			</div>
		</g:each>
	</div>

	<div id="s2" class="fsm-state" data-state="2" data-evaluator="fsmEval">
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

<g:javascript>
	$(document).ready(function() {
	    $('#type-select').material_select();
	});
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
</g:javascript>