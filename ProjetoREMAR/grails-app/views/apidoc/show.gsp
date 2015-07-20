<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Api Docs</title>

	</head>

	<body style="color: #393939;font: 13px/1.4em helvetica,arial,freesans,clean,sans-serif;">

		<div id="show-apidocs" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
		</div>
		
		<div style="margin-left: auto; margin-right: auto;width: 800px;">

		<g:each in="${apiList}" var="a">
			<br>
			<h3>${a.parent}</h3>

			<g:each status="i" in="${a.api}" var="api">
			<br>
			${api.description}
			<div style="display: table;border: 1px solid #c5c5c5;">
			 <div>
			   <span style="display: table-row; background-color:#ddd">
				   <span style="display: table-cell;width: 200px;padding-left: 10px;border: 1px #d7ad7b;">${api.method}</span>
				   <span style="display: table-cell;width: 200px;padding-left: 10px;border: 1px #d7ad7b;">${api.path}</span>
			 	</span>
			 </div>
			</div>
			<br>
			<b>JSON</b>
			<div>${a.json[i]}</div>
			<br>
			<g:if test="${api.values.size()>0}">
			<b>Params</b>
			<div style="display: table;border: 1px solid #c5c5c5;">

				<div style="display: table-row; background-color:#b4b8be;color:#fff;">
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Type</b></span>
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Name</b></span>
				   <span style="display: table-cell;width: 250px;padding-left: 10px;border: 1px #d7ad7b;"><b>Description</b></span>
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Required</b></span>
				    <span style="display: table-cell;width: 250px;padding-left: 10px;border: 1px #d7ad7b;"><b>Params</b></span>
				</div>
				<g:each in="${api.values}" var="value">
					<div style="display: table-row">
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${value.type}</span>
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${value.name}</span>
					   <span style="display: table-cell;width: 250px;padding-left: 10px;border: 1px #d7ad7b;">${value.description}</span>
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${value.required}</span>
					    <span style="display: table-cell;width: 250px;padding-left: 10px;border: 1px #d7ad7b;">[]</span>
				    </div>
				 </g:each>

			 </div>
			 </g:if>
			 
			<b>Definitions</b>
			<div style="display: table;border: 1px solid #c5c5c5;">
				<div style="display: table-row; background-color:#b4b8be;color:#fff;">
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Type</b></span>
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Name</b></span>
				   <span style="display: table-cell;width: 250px;padding-left: 10px;border: 1px #d7ad7b;"><b>Description</b></span>
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Required</b></span>
				</div>
				<g:each in="${api.returns}" var="rturn">
					<div style="display: table-row">
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${rturn.type}</span>
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${rturn.name}</span>
					   <span style="display: table-cell;width: 250px;padding-left: 10px;border: 1px #d7ad7b;">${rturn.description}</span>
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${rturn.required}</span>
				    </div>
				 </g:each>
			 </div>
			 
			<g:if test="${api.errors.size()>0}">
			<b>Errors</b>
			<div style="display: table;border: 1px solid #c5c5c5;">
				<div style="display: table-row; background-color:#b4b8be;color:#fff;">
				   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;"><b>Code</b></span>
				   <span style="display: table-cell;width: 700px;padding-left: 10px;border: 1px #d7ad7b;"><b>Description</b></span>
				</div>
				<g:each in="${api.errors}" var="error">
					<div style="display: table-row">
					   <span style="display: table-cell;width: 100px;padding-left: 10px;border: 1px #d7ad7b;">${error.code}</span>
					   <span style="display: table-cell;width: 700px;padding-left: 10px;border: 1px #d7ad7b;">${error.description}</span>
				    </div>
				 </g:each>
			 </div>
			</g:if>
			
			</g:each>

		</g:each>
		
		</div>

	</body>
</html>