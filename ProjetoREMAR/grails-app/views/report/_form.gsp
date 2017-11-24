<%@ page import="br.ufscar.sead.loa.remar.Report" %>

<g:set var="report" value="${new Report()}"/>

<div id="report-form" class="fsm">
	<%-- Type of problem --%>
	<div id="s1" class="fsm-state fsm-initial" data-state="1" data-evaluator="fsmEval">
		<g:each var="type" in="${report.constraints.type.inList}">
			<div class="row">
				<p class="center">
					<input value="${type}" type="radio" id="${type}-radio"/>
					<label for="${type}-radio" class="no-padding report-fsm-next remar-orange-text">
						<g:message code="report.type.${type}"/>
					</label>
				</p>

				<label><g:message code="report.type.${type}.description"/></label>
			</div>
		</g:each>
	</div>

	<%-- Description --%>
	<div id="s2" class="fsm-state" data-state="2" data-evaluator="fsmEval">
		<div class="error-box row hide">
			<i class="material-icons tiny">error</i>
			<g:message code="report.description.error"/>
		</div>

		<div class="row no-margin">
			<div class="input-field col s12 required">
				<textarea id="report-description" class="materialize-textarea" name="description"
						  maxlength="500" data-length="500"></textarea>
				<label for="report-description">
					<g:message code="report.description.message" default="Description"/>
					<span class="required-indicator">*</span>
				</label>
			</div>
		</div>
	</div>

	<%-- Screenshot --%>
	<div id="s3" class="fsm-state" data-state="3" data-evaluator="fsmEval">
		<div class="row">
			<p class="no-margin">
				<g:message code="report.screenshot.message"/>
			</p>
		</div>

		<div class="row screenshot-preview">
			<canvas class="screenshot-preview-placeholder" width="1920" height="1080"></canvas>
		</div>

		<div class="row">
			<a id="ss-btn" class="btn">
				<g:message code="report.screenshot.button"/>
			</a>
			<input type="hidden" name="img-val" id="img-val" value=""/>
		</div>
	</div>

	<%-- Submit --%>
	<div id="s4" class="fsm-state fsm-final" data-state="4" data-evaluator="fsmEval">
		<div id="report-final-message">
			<p>
				<g:message code="report.submit.message1"/>
			</p>
			<p>
				<g:message code="report.submit.message2"/>
			</p>
			<p>
				<g:message code="report.submit.message3"/>
			</p>
		</div>

		<div id="report-loading" class="hide">
			<div class="spinner outer"
				 style="background-image: url(${resource(dir: 'images', file: 'outerspinner.png')});"></div>
			<img class="spinner inner" src="${resource(dir: 'images', file: 'innerspinner.png')}">
		</div>
	</div>
</div>

<g:javascript src="remar/report.js" />