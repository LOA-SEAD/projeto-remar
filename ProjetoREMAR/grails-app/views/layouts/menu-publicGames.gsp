<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 26/11/15
  Time: 10:32
--%>
<ul class="sidenav" id="side-nav">

    <div class="hide-on-large-only">
        <li class="waves-effect waves-block waves-light">
            <a href="/my-profile"><i class="medium material-icons">account_circle</i>Meu perfil</a>
        </li>

        <div class="divider"></div>
    </div>

    <li class="waves-effect waves-block waves-light">
        <a href="/" class=""><i class="medium mdi-action-dashboard"></i>Início</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os modelos de jogos que são customizáveis." data-step="1">
        <a href="/resource/customizableGames" class=""><i class="medium material-icons">create</i>Modelos</a>
    </li>
    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos disponíveis para jogar." data-step="2">
        <a href="/exportedResource/publicGames" class=""><i class="medium material-icons">videogame_asset</i>Jogos publicados</a>
    </li>

    <div class="divider"></div>

    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra todos os jogos que você já customizou." data-step="3">
        <a href="/exportedResource/myGames" class=""><i class="medium material-icons">recent_actors</i>Meus Jogos</a>
    </li>

    <div class="divider"></div>


    <li class="waves-effect waves-block waves-light" data-intro="Aqui você encontra a documentação dos modelos." data-step="5">
        <a href="https://remar.readme.io/docs" target="_blank"><i class="medium material-icons">description</i>Documentação</a>

    <li class="waves-effect waves-block waves-light" data-intro="Para ver este wizard novamente basta clicar aqui." data-step="6">
        <a onclick="startWizard()" class=""><i class="medium material-icons">live_help</i>Ajuda na navegação</a>
    </li>
</ul>

<script>
    $(".sidenav li a[href='" + window.location.pathname + "']").parent().addClass('active')
</script>