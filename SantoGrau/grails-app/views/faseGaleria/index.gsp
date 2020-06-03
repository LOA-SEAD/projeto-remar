
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
				<div style="margin-top:-20px; margin-bottom: 20px; color:#333333">
					Selecione ou adicione um novo tema com imagens ordenadas (o jogo será responsável por embaralhá-las) e forneça no
					campo “Orientação” uma dica. Se desejar, acesse o <a href="https://goo.gl/gfj1AQ" target="_blank">tutorial</a> para customizar essa fase.
					<center>
						<div style="margin-top:20px">
							<img src="https://files.readme.io/53ace4c-galerias_2.jpg"
								 style="width:400px;margin-right:30px"/>
							<img src="https://files.readme.io/d6bea0c-GALERIAS.jpg"
								 style="width:400px"/>
						</div>
					</center>
				</div>
				<div class="fieldcontain required">
					<label for="orientacao">
						<g:message code="faseGaleria.orientacao.label" default="Questão (dica) " />
						<span class="required-indicator">*</span>
					</label>
					<g:field name="orientacao" id="orientacao" type="text" required="" length="270" maxlength="270" class="validate" value="${orientacao}"/>
				</div>
				<ul class="collapsible" data-collapsible="accordion">
					<li>
						<div class="collapsible-header active"> <b>Meus Temas </b></div>
						<div class="collapsible-body">
							<g:if test="${themeFaseGaleriaInstanceList.size() < 1 }">
								<p> Você ainda não possui nenhum tema</p>
							</g:if>
							<g:else>
								<table class="" id="tableMyTheme" style="font-size: 13.5px;">
									<thead>
									<tr>
										<th class="simpleTable">Selecionar</th>
										<th class="simpleTable">Imagem 1</th>
										<th class="simpleTable">Imagem 2</th>
										<th class="simpleTable">Imagem 3</th>
										<th class="simpleTable">Imagem 4</th>
										<th class="simpleTable">Ação</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${themeFaseGaleriaInstanceList}" status="i" var="themeFaseGaleriaInstance">
										<tr data-id="${themeFaseGaleriaInstance.id}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
											<td class="myTheme simpleTable" align="center ">
												<input class="with-gap " name="radio" type="radio" id="myTheme${i}"
																								   value="${themeFaseGaleriaInstance.id}" > <label for="myTheme${i}"></label>
											</td>
											<td align="center"><img width="60"
																	src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image1.png"
																	class="img-responsive max"/></td>
											<td align="center"><img width="60"
																	src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image2.png"
																	class="img-responsive max"/></td>

											<td align="center"><img width="60"
																	src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image3.png"
																	class="img-responsive max"/></td>

											<td align="center"><img width="60"
																	src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image4.png"
																	class="img-responsive max"/></td>

											<g:if test="${themeFaseGaleriaInstance.howManyImages > 4}">
												<td align="center"><img width="60"
																		src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image5.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<!--td></td-->
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 5}">
												<td align="center"><img width="60"
																		src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image6.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<!--td></td-->
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 6}">
												<td align="center"><img width="60"
																		src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image7.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<!--td></td-->
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 7}">
												<td align="center"><img width="60"
																		src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image8.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<!--td></td-->
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 8}">
												<td align="center"><img width="60"
																		src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image9.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<!--td></td-->
											</g:else>
											<g:if test="${themeFaseGaleriaInstance.howManyImages > 9}">
												<td align="center"><img width="60"
																		src="/santograu/data/${themeFaseGaleriaInstance.ownerId}/themes/${themeFaseGaleriaInstance.id}/image10.png"
																		class="img-responsive max"/></td>
											</g:if>
											<g:else>
												<!--td></td-->
											</g:else>
											<td align="center"><i id="MydeleteIcon${i}" style="color: #7d8fff; cursor:pointer" class="material-icons delete">delete</i></td>
										</tr>
									</g:each>
									</tbody>
								</table>
							</g:else>
						</div>
					</li>
				</ul>
				<div class="col s12">
					<g:submitButton name="save" class="save btn btn-success btn-lg my-orange" value="Enviar"/>
					<g:link class="btn btn-success btn-lg my-orange myLink" action="create">Novo tema</g:link>
				</div>

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



