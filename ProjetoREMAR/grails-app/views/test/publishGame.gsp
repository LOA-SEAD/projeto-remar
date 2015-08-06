
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:javascript src="moodle.js"/>
    <style>
    #moodleForm {
        display: none;
    }
    </style>
    <title></title>
</head>

<body>


<div>
    <label for="moodle">
        Deseja publicar para o moodle?
        <input class="checkbox.moodle" type="checkbox" id="moodle" name="moodle" value="${false}"/> <br>
        <a id="moodleForm" target="_blank" href="/moodleGame/gamePublishConfig/">Formulario para o Moodle</a>
    </label>
</div>
<div>
    <label for="web">
        Deseja publicar para a Web?
        <input type="checkbox" id="web" name="web" value="${false}"/> <br>
        %{--<a id="webLink" target="_blank" href="a" />--}%
    </label>
</div>
<div>
    <label for="android">
        Deseja publicar para Android?
        <input type="checkbox" id="android" name="android" value="${false}"/> <br>
        %{--<a id="androidLink" target="_blank" />--}%
    </label>
</div>
</body>
</html>