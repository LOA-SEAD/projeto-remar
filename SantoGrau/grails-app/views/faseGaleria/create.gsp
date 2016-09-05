<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<g:javascript src="imagePreview.js"/>
		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<title>Em Busca do Santo Grau</title>
	</head>
	<body>
	<div class="cluster-header">
		<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
			<i class="small material-icons left"></i>Fase Galeria - Upload de imagens
		</p>
	</div>

	<g:uploadForm controller="design" action="ImagesManager">
		<div class="row">
			<div class="col s12">
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
								</tr>
								</thead>
								<tbody>
								<tr>
									<td>Imagem 1</td>
									<td>
										<div class="row" style="height: 200px;">
											<img id="a-preview" class="door" height="200" />
										</div>
									</td>
									<td>
										<div class="file-field input-field">
											<div class="btn right">
												<span>File</span>
												<input data-image="true" type="file" name="a-1" id="a-1">
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text" placeholder="URL da imagem">
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>Imagem 2</td>
									<td>
										<div class="row" style="height: 200px;">
											<img id="b-preview" class="door" height="200"/>
										</div>
									</td>
									<td>
										<div class="file-field input-field">
											<div class="btn right">
												<span>File</span>
												<input data-image="true" type="file" name="b-1" id="b-1">
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text" placeholder="URL da imagem">
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>Imagem 3</td>
									<td>
										<div class="row" style="height: 200px;">
											<img id="c-preview" class="door" height="200"/>
										</div>
									</td>
									<td>
										<div class="file-field input-field">
											<div class="btn right">
												<span>File</span>
												<input data-image="true" type="file" name="c-1" id="c-1">
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text" placeholder="URL da imagem">
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>Imagem 4</td>
									<td>
										<div class="row" style="height: 200px;">
											<img id="d-preview" class="door" height="200"/>
										</div>
									</td>
									<td>
										<div class="file-field input-field">
											<div class="btn right">
												<span>File</span>
												<input data-image="true" type="file" name="d-1" id="d-1">
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text" placeholder="URL da imagem">
											</div>
										</div>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
					</li>
					<li>
						<div class="collapsible-header"><i class="material-icons">info</i>Informações sobre as Imagens</div>
						<div class="collapsible-body">
							<p class="justify-text">Para um melhor desempenho as imagens devem possuir as propriedades descritas na tabela abaixo.</p>
							<table class="centered">
								<thead>
								<tr>
									<th>Imagem</th>
									<th>Dimensões (pixels)</th>
									<th>Extensão</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td>Imagem 1</td>
									<td> 142x213 </td>
									<td> PNG </td>
								</tr>
								<tr>
									<td>Imagem 2</td>
									<td> 142x200 </td>
									<td> PNG </td>
								</tr>
								<tr>
									<td>Imagem 3</td>
									<td> 142x213 </td>
									<td> PNG </td>
								</tr>
								<tr>
									<td>Imagem 4</td>
									<td> 142x200 </td>
									<td> PNG </td>
								</tr>
								</tbody>
							</table>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
	<script>
		$(document).ready(function(){
			$('.collapsible').collapsible({
				accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
			});
		});
	</script>
	</body>
</html>
