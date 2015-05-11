<!DOCTYPE html>
<html>
	<head>
        <meta name="layout" content="main">

        <g:javascript src="versions.js"/>

	</head>
	<body>
        <div id="web" class="endpoint"><h1><input type="checkbox" name="web"/>Gerar versão web</h1></div>
        <div id="apk" class="endpoint"><h1><input type="checkbox" name="apk"/>Gerar APK</h1></div>
    <fieldset class="buttons">
            <g:submitButton id="send" name="send" class="save" value="Enviar" />
            %{--<g:submitButton id="save-and-finish" name="save" class="save" value="Salvar e finalizar jogo"/>--}%
            %{--<g:submitButton  name="delete" class="delete" value="Remover questões selecionadas"/>--}%
        </fieldset>
	</body>
</html>
