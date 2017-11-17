
<%@ page import="br.ufscar.sead.loa.demo.remar.Phrase" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'phrase.label', default: 'Phrase')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-phrase" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="generalTable">
			<thead>
					<tr>
						<th><input type="checkbox" class="filled-in interno" id="checkAll" /><label for="checkAll"></label></th>
						<th>Frase</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${phraseInstanceList}" status="i" var="phraseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}" data-id="${phraseInstance.id}">
						<td><input type="checkbox" class="filled-in" id="filled-in-box-${phraseInstance.id}" /><label for="filled-in-box-${phraseInstance.id}"></label></td>
						<td><g:link action="show" id="${phraseInstance.id}">${fieldValue(bean: phraseInstance, field: "content")}</g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>

			<a class="waves-effect waves-light btn" id="save">Enviar</a>

			<div class="pagination">
				<g:paginate total="${phraseInstanceCount ?: 0}" />
			</div>
		</div>

	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>

	<script>
        $("#checkAll").click(function(){
            $('input:checkbox').not(this).prop('checked', this.checked);
        });

        $('#save').click(function(){
            var params = "";

            var trs = $("#generalTable").children('tbody').children('tr');

            $('input:checkbox:checked').each(function() {
                params += $(this).closest("tr").attr('data-id') + ',';
            });

            if(params.length) {
                params = params.substr(0, params.length -1);
                window.top.location.href = "/demo/phrase/toJson/" + params;
            }
            else{
				alert("Selecione pelo menos uma para enviar")
            }

        });
	</script>
	</body>
</html>
