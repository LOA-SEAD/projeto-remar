<g:applyLayout name="base">
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
                        <li>
                            <a href="/login/auth" class="btn btn-microsoft my-orange">Fazer login
                            </a>
                        </li>
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

    <div id="slide-out" class="hide-on-large-only side-nav" style="text-align: left;">
        <g:applyLayout name="menu-publicGames" />
    </div>

    <div class="remar-max-size center min-height-size margin-top main">
        <div class="left-sidebar-nav left hide-on-med-and-down">
            <g:applyLayout name="menu-publicGames" />
        </div>

        <div class="content min-height-size right">
            <g:layoutBody />
        </div>

    </div>
    <div class="clear"></div>
    <g:applyLayout name="footer" />

</g:applyLayout>
