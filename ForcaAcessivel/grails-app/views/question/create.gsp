<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 06/10/15
  Time: 09:27
--%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:javascript src="scriptTheme.js"/>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="main-content">
    <div class="widget">
        <h3 class="section-title first-title"><i class="icon-table"></i> Criar uma questão</h3>
        <div class="widget-content-white glossed">
            <div class="padded">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${questionInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${questionInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>

                    <g:uploadForm url="[resource: questionInstance, action: 'newQuestion']">
                    <fieldset class="form">
                        <!-- Renderiza o formulário para criação de novo item -->
                        <g:render template="form"/>
                        <div class="row right-align" style="margin-right: 1em">
                            <a id="back" name="back" class="btn btn-success remar-orange">Voltar</a>

                            <button id="submit" type="button" name="submit" class="btn btn-success remar-orange" value="Criar">Criar</button>
                        </div>
                    </fieldset>
                    </g:uploadForm>

                <br />

            </div>
        </div>
    </div>
</div>

<!-- Javascript
Todos os js tavam sendo adicionados aqui. Só tirei pra ver se isso que estava causando problema. -->
<g:javascript src="question.js"/>
<g:javascript src="recording.js"/>
<g:javascript src="recorder.js"/>
<g:javascript src="editableTable.js"/>
<g:javascript src="scriptTable.js"/>
<g:javascript src="validate.js"/>
</body>
</html>