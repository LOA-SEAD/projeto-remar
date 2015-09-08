<%--
Created by IntelliJ IDEA.
User: loa
Date: 10/06/15
Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <g:javascript src="platforms.js" />
    <title></title>

</head>
<body>
<div class="content">
    <div class="row">
        <div class="col-lg-12">
            <fieldset>
                <legend>Dados do recurso</legend>
                <p>
                    Nome:
                    <input type="text" placeholder="${resourceName}"/>
                </p>
            </fieldset>
            <fieldset>
                <legend>Tipo</legend>
                <p>
                    <input type="radio" name="type" value="public" checked/>Público
                    <br>
                    <input type="radio" name="type" value="private" disabled readonly/>Privado
                    <span class="label label-warning">Em breve</span>
                    <br>
                    <input type="radio" name="type" value="group" disabled readonly />
                    Grupo
                    <select disabled>
                        <option>Truma 1</option>
                    </select>
                    <span class="label label-warning">Em breve</span>
                </p>
            </fieldset>
            <fieldset>
                <legend>Plataformas</legend>
                <p>
                    <g:each in="${platforms}" var="platform">
                        <g:if test="${platform.contains(':')}">
                            <input type="checkbox" checked disabled readonly/>
                            <b> ${platform.substring(0, platform.indexOf(':'))}:
                            <a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a> </b>
                        </g:if>
                        <g:else>
                            <g:if test="${platform.toLowerCase() != 'web' && platform.toLowerCase() != 'moodle'}">
                                <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform" disabled readonly/>
                                <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}">${platform}</label>
                                <span class="label label-warning">Em breve</span>
                            </g:if>
                            <g:else>
                                <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform"/>
                                <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}">${platform}</label>
                            </g:else>
                        </g:else>
                        <br>
                    </g:each>
                    <input type="checkbox" name="windows" id="windows" class="checkbox-platform" disabled readonly/>
                    <label for="windows">Windows <span class="label label-warning">Em breve</span></label>
                </p>
            </fieldset>
            <g:submitButton id="send" name="send" class="btn btn-success" value="Enviar" />
        </div>
    </div>
</div>
</body>
</html>