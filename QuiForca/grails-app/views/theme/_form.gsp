<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Theme" %>
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
                        <th>Ícone</th>
                        <th>Tela de Abertura</th>
                        <th>Tela de Fundo</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div class="row">
                                <p>Escolha um icone para seu jogo:</p>
                                <img class="" id="iconePreview" style="width: 250px;" />
                            </div>
                            <div class="row">
                                <input data-image="true"  type="file" name="icone" id="icone" />
                            </div>
                        </td>
                        <td>
                            <div class="row">
                                <p>Escolha uma imagem de abertura:</p>
                                <img class="" id="openingPreview" style="width: 250px;" />
                            </div>
                            <div class="row">
                                <input data-image="true"  type="file" name="opening" id="opening" />
                            </div>
                        </td>
                        <td>
                            <div class="row">
                                <p> Escolha uma imagem de fundo:</p>
                                <img class="" id="backgroundPreview" style="width: 250px;" />
                            </div>
                            <div class="row">
                                <input data-image="true" type="file" name="background" id="background"/>
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
