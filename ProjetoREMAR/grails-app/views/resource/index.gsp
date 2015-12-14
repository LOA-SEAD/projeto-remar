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
    %{--<script>--}%
        %{--$(document).on('change', '.btn-file :file', function() {--}%
            %{--var input = $(this),--}%
                    %{--numFiles = input.get(0).files ? input.get(0).files.length : 1,--}%
                    %{--label = input.val().replace(/\\/g, '/').replace(/.*\//, '');--}%
            %{--input.trigger('fileselect', [numFiles, label]);--}%
        %{--});--}%

        %{--$(document).ready( function() {--}%
            %{--$('.btn-file :file').on('fileselect', function(event, numFiles, label) {--}%

                %{--var input = $(this).parents('.input-group').find(':text'),--}%
                        %{--log = numFiles > 1 ? numFiles + ' files selected' : label;--}%

                %{--if( input.length ) {--}%
                    %{--input.val(log);--}%
                %{--} else {--}%
                    %{--if( log ) alert(log);--}%
                %{--}--}%

            %{--});--}%

            %{--$('.tooltiped').tooltip({delay: 5});--}%
            %{--$('.dropdown-button').dropdown({--}%
                %{--alignment: 'left'--}%
            %{--});--}%
        %{--});--}%
    %{--</script>--}%




    <div class="row cluster">
        <p class="left-align margin-bottom" style="font-size: 24px;">
            <i class="left small material-icons">work</i>Gerenciar R.E.As
        </p>
        <div class="divider"></div>
        <br />
        <div class="card-list two-cards">
        <g:if test="${resourceInstanceList}">
                <g:each in="${resourceInstanceList}" status="i" var="gameInstance">
                    <g:if test="${gameInstance.status == 'pending'}">
                        <div class="card card-developer pending">
                    </g:if>
                    <g:elseif test="${gameInstance.status == 'approved'}">
                        <div class="card card-developer approved">
                    </g:elseif>
                    <g:elseif test="${gameInstance.status == 'rejected'}">
                        <div class="card card-developer bg-orange">
                    </g:elseif>
                        <div class="card-content">
                            <div class="cover">
                                <div class="cover-image-container">
                                  <div class="cover-outer-align">
                                        <div class="cover-inner-align">
                                            <img alt="A Head Full Of Dreams" class="cover-image img-responsive activator" src="https://lh3.googleusercontent.com/woc4V87mfN8LztxAI4pGvz33q6LKQHk9ULj1iEwjPM8u8hGUD4rmWsoh-Xo5kmkDdXDO5JHizw=w170-rw">
                                        </div>
                                    </div>
                                </div>
                                <a class="activator" ></a>
                            </div>
                            <div class="details">
                                %{--<a class="card-click-target"  href="/resource/show/${gameInstance.id}" aria-hidden="true" tabindex="-1"></a>--}%
                                <a class="title" title=${gameInstance.name}" aria-hidden="true" tabindex="-1">${gameInstance.name}</a>
                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: REMAR</p>
                                </div>
                            </div>
                            <div class="row no-margin margin-top card-info">
                                <div class="col s6">
                                    <div class="pull-left tiny-stars">
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
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
                                        <i class="tiny fa fa-linux"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-action">
                                <div class="col s12">
                                    <sec:ifAllGranted roles="ROLE_ADMIN">
                                        <input type="text" class="comment" placeholder="Comentário">
                                    </sec:ifAllGranted>
                                    <sec:ifNotGranted roles="ROLE_ADMIN">
                                        <p class="left-align">Awaiting Review</p>
                                    </sec:ifNotGranted>
                                    <div class="">
                                        <a href="" class="tooltipped" data-position="bottom" data-delay="5" data-tooltip="Excluir" style="color: gray;"><i class="material-icons">delete</i></a>
                                        <a href="" class="tooltipped" data-position="bottom" data-delay="5" data-tooltip="Rejeitar" style="color: red;"><i class="material-icons">block</i></a>
                                        <a href="" class="tooltipped" data-position="bottom" data-delay="5" data-tooltip="Aprovar" style="color: green;"><i class="material-icons">done</i></a>
                                    </div>
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
                <a class="btn-floating btn-large my-orange" href="/resource/create">
                    <i class="material-icons large">add</i>
                </a>
            </div>

        </div>
    </div>

</body>
</html>
