<%@ page import="br.ufscar.sead.loa.remar.Deploy" %>

<div class="fieldcontain ${hasErrors(bean: deployInstance, field: 'war', 'error')} required">
	%{--<label for="war">--}%
		%{--<g:message code="deploy.war_file.label" default="WAR file:" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<span class="btn btn-default btn-file">--}%
		%{--teste<input type="file" name="war" />--}%
	%{--</span>--}%
	<div class="input-group">
		<span class="input-group-btn">
			<span class="btn btn-primary btn-file btn-flat">
				Selecionar <input name="war" type="file"  multiple >
			</span>
		</span>
		<input type="text" class="form-control" placeholder="WAR file..." readonly>
        <span class="input-group-btn">
            <button name="create" class="btn btn-primary btn-file btn-flat" >
                <i class="fa fa-upload"> </i>
            </button>
        </span>
	</div>
</div>
