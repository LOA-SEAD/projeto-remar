<g:each in="${filteredUserList}" var="user">
    <div class="col s12 m4 l3">
        <div class="card white">
            <div class="card-content">
                <div class="row" style="margin-bottom: 0px;">
                    <div class="col s4">
                        <img class="circle profile-picture" src="/images/avatars/male.png"/>
                    </div>
                    <div class="col s8">
                        ${user.firstName} ${user.lastName}
                        <p class="gray-text ultra-small">${user.email}</p>
                        <p class="gray-text ultra-small">Sexo: <g:if test="${user.gender == 'M'}">Masculino</g:if><g:else>Feminino</g:else></p>
                        <p class="gray-text ultra-small">${user.username}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:each>