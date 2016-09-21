
<%@ page import="br.ufscar.sead.loa.santograu.remar.FaseGaleria" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
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
		<div id="myForm" class="col s12" enctype="multipart/form-data">
			<div class="row">
				<g:form controller="faseGaleria" action="save">
				<div class="fieldcontain required">
					<label for="orientacao">
						<g:message code="faseGaleria.orientacao.label" default="Orientação " />
						<span class="required-indicator">*</span>
					</label>
					<g:field name="orientacao" id="orientacao" type="text" required="" length="95" maxlength="95" class="validate"/>
				</div>
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
											<td align="center"><img width="100"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image1.png"
																	class="img-responsive max"/></td>
											<td align="center"><img width="100"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image2.png"
																	class="img-responsive max"/></td>

											<td align="center"><img width="100"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image3.png"
																	class="img-responsive max"/></td>

											<td align="center"><img width="100"
																	src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image4.png"
																	class="img-responsive max"/></td>

											<g:if test="${themeFaseGaleriaInstance.howManyImages > 4}">
												<td align="center"><img width="100"
																		src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image5.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<td></td>
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 5}">
												<td align="center"><img width="100"
																		src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image6.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<td></td>
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 6}">
												<td align="center"><img width="100"
																		src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image7.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<td></td>
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 7}">
												<td align="center"><img width="100"
																		src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image8.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<td></td>
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 8}">
												<td align="center"><img width="100"
																		src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image9.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<td></td>
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 9}">
												<td align="center"><img width="100"
																		src="/santograu/data/${fieldValue(bean: themeFaseGaleriaInstance, field: "ownerId")}/themes/${fieldValue(bean: themeFaseGaleriaInstance, field: "id")}/image10.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<td></td>
											</g:else>
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
					<input id="save" type="submit" class="btn btn-success btn-lg my-orange" value="Enviar"/>
					<g:link class="btn btn-success btn-lg my-orange" action="create">Novo tema</g:link>
				</div>
				</g:form>

				<div id="deleteModal" class="modal">
					<div class="modal-content">
						<div id="delete-one-question">
							Você tem certeza que deseja excluir esse tema?
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()" style="margin-right: 10px;">Sim</button>
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Não</button>
					</div>
				</div>

				<div id="erroSubmitModal" class="modal">
					<div class="modal-content">
						Você deve escrever uma orientação e selecionar um tema antes de enviar.
					</div>
					<div class="modal-footer">
						<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>



