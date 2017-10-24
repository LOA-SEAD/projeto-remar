<%@ page import="br.ufscar.sead.loa.remar.User;br.ufscar.sead.loa.remar.Group;" contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
        <div class="row cluster">
            <div class="row no-margin">
                <div class="row cluster-header">
                    <h4>Informações de <a href="/group/show/${group.id}">${group.name}</a></h4>
                    <div class="divider"></div>
                </div>

                <div class="row show">
                    %{-- Erros no preenchimento do formulário --}%
                    <g:if test="${request.error?.blank_name}">
                        <div class="error-box">
                            <i class="material-icons tiny">error</i>
                            Nome do grupo não pode ser vazio.
                        </div>
                    </g:if>
                    <g:if test="${request.error?.name_already_exists}">
                        <div class="error-box">
                            <i class="material-icons tiny">error</i>
                            Um grupo com o mesmo nome já existe.
                        </div>
                    </g:if>
                    <g:if test="${request.error?.blank_token}">
                        <div class="error-box">
                            <i class="material-icons tiny">error</i>
                            Código de acesso não pode ser vazio.
                        </div>
                    </g:if>

                    %{-- Formulário informações de grupo --}%
                    <div class="row no-margin">
                        <form action="/group/update" name="group-management-form" class="col s12">
                            <div class="row">
                                <div class="input-field col s12">
                                    <input id="group-name" name="groupname" value="${group.name}" type="text">
                                    <label class="active" for="group-name">Nome do Grupo</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <input id="group-token" name="grouptoken" value="${group.token}" type="text">
                                    <label class="active" for="group-token">Código de Acesso</label>
                                </div>
                            </div>
                            <input id="group-id" name="groupid" type="hidden" value="${group.id}">
                            <div class="row no-margin">
                                <div class="input-field col s12 center-align">
                                    <button id="group-management-submit" type="submit" class="waves-effect waves-light btn">
                                        Salvar
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="row no-margin">
                <div class="row cluster-header">
                    <h4>Gerenciamento de Membros</h4>
                    <div class="divider"></div>
                </div>

                %{-- Painel de gerenciamento de usuários --}%
                <div id="user-management-panel" class="row show">
                    <div class="col s6">
                        <div class="row">
                            <div class="user-list-box-container col s12">
                                <div class="row no-margin">
                                    <div class="col s12 center-align user-list-box-title">
                                        Membros do Grupo
                                    </div>
                                </div>

                                <ul id="members" class="row user-list-box sortable">
                                    <g:each in="${usersInGroup}" status="i" var="user">
                                        <li class="row no-margin valign-wrapper" data-user-id="${fieldValue(bean: user.userInstance, field: "id")}">
                                            <div class="col m2 center-align hide-on-small-only valign-wrapper">
                                                <i class="material-icons">drag_handle</i>
                                            </div>
                                            <div class="col s6 m7 left-align">
                                                <p class="truncate no-padding no-margin">${fieldValue(bean: user.userInstance, field: "name")}</p>
                                            </div>
                                            <g:if test="${user.isAdmin}">
                                                <div class="col s2 offset-s1 center-align valign-wrapper admin-toggle">
                                                    <a href="#!" class="valign-wrapper active">
                                                        <i class="click-hungry material-icons no-margin tooltipped" data-position="bottom" data-tooltip="Remover Administrador">
                                                            verified_user
                                                        </i>
                                                    </a>
                                                </div>
                                            </g:if>
                                            <g:else>
                                                <div class="col s2 offset-s1 center-align valign-wrapper admin-toggle">
                                                    <a href="#!" class="valign-wrapper">
                                                        <i class="click-hungry material-icons no-margin tooltipped" data-position="bottom" data-tooltip="Tornar Administrador">
                                                            verified_user
                                                        </i>
                                                    </a>
                                                </div>
                                            </g:else>
                                        </li>
                                    </g:each>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col s6">
                        <div class="row">
                            <div class="user-list-box-container col s12">
                                <div class="row no-margin">
                                    <div class="col s12 center-align user-list-box-title">
                                        Usuários do REMAR
                                    </div>
                                </div>

                                <ul id="available-users" class="row user-list-box sortable">
                                    <g:each in="${usersNotInGroup}" status="i" var="user">
                                        <g:if test="${group.owner.id != user.id}">
                                            <li class="row no-margin valign-wrapper" data-user-id="${fieldValue(bean: user, field: "id")}">
                                                <div class="col m2 center-align hide-on-small-only valign-wrapper">
                                                    <i class="material-icons">drag_handle</i>
                                                </div>
                                                <div class="col s12 m10 left-align valign-wrapper">
                                                    <p class="truncate no-padding no-margin">${fieldValue(bean: user, field: "name")}</p>
                                                </div>
                                            </li>
                                        </g:if>
                                    </g:each>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label><strong>Clique</strong> para selecionar e <strong>segure</strong> para arrastar.</label>
                        <label>Múltiplos usuário podem ser arrastados ao mesmo tempo.</label>
                    </div>

                    <!-- Admin toggle button model -->
                    <div id="admin-toggle-button-model" class="col s2 offset-s1 center-align valign-wrapper admin-toggle">
                        <a href="#!" class="valign-wrapper">
                            <i class="click-hungry material-icons no-margin tooltipped">
                                verified_user
                            </i>
                        </a>
                    </div>
                </div>
            </div>

            %{-- Painel deleção de grupo --}%
            <div class="row no-margin">
                <div class="row cluster-header">
                    <h4>Remover Grupo</h4>
                    <div class="divider"></div>
                </div>

                <div class="row show" id="disable-group-card">
                    <div class="col s12 m6 l6 offset-m3 offset-l3">
                        <div class="card center">
                            <div class="card-header">
                                <div class="card-title"></div>
                            </div>

                            <div class="card-content">
                                <p>Uma vez que você remover o grupo, não há como voltar atrás.</p>

                                <p>Por favor tenha certeza antes de prosseguir.</p>
                            </div>

                            <div class="card-action">
                                <a href="#confirm-removal-modal" class="waves-effect btn modal-trigger">
                                    Remover este grupo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-wrapper-50">
            <div id="confirm-removal-modal" class="modal remar-modal">
                <div class="modal-content" id="modalContent">
                    <h4>Confirmação de Remoção</h4>
                    <p>Deseja mesmo remover o grupo? Esta ação é irreversível.</p>
                </div>

                <div class="modal-footer" id="modalFooter">
                    <a href="${createLink(controller: 'group', action: 'delete', params: [id: group.id])}" class="modal-action modal-close btn waves-effect waves-light remar-orange">
                        Sim
                    </a>
                    <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">
                        Não
                    </a>
                </div>
            </div>
        </div>

        <g:external dir="css" file="groupManagement.css"/>
        <g:external dir="css" file="jquery.ui.min.css"/>
        <g:javascript src="remar/group/manage-user-group.js"/>
        <g:javascript src="libs/jquery/jquery.ui.min.js"/>
    </body>
</html>
