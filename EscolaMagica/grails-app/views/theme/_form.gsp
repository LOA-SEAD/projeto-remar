<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Theme" %>
<%@page expressionCodec="raw" %>


<head xmlns="http://www.w3.org/1999/html">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <g:javascript src="imagePreview.js"/>
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:javascript src="../assets/js/jquery.min.js"/>
    <g:external dir="css" file="themes.css"/>
</head>
<body>

<div class="row" id="form">
    <div class="col s12">
        <h4>Escola Mágica - Temas - Upload de Imagens</h4>
    </div>
</div>
<g:uploadForm controller="design" action="ImagesManager">
    <div class="row">
        <div class="col s12">
            <ul class="collapsible" data-collapsible="accordion">
                <li>
                    <div class="collapsible-header active">Upload</div>
                    <div class="collapsible-body">
                        <table style="overflow: scroll;" class="centered" id="tableNewTheme">
                            <thead>
                            <tr>
                                <th>Nome da Imagem</th>
                                <th>Preview da Imagem</th>
                                <th>Arquivo</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Porta Nível 1</td>
                                <td>
                                    <div class="row" style="height: 200px;">
                                        <img id="a-preview" class="door" height="200" />
                                    </div>
                                </td>
                                <td>
                                    <div class="file-field input-field">
                                        <div class="btn right">
                                            <span>File</span>
                                            <input data-image="true" type="file" name="a-1" id="a-1" accept="image/png">
                                            </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Fechada">
                                        </div>
                                    </div>
                                    <div class="file-field input-field">
                                        <div class="btn right">
                                            <span>File</span>
                                        <input data-image="true" type="file" name="a-0" id="a-0" accept="image/png">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Aberta">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 2</td>
                                <td>
                                    <div class="row" style="height: 200px;">
                                        <img id="b-preview" class="door" height="200"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="file-field input-field">
                                        <div class="btn right">
                                            <span>File</span>
                                        <input data-image="true" type="file" name="b-1" id="b-1" accept="image/png">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Fechada">
                                        </div>
                                    </div>
                                    <div class="file-field input-field">
                                        <div class="btn right">
                                            <span>File</span>
                                        <input data-image="true" type="file" name="b-0" id="b-0" accept="image/png">
                                            </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Aberta">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 3</td>
                                <td>
                                    <div class="row" style="height: 200px;">
                                        <img id="c-preview" class="door" height="200"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="file-field input-field">
                                        <div class="btn right">
                                            <span>File</span>
                                        <input data-image="true" type="file" name="c-1" id="c-1" accept="image/png">
                                            </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Fechada">
                                        </div>
                                    </div>
                                    <div class="file-field input-field">
                                        <div class="btn right">
                                            <span>File</span>
                                        <input data-image="true" type="file" name="c-0" id="c-0" accept="image/png">
                                            </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Aberta">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                            </table>
                    </div>
                </li>
                <li>
                    <div class="collapsible-header">Informações sobre as Imagens</div>
                    <div class="collapsible-body">
                        <p class="justify-text">Para um melhor desempenho as imagens devem possuir as propriedades descritas na tabela abaixo.</p>
                        <table class="centered">
                            <thead>
                            <tr>
                                <th>Imagem</th>
                                <th>Dimensões (pixels)</th>
                                <th>Extensão</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Porta Nível 1 - Aberta</td>
                                <td> 142x213 </td>
                                <td> PNG </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 1 - Fechada</td>
                                <td> 142x200 </td>
                                <td> PNG </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 2 - Aberta</td>
                                <td> 142x213 </td>
                                <td> PNG </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 2 - Fechada</td>
                                <td> 142x200 </td>
                                <td> PNG </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 3 - Aberta</td>
                                <td> 142x213 </td>
                                <td> PNG </td>
                            </tr>
                            <tr>
                                <td>Porta Nível 3 - Fechada</td>
                                <td> 142x200 </td>
                                <td> PNG </td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </li>

            </ul>
        </div>
    </div>

    <div class="row">
        <div class="col s12">
        </div>
    </div>
</g:uploadForm>


<input id="upload" type="submit" name="upload" class="btn btn-success my-orange" value="Criar"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
<script>
    $(document).ready(function(){
        $('.collapsible').collapsible({
            accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
        });
    });
</script>
</body>

