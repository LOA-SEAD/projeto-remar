<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:javascript src="imagePreview.js"/>
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<title>Em Busca do Santo Grau</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	</head>
	<body>
	<g:form id="myForm" url="[action:'ImagesManager']"  enctype="multipart/form-data">
		<div class="form" style="margin-bottom:80px">

			<div class="cluster-header">
				<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
					<i class="small material-icons left"></i>Fase Galeria - Upload de imagens
				</p>
			</div>

			<g:uploadForm  method="POST" controller="design" action="imagesManager">
				<input type="hidden" id="orientacao" name="orientacao" value="${orientacao}">
				<div class="row">
					<div class="col s12">
						<ul class="collapsible" data-collapsible="accordion">
							<li>
								<div class="collapsible-header active"><i class="material-icons">info</i>Informação sobre a ordem das imagens</div>
								<div class="collapsible-body">
									<p class="justify-text">As imagens devem ser inseridas na ordem correta da resolução do desafio.</p>
								</div>
							</li>
						</ul>

						<ul class="collapsible" data-collapsible="accordion">
							<li>
								<div class="collapsible-header active"><i class="material-icons">file_upload</i>Upload</div>
								<div class="collapsible-body">
									<table style="overflow: scroll;" class="centered" id="tableNewTheme">
										<thead>
										<tr>
											<th>Nome da Imagem</th>
											<th>Preview da Imagem</th>
											<th>Arquivo</th>
											<th>Ação</th>
										</tr>
										</thead>
										<tbody>
										<tr>
											<td>Imagem 1</td>
											<td>
												<div class="row" style="height: 200px;">
													<img id="img-1-preview" height="200" />
												</div>
											</td>
											<td id="file-input-1">
												<div class="file-field input-field">
													<div class="btn right">
														<span>File</span>
														<input data-image="true" type="file" name="img-1" id="img-1" class="image-input" accept="image/png">
													</div>
													<div class="file-path-wrapper">
														<input class="file-path validate" type="text" placeholder="Imagem PNG (160x200px)">
													</div>
												</div>
											</td>
											<td>
												<i id="delete-1" style='color: #7d8fff !important; margin-right:10px; cursor:pointer' class='fa fa-trash-o' onclick='deleteSelectedImage(this)'></i>
											</td>
										</tr>
										<tr>
											<td>Imagem 2</td>
											<td>
												<div class="row" style="height: 200px;">
													<img id="img-2-preview" height="200"/>
												</div>
											</td>
											<td id="file-input-2">
												<div class="file-field input-field">
													<div class="btn right">
														<span>File</span>
														<input data-image="true" type="file" name="img-2" id="img-2" class="image-input" accept="image/png">
													</div>
													<div class="file-path-wrapper">
														<input class="file-path validate" type="text" placeholder="Imagem PNG (160x200px)">
													</div>
												</div>
											</td>
											<td>
												<i id="delete-2" style='color: #7d8fff !important; margin-right:10px; cursor:pointer' class='fa fa-trash-o' onclick='deleteSelectedImage(this)'></i>
											</td>
										</tr>
										<tr>
											<td>Imagem 3</td>
											<td>
												<div class="row" style="height: 200px;">
													<img id="img-3-preview" height="200"/>
												</div>
											</td>
											<td id="file-input-3">
												<div class="file-field input-field">
													<div class="btn right">
														<span>File</span>
														<input data-image="true" type="file" name="img-3" id="img-3" class="image-input" accept="image/png">
													</div>
													<div class="file-path-wrapper">
														<input class="file-path validate" type="text" placeholder="Imagem PNG (160x200px)">
													</div>
												</div>
											</td>
											<td>
												<i id="delete-3" style='color: #7d8fff !important; margin-right:10px; cursor:pointer' class='fa fa-trash-o' onclick='deleteSelectedImage(this)'></i>
											</td>
										</tr>
										<tr>
											<td>Imagem 4</td>
											<td>
												<div class="row" style="height: 200px;">
													<img id="img-4-preview" height="200"/>
												</div>
											</td>
											<td id="file-input-4">
												<div class="file-field input-field">
													<div class="btn right">
														<span>File</span>
														<input data-image="true" type="file" name="img-4" id="img-4" class="image-input" accept="image/png">
													</div>
													<div class="file-path-wrapper">
														<input class="file-path validate" type="text" placeholder="Imagem PNG (160x200px)">
													</div>
												</div>
											</td>
											<td>
												<i id="delete-4" style='color: #7d8fff !important; margin-right:10px; cursor:pointer' class='fa fa-trash-o' onclick='deleteSelectedImage(this)'></i>
											</td>
										</tr>
										</tbody>
									</table>
									<div class="row">
										<div class="col s1 m1 l1 offset-s11 offset-m11 offset-l11">
											<a name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Adicionar mais imagens">
												<i class="material-icons" onclick="addImage()">add</i></a>
										</div>
									</div>
								</div>
							</li>
							

						</ul>
					</div>
				</div>

				<div class="row">
					<div class="col s12">
					</div>
				</div>
			</g:uploadForm>
			<input id="upload" type="submit" name="upload" class="btn btn-success my-orange" value="Criar"/>
			<input id="cancel" type="button" name="cancel" class="btn my-orange" value="Cancelar"/>
		</div>
	</g:form>

	<div id="limitOfImagesModal" class="modal">
		<div class="modal-content">
			Você só pode criar um tema com até 10 imagens.
		</div>
		<div class="modal-footer">
			<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
		</div>
	</div>

	<div id="fileTypeErrorModal" class="modal">
		<div class="modal-content">
			Você só pode usar imagens cuja extensão seja .png
		</div>
		<div class="modal-footer">
			<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
		</div>
	</div>

	<div id="selectFourImagesModal" class="modal">
		<div class="modal-content">
			Você deve selecionar pelo menos 4 imagens.
		</div>
		<div class="modal-footer">
			<button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
		</div>
	</div>
	</body>
</html>
