<g:applyLayout name="base">
    <header>
        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper">
                    <div class="hide-on-med-and-down remar-max-size center">
                        <!-- Menu for large displays -->
                        <ul class="left">
                            <li>
                                <a href="/" class="valign-wrapper">
                                    <img src="/images/logo/logo-remar-branco-transparente.png" class="logo"/>
                                </a>
                            </li>
                        </ul>
                        <ul class="hide-on-med-and-down">
                            <li style="float:right;"><a href="/index/apresentacao">Apresentação</a></li>
                            <li style="float:right;"><a href="/index/arquitetura">Arquitetura</a></li>
                            <li style="float:right;"><a href="/index/equipe">Equipe</a></li>
                            <li style="float:right;"><a href="/index/publicacoes">Publicações</a></li>
                            <li style="float:right;"><a href="/index/contato">Contato</a></li>
                            <li style="float:right;"><a href="/login">Acessar</a></li>
                        </ul>
                    </div>
                    <div class="hide-on-large-only remar-max-size">
                        <ul class="left">
                            <a id="button-collapse" href="#" data-activates="slide-out"
                               class="button-collapse top-nav full hide-on-large-only">
                                <i class="material-icons small">menu</i>
                            </a>
                        </ul>
                        <ul class="right">
                            <li class="logo-icon">
                                <a href="/">
                                    <img src="/images/logo/logo-remar-branco-transparente.png" alt="Logo" class="small-logo"/>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <div class="container remar-max-size center min-height-size margin-top">
        <g:layoutBody />
    </div>

    <g:javascript>
        $(document).ready(function () {
            $(".button-collapse").sideNav();

            $('.dropdown-button').dropdown({
                alignment: 'left'
            });

            $('.collapsible').collapsible();

            $('.tooltipped').tooltip({delay: 50});

            $('select').material_select();

        });

        function startWizard() {
            if (window.innerWidth > 992) { //desktop
                introJs().start();
            }
        }
    </g:javascript>

    <div class="clear"></div>

    <g:applyLayout name="footer" />

</g:applyLayout>