<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Theme" %>
<%@page expressionCodec="raw" %>


<head xmlns="http://www.w3.org/1999/html">


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
                <ul class="collapsible" data-collapsible="accordion">

                    <li>
                        <div class="collapsible-header active"><i class="material-icons">file_upload</i>Upload</div>
                        <div class="collapsible-body">
                            <table class="centered" id="tableNewTheme">
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
                                            <img class="" id="iconePreview" style="width: 250px;" />
                                        </div>
                                        <div class="file-field input-field">
                                            <input type="file" name="icone" id="icone">

                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Selecione um ícone">
                                            </div>
                                        </div>

                                    </td>
                                    <td>
                                        <div class="row">
                                            <img class="" id="openingPreview" style="width: 250px;" />
                                        </div>

                                        <div class="file-field input-field">
                                            <input type="file" name="opening" id="opening">
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Selecione uma tela de abertura">
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="row">
                                            <img class="" id="backgroundPreview" style="width: 250px;" />
                                        </div>
                                        <div class="file-field input-field">

                                            <input type="file" name="background" id="background">
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Selecione uma tela de fundo">
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info</i>Informações sobre as Imagens</div>
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
