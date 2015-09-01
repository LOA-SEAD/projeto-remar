<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 28/08/15
  Time: 09:45
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="new-main-inside">
        <title></title>
    </head>
    <body>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header-blue">Publicar R.E.A.</h1>
                </div>
            </div>
            <div class="row">
                <form action="/process/publishGame" method="POST">
                    <fieldset>
                        <legend>Dados do R.E.A.</legend>
                        <label for="gameName">Nome: </label><input type="text" name="gameName" required="required" /><br />
                        <label for="gameImage">Nome: </label><input type="text" name="gameImage" required="required" /><br />
                        <br />
                        <fieldset>
                            <legend>Dimensões</legend>
                            <label for="gameWidth">Largura: </label><input type="number" name="gameWidth" required="required" /><br />
                            <label for="gameHeight">Altura: </label><input type="number" name="gameHeight" required="required" /><br />
                        </fieldset>
                    </fieldset>
                    <br />
                    <br />
                    <fieldset>
                        <legend>Plataformas para publicação</legend>
                        <g:each in="${platforms}" status="i" var="platform">
                            <input type="checkbox" id="${platform}" name="${platform}" value="${platform}" />
                            <label for="${platform}">${platform}</label>
                            <br />
                        </g:each>
                    </fieldset>
                    <br />
                    <br />
                    <input type="hidden" name="processId" value="${processId}" />
                    <input type="submit" value="Publicar" />
                </form>
            </div>
        </div>
    </body>
</html>