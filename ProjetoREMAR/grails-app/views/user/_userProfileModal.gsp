<div class="user-profile-card-header">
    <img src="/data/users/${user.username}/profile-picture" data-beloworigin="true" alt="Foto de ${user.firstName}"/>
</div>

<div class="user-profile-card-content">
    <h3 class="remar-brown-text">${user.username}</h3>
    <h4 class="remar-brown-text">${user.name}</h4>
    <p>${user.email}</p>
</div>

%{-- TODO: O botão abaixo deve redirecionar para a página de enviar uma mensagem/email para o usuário
<div class="user-profile-card-footer">
    <ul>
        <li>
            <a href="#"><i class="fa fa-envelope remar-orange-text"></i></a>
        </li>
    </ul>
</div>
--}%


<script type="text/javascript">
    $(document).ready(function () {
        $(".user-profile-card-header").parent().addClass("user-profile-card");
    });
</script>

<g:external dir="css" file="user/profileModal.css" />
