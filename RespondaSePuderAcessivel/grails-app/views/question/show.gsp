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
                <g:hasErrors bean="${questionInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${questionInstance}" var="error">
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
                                    Pergunta
                                </td>
                                <td>
                                    ${questionInstance.title}
                                </td>
                                <td>
                                    <audio controls>
                                        <source src="${request.contextPath}/title/${questionInstance.id}/${new Date().time}"
                                                type="audio/mpeg">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    1<sup>a</sup> Alternativa (correta)
                                </td>
                                <td>
                                    ${questionInstance.answers[0]}
                                </td>
                                <td>
                                    <audio controls>
                                        <source src="${request.contextPath}/answer1/${questionInstance.id}/${new Date().time}"
                                                type="audio/mpeg">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    2<sup>a</sup> Alternativa
                                </td>
                                <td>
                                    ${questionInstance.answers[1]}
                                </td>
                                <td>
                                    <audio controls>
                                        <source src="${request.contextPath}/answer2/${questionInstance.id}/${new Date().time}"
                                                type="audio/mpeg">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    3<sup>a</sup> Alternativa
                                </td>
                                <td>
                                    ${questionInstance.answers[2]}
                                </td>
                                <td>
                                    <audio controls>
                                        <source src="${request.contextPath}/answer3/${questionInstance.id}/${new Date().time}"
                                                type="audio/mpeg">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    4<sup>a</sup> Alternativa
                                </td>
                                <td>
                                    ${questionInstance.answers[3]}
                                </td>
                                <td>
                                    <audio controls>
                                        <source src="${request.contextPath}/answer4/${questionInstance.id}/${new Date().time}"
                                                type="audio/mpeg">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Dica
                                </td>
                                <td>
                                    ${questionInstance.hint}
                                </td>
                                <td>
                                    <audio controls>
                                        <source src="${request.contextPath}/hint/${questionInstance.id}/${new Date().time}"
                                                type="audio/mpeg">
                                        Your browser does not support the audio tag.
                                    </audio>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <br/>
                        <br/>
                        <div class="row right-align" style="right-margin: 15em;">
                            <a class="btn btn-success remar-orange" href="${createLink(action: "edit")}/${questionInstance.id}">Editar</a>
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

            window.location.href = baseUrl + "/question/index";
        });
    });
</script>
</body>
</html>
