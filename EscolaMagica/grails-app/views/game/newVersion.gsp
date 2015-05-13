<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">

        <g:javascript src="versions.js" />

    </head>
    <body>
        <div class="page-header">
            <h1>Publicação</h1>
        </div>
        <g:if test="${flash.message}">
            <div class="message" role="status">
                ${flash.message}
            </div>
        </g:if>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title">
                    <i class="icon-table"></i> Opções para Publicação
                </h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <fieldset class="buttons">
                            <a class="home" href="/EscolaMagica/">Principal</a>
                        </fieldset>
                        <div id="web" class="endpoint"><h1><input type="checkbox" name="web"/> Gerar versão web</h1></div> <br>

                        <fieldset class="buttons">
                            <g:submitButton id="send" name="send" class="btn btn-success" value="Enviar" />
                            %{--<g:submitButton id="save-and-finish" name="save" class="save" value="Salvar e finalizar jogo"/>--}%
                            %{--<g:submitButton name="delete" class="delete" value="Remover questões selecionadas"/>--}%
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>


