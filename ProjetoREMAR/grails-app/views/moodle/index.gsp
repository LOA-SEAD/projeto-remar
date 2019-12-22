<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 9/15/15
  Time: 5:06 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>
<body>

    <div class="row" style="margin-top: 15px;">
        <h3 class="center">
            Vincular conta ao Moodle
        </h3>
    </div>

    <g:if test="${moodleInstanceList == []}" >
        <p style="margin: 20px;" class="center">Nenhuma instância de Moodle instalada.</p>
    </g:if>
    <g:else>
        <form action="/moodle/link" enctype="multipart/form-data" method="POST">
            <div class="row" style="margin-top: 50px;">
                <div class="valign-wrapper">
                    <div class="input-field col s12 m6" style="margin: 0 auto !important;">
                        <i class="material-icons prefix" style="left: 0px;">school</i>
                        <g:select name="domain" from="${moodleInstanceList}" optionValue="name" optionKey="domain" class="form-control-remar" />
                        <label>Moodle</label>
                    </div>
                </div>
                <div class="input-field col s12 center-align">
                    <button id="submit" class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
                </div>
            </div>
        </form>
    </g:else>

    <script>
        $(document).ready(function() {
            $('select').material_select();
        });
    </script>

</body>
</html>