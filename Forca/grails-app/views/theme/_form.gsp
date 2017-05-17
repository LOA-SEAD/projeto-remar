<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.forca.remar.Theme" %>
<%@page expressionCodec="raw" %>


<head xmlns="http://www.w3.org/1999/html">
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:javascript src="../assets/js/jquery.min.js"/>

</head>
<body>

    <div class="row" id="form">
        <div class="col s12">
            <h4>Forca - Tema - Upload de Imagens</h4>
        </div>
    </div>

    <g:uploadForm controller="design" action="ImagesManager">
        <div class="row">
            <div class="col s12">
                <ul class="collapsible" data-collapsible="accordion">

                    <li>
                        <div class="collapsible-header active">Upload</div>
                        <div class="collapsible-body">
                            <table class="centered" id="tableNewTheme">
                                <thead>
                                <tr>
                                    <th>Nome da Imagem</th>
                                    <th>Preview da Imagem</th>
                                    <th>Arquivo</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Ícone</td>
                                    <td>
                                        <div class="row">
                                              <img class="" id="iconePreview" style="width: 250px;" />
                                        </div>
                                    </td>
                                    <td>

                                        <div class="file-field input-field">
                                            <div class="btn right">
                                                <span>File</span>
                                                <input type="file" name="icone" id="icone" multiple>
                                            </div>
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Selecione um ícone">
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Tela de Abertura</td>
                                    <td>
                                        <div class="row">
                                            <img class="" id="openingPreview" style="width: 250px;" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="file-field input-field">
                                            <div class="btn right">
                                                <span>File</span>
                                                <input type="file" name="opening" id="opening" multiple>
                                            </div>
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Selecione um ícone">
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Tela de Fundo</td>
                                    <td>
                                        <div class="row">
                                            <img class="" id="backgroundPreview" style="width: 250px;" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="file-field input-field">
                                            <div class="btn right">
                                                <span>File</span>
                                                <input type="file" name="background" id="background" multiple>
                                            </div>
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Selecione um ícone">
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
                            <p class="justify-text"> Procure enviar imagens de fundo claro. Imagens de fundo escuro dificultam a visualização das informações do jogo.
                            Para um melhor desempenho as imagens devem possuir as propriedades descritas na tabela abaixo.</p>
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
                                    <td>Ícone</td>
                                    <td> 800x600 </td>
                                    <td> PNG </td>
                                </tr>
                                <tr>
                                    <td>Tela de Abertura</td>
                                    <td> 800x600 </td>
                                    <td> PNG </td>
                                </tr>
                                <tr>
                                    <td>Tela de Fundo</td>
                                    <td> 800x600 </td>
                                    <td> PNG </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </li>
                </ul>
            </div>
        </div>


    </g:uploadForm>

    <input id="upload" type="submit" name="upload" class="btn btn-success my-orange" value="Criar"/>

    <g:javascript src="imagePreview.js"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
        });

    </script>
</body>
