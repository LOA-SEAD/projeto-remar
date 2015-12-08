<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Theme" %>
<%@page expressionCodec="raw" %>


<head xmlns="http://www.w3.org/1999/html">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <g:javascript src="imagePreview.js"/>

</head>
<body>

<div class="row" id="form">
    <div class="col s12">
        <h4> Upload de Imagens</h4>
    </div>
</div>
<g:uploadForm controller="design" action="ImagesManager">
    <div class="row">
        <div class="col s12">
            <table class="responsive-table" id="tableNewTheme">
                <thead>
                <tr>
                    <th>Porta nível 1</th>
                    <th>Porta nível 2</th>
                    <th>Porta nível 3</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <div class="row">
                            <p></p>
                            <img id="a-preview" class="door" style="width: 142px; height: 200px;" />
                        </div>
                        <div class="file-path-wrapper">
                            <input class="file-path" data-image="true" type="file" name="a-1" id="a-1" /> <label for="a-1">Fechada</label>
                        </div>
                        <div class="file-path-wrapper">
                            <input class="file-path" data-image="true" type="file" name="a-0" id="a-0" /> <label for="a-0">Aberta</label>
                        </div>
                    </td>
                    <td>
                        <div class="row">
                            <p></p>
                            <img id="b-preview" class="door" style="width: 142px; height: 200px;" />
                        </div>
                        <div class="file-path-wrapper">
                            <input data-image="true" type="file" name="b-1" id="b-1" /> <label for="b-1">Fechada</label>
                        </div>
                        <div class="file-path-wrapper">
                            <input data-image="true" type="file" name="b-0" id="b-0" /> <label for="b-0">Aberta</label>
                        </div>
                    </td>
                    <td>
                        <div class="row">
                            <p></p>
                            <img id="c-preview" class="door" style="width: 142px; height: 200px;" />
                        </div>
                        <div class="file-path-wrapper">
                            <input data-image="true" type="file" name="c-1" id="c-1" /> <label for="c-1">Fechada</label>
                        </div>
                        <div class="file-path-wrapper">
                            <input data-image="true" type="file" name="c-0" id="c-0" /> <label for="c-0">Aberta</label>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</g:uploadForm>

<input id="upload" type="submit" name="upload" class="btn btn-success" value="Criar"/>

</body>

