<g:each in="${filteredUserList}" var="user">
    <div class="col s6 m4 l3">
        <div class="card white center">
            <div class="card-content">
                <div class="row" style="margin-bottom: 0px;">
                    <img class="circle profile-picture" src="/images/avatars/default.png"/>
                </div>

                <div class="row" style="margin-bottom: 0px;">
                    ${user.firstName} ${user.lastName}
                    <p class="gray-text ultra-small">${user.email}</p>

                    <p class="gray-text ultra-small">Sexo: <g:if
                            test="${user.gender == 'M' || user.gender == 'male'}">Masculino</g:if><g:else>Feminino</g:else></p>

                    <p class="gray-text ultra-small">${user.username}</p>
                </div>
            </div>
        </div>
    </div>
</g:each>