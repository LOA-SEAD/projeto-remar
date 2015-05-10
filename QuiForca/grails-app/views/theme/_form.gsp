<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Theme" %>
<%@page expressionCodec="raw" %>


<head xmlns="http://www.w3.org/1999/html">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <g:javascript src="imagePreview.js"/>

</head>
<body>
    <fieldset id="form">
        <legend class="blue">Upload de Imagens</legend>
        <div>
            <g:uploadForm   controller="design" action="ImagesManager">
                <div class="col-xs-6">
                    <div>
                        <img id="iconePreview" style="width: 100px; height: 100px;" />
                    </div>

                    <input data-image="true"  type="file" name="icone" id="icone" />

                    <div style="font-size:0.8em; margin: 1.0em;">
                        <p>Escolha um icone para seu jogo.
                        </p>
                    </div>

                </div>
                <div class="col-xs-6">
                    <div>
                        <img id="openingPreview" style="width: 100px; height: 100px;" />
                    </div>

                    <input data-image="true"  type="file" name="opening" id="opening" />
                    <div style="font-size:0.8em; margin: 1.0em;">
                        <p>Escolha uma imagem de abertura.
                        </p>
                    </div>

                </div>
                <div class="clearfix"></div>
                <div class="col-xs-6">
                    <div>
                        <img  id="backgroundPreview" style="width: 100px; height: 100px;" />
                    </div>
                    <input data-image="true" type="file" name="background" id="background"/>
                    <div style="font-size:0.8em; margin: 1.0em;">
                        <p> Escolha uma imagem de fundo.
                        </p>


                    </div>
                </div>
            </div>
            <div class="clearfix"></div>

        </g:uploadForm>

            <input id="upload" type="submit" name="upload" class="btn btn-success" value="Salvar"/>
    </fieldset>
</body>
