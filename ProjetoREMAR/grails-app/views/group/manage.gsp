<%@ page import="br.ufscar.sead.loa.remar.User;" contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
        <p>Usuários membros do grupo</p>
        <ul>
            <g:each var="user" in="${usersInGroup}">
                <li>${user.name} - ${user.id}</li>
            </g:each>
        </ul>

        <p>Usuários não membros do grupo</p>
        <ul>
            <g:each var="user" in="${usersNotInGroup}">
                <li>${user.name} - ${user.id}</li>
            </g:each>
        </ul>


        <section class="user-management remar-brown">
            <div class="user-selection-box-container">
                <p>Membros do Grupo</p>
                <div class="user-selection-box">
                    <form action="#" id="in-group-form">
                        <div class="user-list-container">
                            <g:each var="user" in="${usersInGroup}">
                                <span>
                                    <input id="checkbox-user-${user.id}" data-user-id="${user.id}" type="checkbox" class="filled-in"/>
                                    <label for="checkbox-user-${user.id}"> ${user.name} (${user.username})</label>
                                </span>
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
                                <span>
                                    <input id="checkbox-user-${user.id}" data-user-id="${user.id}" type="checkbox" class="filled-in"/>
                                    <label for="checkbox-user-${user.id}"> ${user.name} (${user.username})</label>
                                </span>
                            </g:each>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <g:external dir="css" file="groupManagement.css"/>
        <g:javascript src="group/manage-user-group.js"/>
    </body>
</html>
