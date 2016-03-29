
<li class="collection-item avatar">
    <input type="hidden" name="user-id" value="${rating.user.id}" id="user-id">
    <img src="/data/users/${rating.user.username}/profile-picture" alt="${rating.user.firstName}" class="circle">

    <g:if test="${rating.user.id == session.user.id}">
        <ul id='dropdown${rating.id}' class='my-dropdown'>
            <li>
                <a href="#!" title="Editar" class="edit-rating" id-rating="${rating.id}">
                    <i class="fa fa-pencil"></i>
                </a>
            </li>
            <li>
                <a href="#!" title="Excluir" class="delete-rating" id-rating="${rating.id}">
                    <i class="fa fa-trash"></i>
                </a>
            </li>
        </ul>
        <a class='right dropdown-button' href='' data-activates='dropdown${rating.id}'>
            <i class="material-icons">more_vert</i>
        </a>
    </g:if>

    <g:if test='${(rating.date - today) < 0}'>
        <p class="title">${rating.user.firstName} <small>- <g:formatDate format="dd/MM/yyyy" date="${rating.date}"/></small></p>
    </g:if>
    <g:else>
        <p class="title">${rating.user.firstName} <small>- <g:formatDate format="HH:mm" date="${rating.date}"/></small></p>
    </g:else>
    <p class="rating-desc">${rating.comment}</p>
    <div id="rateYo${rating.id}" class="left rating-stars" style="display: inline-block;"
         data-stars="${rating.stars}" data-rating-id="${rating.id}" data-medium-stars="${mediumStars}" data-sum-users="${sumUsers}">
    </div>
    <p class="stars-font">${rating.stars /10}</p>
    <div class="clearfix"></div>
</li>
<script>
    $(".dropdown-button").dropdown();
</script>