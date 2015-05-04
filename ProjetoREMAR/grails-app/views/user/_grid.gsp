<table class="ajax">
	<thead>
		<tr>
			<th>Username</th>
			<th>Name</th>
			<th>Email</th>
			<th>Camunda ID</th>
			<th>Roles</th>
		</tr>
	</thead>
	<tbody>
		<g:each in="${userInstanceList}" status="i" var="userInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}" onclick='window.location = "${createLink(action: "show", id: userInstance.id)}"'>
				<td>${fieldValue(bean: userInstance, field: "username")}</td>
			
				<td>${fieldValue(bean: userInstance, field: "name")}</td>
			
				<td>${fieldValue(bean: userInstance, field: "email")}</td>

				<td>${fieldValue(bean: userInstance, field: "camunda_id")}</td>
			
				<td>${userInstance.getRoles()}</td>
			</tr>
		</g:each>
	</tbody>
</table>