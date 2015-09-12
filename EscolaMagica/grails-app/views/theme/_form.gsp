<!DOCTYPE HTML>
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Theme" %>
<%@page expressionCodec="raw" %>


<head xmlns="http://www.w3.org/1999/html">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <g:javascript src="imagePreview.js"/>

</head>
<body>
    <fieldset id="form">
        <legend class="blue">Upload de Imagens</legend>
        <div>
            <g:uploadForm controller="design" action="ImagesManager">
                <div class="col-xs-4">
                    <div>
                        <p>Porta nível 1</p>
                    </div>
                    <div>
                        <img id="a-preview" class="door" style="width: 142px; height: 200px;" />
                    </div>
                    <br />
                    Fechada<input data-image="true" type="file" name="a-1" id="a-1" />
                    Aberta<input data-image="true" type="file" name="a-0" id="a-0" />
                </div>
                <div class="col-xs-4">
                    <div>
                        <p>Porta nível 2</p>
                    </div>
                    <div>
                        <img id="b-preview" class="door" style="width: 142px; height: 200px;" />
                    </div>
                    <br />
                    Fechada<input data-image="true" type="file" name="b-1" id="b-1" />
                    Aberta<input data-image="true" type="file" name="b-0" id="b-0" />
                </div>

                <div class="col-xs-4">
                    <div>
                        <p>Porta nível 3</p>
                    </div>
                    <div>
                        <img id="c-preview" class="door" style="width: 142px; height: 200px;" />
                    </div>
                    <br />
                    Fechada<input data-image="true" type="file" name="c-1" id="c-1" />
                    Aberta<input data-image="true" type="file" name="c-0" id="c-0" />
                </div>


            </div>
            <div class="clearfix"></div>
            <br />
            <br />
        </g:uploadForm>
            <input id="upload" type="submit" name="upload" class="btn btn-success" value="Criar"/>
    </fieldset>
</body>
