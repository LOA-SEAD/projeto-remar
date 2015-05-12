<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:javascript src="versions.js"></g:javascript>
</head>
<body>
<fieldset class="buttons">
    <a class="home" href="/EscolaMagica/">Principal</a>
</fieldset>
<div id="web" class="endpoint"><h1><input type="checkbox" name="web"/> Gerar versão web</h1></div> <br>

<fieldset class="buttons">
    <g:submitButton id="send" name="send" class="save" value="Enviar" />
    %{--<g:submitButton id="save-and-finish" name="save" class="save" value="Salvar e finalizar jogo"/>--}%
    %{--<g:submitButton name="delete" class="delete" value="Remover questões selecionadas"/>--}%
</fieldset>
</body>
</html>
