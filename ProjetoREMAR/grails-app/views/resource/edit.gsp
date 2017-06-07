<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 16/12/15
  Time: 12:32
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="materialize-layout">
</head>
<body>
    <div class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-body box-info">
                    <p class="left-align margin-bottom" style="font-size: 24px;">
                        <i class="left small material-icons">games</i>Editar informações
                    </p>
                    <div class="divider"></div>
                    <br />
                    <div class="box-body">
                        <ul class="collapsible popout" data-collapsible="accordion">
                            <li>
                                <div class="collapsible-header active">Informações adicionais</div>
                                <div class="collapsible-body">
                                        <input type="hidden" name="id" value="${resourceInstance.id}" id="hidden">
                                        <div class="col-s12" >
                                            <g:render template="form"/>
                                        </div>
                                </div>
                            </li>
                        </ul>
                    </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="modal-picture" class="modal">
        <div class="row">
            <div class="modal-content center">
                <img id="crop-preview" class="responsive-img">
            </div>
        </div>
       <div class="row">
           <div class="modal-footer">
               <a href="#!" class="modal-action modal-close waves-effect btn-flat">Enviar</a>
           </div>
       </div>
    </div>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'game-index.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'edit.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.Jcrop.js')}"></script>

</body>
</html>