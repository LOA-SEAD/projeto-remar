<g:applyLayout name="base">
    <script>
        $(document).ready(function() {
            $('.dropdown-button').dropdown({
                alignment: 'left'
            });

            $(".button-collapse").sideNav();
        });
    </script>

    <header>
        <div class="navbar-fixed">
            <nav class="valign-wrapper">
                <div class="hide-on-med-and-down remar-max-size center">
                    <!-- Menu for large displays -->
                    <ul class="left">
                        <li>
                            <a href="/" class="valign-wrapper">
                                <img src="/images/logo/logo-remar-branco-transparente.png" class="logo" />
                            </a>
                        </li>
                    </ul>

                    <ul class="right">
                        <ul class="right hide-on-med-and-down">
                            <li>
                                <a href="/">GT-REMAR</a>
                            </li>
                            <li>
                                <a href="/index/info">Mais informações</a>
                            </li>
                            <li>
                                <a target="_blank" href="http://www.loa.sead.ufscar.br/publicacoes.php">Publicações</a>
                            </li>
                            <li>
                                <a target="_blank" href="https://remar.readme.io/docs">Documentação</a>
                            </li>
                            <li>
                                <a href="/exportedResource/publicGames">Banco de Jogos</a>
                            </li>
                            <li>
                                <a href="/login">Entrar</a>
                            </li>
                        </ul>
                    </ul>
                </div>

                <div class="hide-on-large-only remar-max-size">
                    <ul class="left">
                        <a id="button-collapse" href="#" data-activates="slide-out" class="button-collapse top-nav full hide-on-large-only">
                            <i class="material-icons small">menu</i>
                        </a>
                    </ul>

                    <ul class="right">
                        <li class="logo-icon">
                            <a href="/">
                                <img src="/images/logo/logo-remar-branco-transparente.png" alt="Logo" class="small-logo" />
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </header>


    <div class="remar-max-size center min-height-size margin-top">
        <ul id="slide-out" class="side-nav" style="text-align: left;">
            <li>
                <a href="/" class="waves-effect">
                    <i class="material-icons">help</i>
                    GT-REMAR
                </a>
            </li>
            <li>
                <a href="/index/info" class="waves-effect">
                    <i class="material-icons">info</i>
                    Mais informações
                </a>
            </li>
            <li>
                <a href="http://www.loa.sead.ufscar.br/publicacoes.php" target="_blank" class="waves-effect">
                    <i class="material-icons">library_books</i>
                    Publicações
                </a>
            </li>
            <li>
                <a href="https://remar.readme.io/docs" target="_blank" class="waves-effect">
                    <i class="material-icons">description</i>
                    Documentação
                </a>
            </li>
            <li>
                <a href="/exportedResource/publicGames" class="waves-effect">
                    <i class="material-icons">videogame_asset</i>
                    Jogos Públicos
                </a>
            </li>
            <li>
                <a href="/login" class="waves-effect">
                    <i class="fa fa-sign-in"></i>
                    Entrar
                </a>
            </li>
        </ul>
        <g:layoutBody />
    </div>
</g:applyLayout>
