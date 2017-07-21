<%@ page import="br.ufscar.sead.loa.remar.User;br.ufscar.sead.loa.remar.Group;" contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
        <div class="row cluster">
            <div class="row">
                <div class="row cluster-header">
                    <h4>Informações de ${group.name}</h4>
                    <div class="divider"></div>
                </div>

                <div class="row show">
                    %{-- Formulário informações de grupo --}%
                    <section class="group-management">
                        <div class="row">
                            <form action="/group/update" name="group-management-form" class="col s12">
                                <div class="row">
                                    <div class="input-field col s12">
                                        <input required id="group-name" name="groupname" value="${group.name}" type="text" class="validate">
                                        <label class="active" for="group-name-input">Nome do Grupo</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field col s12">
                                        <input required id="group-token" name="grouptoken" value="${group.token}" type="text" class="validate">
                                        <label class="active" for="group-token-input">Código de Acesso</label>
                                    </div>
                                </div>
                                <input id="group-id" name="groupid" type="hidden" value="${group.id}">
                                <div class="row">
                                    <div class="input-field col">
                                        <input id="group-management-submit" type="submit" class="waves-effect waves-light btn">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>

            <div class="row">
                <div class="row cluster-header">
                    <h4>Gerenciamento de Membros</h4>
                    <div class="divider"></div>
                </div>

                <div class="row show">
                    %{-- Painel de gerenciamento de usuários --}%
                    <section class="user-management">
                        <div class="user-selection-box-container">
                            <p>Membros do Grupo</p>
                            <div class="user-selection-box">
                                <form action="#" id="in-group-form">
                                    <div class="user-list-container">
                                        <g:each var="user" in="${usersInGroup}">
                                            <g:if test="${!(group.owner.id == session.user.id)}">
                                                <span>
                                                    <input id="checkbox-user-${user.id}" data-user-id="${user.id}" type="checkbox" class="filled-in"/>
                                                    <label for="checkbox-user-${user.id}"> ${user.name} (${user.username})</label>
                                                </span>
                                            </g:if>
                                        </g:each>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="buttons">
                            <a id="remove-btn" class="waves-effect waves-light btn">
                                <span>
                                    <p>Remover</p>
                                    <i class="fa fa-arrow-right"></i>
                                </span>
                            </a>
                            <a id="add-btn" class="waves-effect waves-light btn">
                                <span>
                                    <i class="fa fa-arrow-left"></i>
                                    <p>Adicionar</p>
                                </span>
                            </a>
                        </div>

                        <div class="user-selection-box-container">
                            <p>Usuários do REMAR</p>
                            <div class="user-selection-box">
                                <form action="#" id="off-group-form">
                                    <div class="user-list-container">
                                        <g:each var="user" in="${usersNotInGroup}">
                                            <g:if test="${!(group.owner.id == session.user.id)}">
                                                <span>
                                                    <input id="checkbox-user-${user.id}" data-user-id="${user.id}" type="checkbox" class="filled-in"/>
                                                    <label for="checkbox-user-${user.id}"> ${user.name} (${user.username})</label>
                                                </span>
                                            </g:if>
                                        </g:each>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <g:external dir="css" file="groupManagement.css"/>
        <g:javascript src="group/manage-user-group.js"/>
        <g:javascript src="jquery/jquery.validate.js"/>
    </body>
</html>
