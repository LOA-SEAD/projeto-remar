<%@ page import="br.ufscar.sead.loa.remar.Category" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="materialize-layout">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
		<title>Categorias</title>
	</head>
	<body>
	<div class="row cluster">
		<div class="cluster-header">
			<p id="title-page" class="text-teal text-darken-3 left-align margin-bottom">
				<i class="small material-icons left">list</i>Categorias
			</p>

			<div class="divider"></div>
		</div>
			<blockquote>Nesta página estão listadas as categorias disponíveis para um jogo.</blockquote>

			<div id="list-category" role="main">

				<table class="highlight" style="margin: 20px;">
					<thead>
						<tr>
							<td>Nome</td>
							<td>Ação</td>
						</tr>
					</thead>
					<tbody>
						<g:each in="${categoryList}" status="i" var="category">
							<tr class="action">
								<td class="category-name">${fieldValue(bean: category, field: "name")}</td>
								<td>
									<a href="#!" data-category-id="${category.id}" class="edit"><i class="material-icons">mode_edit</i></a>
									<a href="#!" class="delete" data-category-id="${category.id}"><i class="material-icons">delete_forever</i></a>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
				<div class="row">
					<div class="col s1 offset-s10">
						<a href="#create"  name="create"
						   class="btn-floating btn-large waves-effect waves-light my-orange tooltipped modal-trigger"
						   	data-tooltip="Criar categoria"><i class="material-icons">add</i></a>
					</div>
				</div>
			</div>
	</div>
		<!-- Modal Structure create -->
		<div id="create" class="modal">
			<div class="modal-content">
				<h4>Criar categoria</h4>
				<div class="input-field col s12">
					<input id="name" name="name" type="text" class="validate" autocomplete="off">
					<label for="name">Nome</label>
				</div>
			</div>
			<div class="modal-footer">
				<a id="save" href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Salvar</a>
			</div>
		</div>

		<!-- Modal Structure edit -->
		<div id="edit-modal" class="modal">
			<div class="modal-content">
				<h4>Editar categoria</h4>
				<div class="input-field col s12">
					<input id="edit-name" name="name" type="text" class="validate" autocomplete="off" data-category-id="">
					<label for="edit-name">Nome</label>
				</div>
			</div>
			<div class="modal-footer">
				<a id="edit-save" href="#!" data-category-id="" class=" modal-action modal-close waves-effect waves-green btn-flat">Salvar</a>
			</div>
		</div>

		<g:javascript src="category.js"/>
	</body>
</html>
