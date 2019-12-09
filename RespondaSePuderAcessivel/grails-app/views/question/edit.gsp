<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<div class="cluster-header">
    <h4>Editar Questão</h4>
    <div class="divider"></div>
</div>

    <g:form class="col s12" controller="question" action="update" enctype="multipart/form-data" method="PUT">
        <g:hiddenField name="version" value="${questionInstance?.version}" />
        <fieldset class="form">
            <g:render template="form"/>

            <div class="row right-align" style="right-margin: 15em;">
                <a id="back" name="back" class="btn btn-success remar-orange">Voltar</a>
                <button id="submit" type="button" name="submit" class="btn btn-success remar-orange" value="Salvar">Salvar</button>
            </div>
        </fieldset>
    </g:form>

<g:javascript src="question.js"/>
<g:javascript src="recording.js"/>
<g:javascript src="recorder.js"/>
</body>
</html>

