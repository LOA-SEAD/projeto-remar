
<%@ page import="br.ufscar.sead.loa.santograu.remar.FaseGaleria" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<g:javascript src="faseGaleria.js"/>
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<title>Em Busca do Santo Grau</title>
	</head>
	<body>
	<div class="cluster-header">
		<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
			<i class="small material-icons left"></i>Fase Galeria - Customização
		</p>
	</div>
	<div class="row">
		<form class="col s12" name="formName">
			<div class="row">
				<div class="fieldcontain required">
					<label for="orientacao">
						<g:message code="faseGaleria.orientacao.label" default="Orientação " />
						<span class="required-indicator">*</span>
					</label>
					<g:field name="orientacao" type="text" required="" length="250" maxlength="250"/>
				</div>
				<g:form method="post"  action="save" controller="faseGaleria">
				<ul class="collapsible" data-collapsible="accordion">
					<li>
						<div class="collapsible-header active"> <b>Meus Temas </b></div>
						<div class="collapsible-body">
							<g:if test="${themeFaseGaleriaInstanceList.size() < 1 }">
								<p> Você ainda não possui nenhum tema</p>
							</g:if>
							<g:else>
								<table class="" id="tableMyTheme">
									<thead>
									<tr>
										<th class="simpleTable">Selecionar</th>
										<th class="simpleTable">Imagem 1</th>
										<th class="simpleTable">Imagem 2</th>
										<th class="simpleTable">Imagem 3</th>
										<th class="simpleTable">Imagem 4</th>
										<th class="simpleTable">Imagem 5</th>
										<th class="simpleTable">Imagem 6</th>
										<th class="simpleTable">Imagem 7</th>
										<th class="simpleTable">Imagem 8</th>
										<th class="simpleTable">Imagem 9</th>
										<th class="simpleTable">Imagem 10</th>
										<th class="simpleTable">Ação</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${themeFaseGaleriaInstanceList}" status="i" var="themeFaseGaleriaInstance">
										<tr data-id="${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
											<td class="myTheme simpleTable" align="center "><input class="with-gap " name="radio" type="radio" id="myTheme${i}"
																								   value="${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}" > <label for="myTheme${i}"></label>
											</td>
											<td align="center"><img width="142"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image1.png"
																	class="img-responsive max"/></td>
											<td align="center"><img width="142"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image2.png"
																	class="img-responsive max"/></td>

											<td align="center"><img width="142"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image3.png"
																	class="img-responsive max"/></td>

											<td align="center"><img width="142"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image4.png"
																	class="img-responsive max"/></td>
											<td>.</td>
											<td>.</td>
											<td>.</td>
											<td>.</td>
											<td>.</td>
											<td>.</td>
											<td align="center"><i id="MydeleteIcon${i}" style="color: #7d8fff" class="material-icons delete">delete</i></td>
										</tr>
									</g:each>
									</tbody>
								</table>
							</g:else>
						</div>
					</li>
				</ul>
				<div class="col s12">
					<g:submitButton name="save" class="btn btn-success btn-lg my-orange" value="Enviar" onclick="_save()"/>
					<g:link class="btn btn-success btn-lg my-orange" action="create">Novo tema</g:link>
				</div>
				</g:form>

				<div id="deleteModal" class="modal">
					<div class="modal-content">
						<div id="delete-one-question">
							Você tem certeza que deseja excluir essa questão?
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()" style="margin-right: 10px;">Sim</button>
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Não</button>
					</div>
				</div>

				<div id="erroSubmitModal" class="modal">
					<div class="modal-content">
						Você deve selecionar um tema antes de enviar.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
	</body>
</html>



