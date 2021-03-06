<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="../css/materialize.css" media="screen,projection"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css">


    <!--Let browser know website is optimized for mobile-->
    <meta name="layout" content="main"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Ortotetris</title>
</head>

<body>
<!--Import jQuery before materialize.js-->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
%{--<script type="text/javascript" src="../js/materialize.min.js"></script>--}%
<script type="text/javascript" src="${resource(dir: 'js', file: 'materialize.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'principal.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'order.js')}"></script>
<g:javascript src="iframeResizer.contentWindow.min.js"/>



<div class="container">

    <div class="row">
        <div class="col s12 m12 l12">
            <div class="cluster-header">
                <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
                    <i class="small material-icons left">grid_on</i>Ortotetris - Tabela de Palavras
                </p>
            </div>
        </div>
    </div>



    <div class="row">
        <div class="col s12">
            <ul class="tabs">
                <li class="tab col s6"><a href="#instructions">Instruções</a></li>
                <li class="tab col s6"><a class="active" href="#wordsTable">Escolher Palavras</a></li>
            </ul>
        </div>
        <div id="instructions" class="col s12 m12 l12">
            <p style="text-align: justify">Na customização do jogo Ortotetris você deve selecionar ao menos 1 palavra para finaliza-lo, porém quanto mais palavras ele possuir mais atrativo ele será.</p>
            <p style="text-align: justify">Para selecionar as palavras desejadas utilize a aba "Escolher Palavras". Nela você pode criar novas palavras, editar palavras, movimentar a palavra, esconder ou exibir letras e também excluir palavras. Em caso de dúvidas de onde encontrar cada operação utilize a tabela a baixo para consulta.</p>
            <div class="row">
                <div class="col s12 m12 l12">
                    <table>
                        <thead>
                            <tr>
                                <th>Botão</th>
                                <th>Legenda</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><a name="create" class="btn-floating btn-large waves-effect waves-light my-orange"><i class="material-icons">add</i></a></td>
                                <td>Botão para criar nova palavra</td>
                            </tr>
                            <tr>
                                <td><a class="btn-floating btn-large waves-effect waves-light my-orange"><i class="material-icons">delete</i></a></td>
                                <td>Excluir palavra</td>
                            </tr>
                            <tr>
                                <td><a class="btn-floating btn-large waves-effect waves-light my-orange"><i class="material-icons">file_upload</i></a></td>
                                <td>Botão para enviar arquivo .csv</td>
                            </tr>
                        <tr>
                            <td><i class="material-icons">edit</i></td>
                            <td>Editar palavra</td>
                        </tr>
                        <tr>
                            <td><i class="material-icons">games</i></td>
                            <td>Customizar palavra. O botão de customizar palavra abre uma janela na qual é possível movimentar a palavra e esconder ou exibir letras</td>
                        </tr>
                        <tr>
                            <td><a class='btn myButton4'> <div style="margin-top: 20px;" class="arrowleft"></div></a></td>
                            <td>Botão para mover a palavra para esquerda</td>
                        </tr>
                        <tr>
                            <td><a class='btn myButton4'> <div style="margin-top: 20px;" class="arrowright"></div></a></td>
                            <td>Botão para mover a palavra para direita</td>
                        </tr>
                        <tr>
                            <td><a class="myButton3"> X </a></td>
                            <td>Letra exibida. Esse botão indica que a letra será exibida no jogo. É possível esconder a letra exibida clicando no botão, desde que a letra pertença ao conjunto: [C, H, S, X, Z, Ç]</td>
                        </tr>
                        <tr>
                            <td><a class="myButton"> X </a></td>
                            <td>Letra não exibida. Esse botão indica que a letra não será exibida no jogo. É possível exibir novamente a letra clicando no botão</td>
                        </tr>
                        <tr>
                            <td><a class="myButton2"> - </a></td>
                            <td>Espaço em branco</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="wordsTable" class="col s12 m12 l12">

            <div class="row">
                <div class="col s3 offset-s9">
                    <input type="text" id="SearchLabel" placeholder="Buscar"/>
                </div>
            </div>

            <div class="row">
                <div class="col s12">
                    <div id="ShowWord">

                    </div>
                </div>

            </div>

            <section id="TableWordList">
                <g:render template="list"/>
            </section>

            <div class="row">
                <div class="col s12">

                </div>
            </div>

            <div class="row">
                <div class="col s12">

                </div>
            </div>

            <div class="row">
                <div class="col s2 m2 l2">
                    <button class="btn waves-effect waves-light my-orange tooltipped" data-tooltip="Enviar" type="submit" name="save" id="save"
                            onclick="submit()">Enviar
                        <i class="material-icons right">send</i>
                    </button>
                </div>

                <div class="col s1 m1 l1 offset-s3 offset-m7 offset-l7">
                    <a name="create" onclick="openModal('createModal')"
                       class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Criar nova palavra"><i
                            class="material-icons">add</i></a>
                </div>
                <div class="col s1 offset-s1 m1 l1">
                            <a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir questão" ><i class="material-icons">delete</i></a>
                </div>
                <div class="col s1 offset-s1 m1 l1">
                    <a onclick="openModal('uploadModal')" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Upload de arquivo .csv"><i
                            class="material-icons">file_upload</i></a>
                </div>
            </div>

            <!-- Modal Structure -->
            <div id="createModal" class="modal">
            <div class="modal-content">
                <div class="row">
                    <div class="col s12 m12 l12">
                        <h4>Criar Palavra</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col s12 m6 offset-m3 l6 offset-l3">
                        <div class="input-field" id="parametersNewWord">
                            <input class="center" id="NewWordLabel" maxlength="10" type="text" name="answer"> <label for="NewWordLabel">Digite uma nova palavra</label>
                            <input type="hidden" value="none" name="word"> <label></label>
                            <input type="hidden" value="0" name="initialPosition"><label></label>
                        </div>
                        <div class=" center-align s12 m3 l3">
                                <a onclick="SaveNewWord()" class="btn btn-success btn-lg my-orange">Criar</a>
                        </div>
                    </div>
                </div>
            </div>


            </div>

            <!-- Modal Structure -->
            <div id="showModal" class="modal">
                <div class="modal-content">
                    <div class="row"></div>
                    <div class="row"></div>
                    <div class="row"  id="showWordModal">
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>

            <!-- Modal Structure -->
            <div id="uploadModal" class="modal">
                <div class="modal-content">
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <h4>Enviar arquivo .csv</h4>
                        </div>
                    </div>

                    <g:uploadForm action="generateQuestions">
                        <div class="row">
                            <div class="col s12 m12 l12">
                                <div class="file-field input-field">
                                    <div class="btn my-orange">
                                        <span>Arquivo</span>
                                        <input type="file" accept="text/csv" id="csv" name="csv">
                                    </div>

                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s5 offset-s7 m2 offset-m10 l2 offset-l10">
                                <g:submitButton class="btn my-orange" name="csv" value="Enviar"/>
                            </div>
                        </div>
                    </g:uploadForm>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <blockquote>Formatação do arquivo .csv</blockquote>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6 m6 l6">
                            <ol>
                                <li>O separador do arquivo .csv deve ser <b> ';' (ponto e vírgula)</b>  </li>
                                <li>O arquivo deve ser composto apenas por <b>dados</b></li>
                                <li>O arquivo deve representar a estrutura da tabela ao lado</li>
                            </ol>
                            <ul>
                                <li><a href="/forca/samples/exemploForca.csv" >Download do arquivo exemplo</a></li>
                            </ul>
                        </div>
                        <div class="col s6 m6 l6">
                            <table class="center centered">
                                <thead>
                                <tr>
                                    <th>Palavra</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Palavra 1</td>
                                </tr>
                                <tr>
                                    <td>Palavra 2</td>
                                </tr>
                                <tr>
                                    <td>Palavra 3</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>