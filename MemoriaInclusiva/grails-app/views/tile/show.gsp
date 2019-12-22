<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="main-content">
    <div class="widget">
        <h3 class="section-title first-title"><i class="icon-table"></i>Detalhes da customização</h3>

        <br/>
        <br/>

        <div class="widget-content-white glossed">
            <div class="padded">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${tileInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${tileInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                    error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>

                <div class="row">
                    <div class="col s12 m12 l12">
                        <table class="striped centered" id="table" style="margin-top: -30px;">

                            <thead>
                            <tr>
                                <th>Campo</th>
                                <th>Conteúdo</th>
                                <th>Áudio</th>
                            </tr>
                            </thead>
                            <tbody>

                            <tr>
                                <td>
                                ${message(code: 'tile.table.textA.header', default: 'Texto da Primeira Carta')}
                                </td>
                                <td>
                                    ${tileInstance.textA}
                                </td>
                                <td>
                                    <br>
                                    <audio controls>
                                        <source src="${request.contextPath}/carta1/${tileInstance.id}/${new Date().time}" type="audio/wav">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    ${message(code: 'tile.table.textB.header', default: 'Texto da Segunda Carta')}
                                </td>
                                <td>
                                    ${tileInstance.textB}
                                </td>
                                <td>
                                    <br>
                                    <audio controls>
                                        <source src="${request.contextPath}/carta2/${tileInstance.id}/${new Date().time}" type="audio/wav">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    ${message(code: 'tile.description.label', default: 'Descrição')}
                                </td>
                                <td>
                                    ${tileInstance.description}
                                </td>
                                <td>
                                    <br>
                                    <audio controls>
                                        <source src="${request.contextPath}/descricao/${tileInstance.id}/${new Date().time}" type="audio/wav">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>


                            </tbody>
                        </table>

                        <br/>
                        <br/>
                        <div class="row right-align" style="right-margin: 15em;">
                            <a class="btn btn-success remar-orange" href="${createLink(action: "edit")}/${tileInstance.id}">Editar</a>
                            <a id="back" name="back" class="btn btn-success remar-orange">Voltar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        $('#back').click(function() {
            var getUrl = window.location;
            var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];

            window.location.href = baseUrl + "/tile/index";
        });
    });
</script>
</body>
</html>
