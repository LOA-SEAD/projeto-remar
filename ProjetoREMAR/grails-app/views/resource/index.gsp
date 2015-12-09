<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>
<body>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'game-index.js')}"></script>
    <script>
        $(document).on('change', '.btn-file :file', function() {
            var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });

        $(document).ready( function() {
            $('.btn-file :file').on('fileselect', function(event, numFiles, label) {

                var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                if( input.length ) {
                    input.val(log);
                } else {
                    if( log ) alert(log);
                }

            });

            $('.tooltiped').tooltip({delay: 5});
            $('.dropdown-button').dropdown({
                alignment: 'left'
            });
        });
    </script>

    <p class="left-align margin-bottom" style="font-size: 24px;">
        <i class="left small material-icons">work</i>Gerenciar R.E.As
    </p>
    <div class="divider"></div>

    <br />

    <div class="row">

        <g:if test="${resourceInstanceList}">
            <g:each in="${resourceInstanceList}" status="i" var="gameInstance">
                <div class="col s4">
                    <div class="card">
                        <div class="card-image">
                            <img src="https://lh3.googleusercontent.com/woc4V87mfN8LztxAI4pGvz33q6LKQHk9ULj1iEwjPM8u8hGUD4rmWsoh-Xo5kmkDdXDO5JHizw=w170-rw" alt="adsdasd" />
                        </div>
                        <div class="card-content">
                            <span class="card-title" style="color: black; font-weight: bold;">Escola Mágica</span>

                            <p class="left-align" style="padding: 0px 5px;">Review:</p>

                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <textarea class="comment" placeholder="Comentário">Comentário</textarea> <!--data-id="$ {gameInstance.id}"-->
                            </sec:ifAllGranted>
                            <sec:ifNotGranted roles="ROLE_ADMIN">
                                <p class="left-align" style="padding: 0px 5px;">Awaiting Review</p>
                            </sec:ifNotGranted>


                            <div class="row no-margin-bottom">
                                <div class="col s6" style="padding-left: 5px;">
                                    <div class="stars left-align">
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" style="margin-left: 0px;" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                    </div>
                                </div>
                                <div class="col s6">
                                    <div class="pull-right gray-color">
                                        <i class="tiny material-icons">public</i>
                                        <i class="tiny material-icons">android</i>
                                        <i class="tiny material-icons">school</i>
                                        <i class="tiny fa fa-linux"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-action valign-wrapper">
                            <div class="center">
                                <a href="" class="tooltipped" data-position="bottom" data-delay="5" data-tooltip="Excluir" style="color: gray;"><i class="material-icons">delete</i></a>
                                <a href="" class="tooltipped" data-position="bottom" data-delay="5" data-tooltip="Rejeitar" style="color: red;"><i class="material-icons">block</i></a>
                                <a href="" class="tooltipped" data-position="bottom" data-delay="5" data-tooltip="Aprovar" style="color: green;"><i class="material-icons">done</i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:if>
        <g:else>
            <p>Não há recursos cadastrados, ainda. Envie um novo!  :)</p>
        </g:else>

        <div class="fixed-action-btn my-position">
            <a class="btn-floating btn-large my-orange">
                <i class="material-icons large">edit</i>
            </a>
        </div>

    </div>

</body>
</html>
