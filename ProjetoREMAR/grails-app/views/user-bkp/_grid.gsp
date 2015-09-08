<table class="table table-striped table-bordered table-hover" id="user_table">
	<thead>
		<tr>
			<th>Username</th>
			<th>Name</th>
			<th>Email</th>
			<th style="min-width: 105px;">Camunda ID</th>
			<th>Roles</th>
		</tr>
	</thead>
	<tbody>
		<g:each in="${userInstanceList}" status="i" var="userInstance">
			<tr class="selectable_tr" onclick='window.location = "${createLink(action: "show", id: userInstance.id)}"'>
				<td>${fieldValue(bean: userInstance, field: "username")}</td>
			
				<td>${fieldValue(bean: userInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: userInstance, field: "email")}</td>

				<td>${fieldValue(bean: userInstance, field: "camunda_id")}</td>
			
				<td>${userInstance.getRoles()}</td>
			</tr>
		</g:each>
	</tbody>
</table>