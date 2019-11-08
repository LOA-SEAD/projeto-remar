<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'tile.label', default: 'tile')}" />
</head>

<body>
	<div class="cluster-header">
		<h4><g:message code="tile.create.title"/></h4>
		<div class="divider"></div>
	</div>

    <div class="row show">
        <g:if test="${flash.error?.not_image_file_a}">
            <div class="error-box">
                <i class="material-icons tiny">error</i>
                O arquivo escolhido para a peça A não é uma imagem. Por favor, escolha um arquivo de imagem.
            </div>
        </g:if>

        <g:if test="${flash.error?.not_image_file_b}">
            <div class="error-box">
                <i class="material-icons tiny">error</i>
                O arquivo escolhido para a peça B não é uma imagem. Por favor, escolha um arquivo de imagem.
            </div>
        </g:if>

    </div>

	<div class="row">
		<g:form class="col s12 sendForm" controller="tile" action="save" enctype="multipart/form-data">
			<g:render template="form"/>
		</g:form>
	</div>



<g:javascript src="recording.js"/>
<g:javascript src="tile.js"/>
<script src="https://cdn.rawgit.com/mattdiamond/Recorderjs/08e7abd9/dist/recorder.js"></script>


</body>
</html>
