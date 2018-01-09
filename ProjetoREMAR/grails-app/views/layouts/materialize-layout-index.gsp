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
                        <ul class="right">
                            <li class="left"><a href="/index/introduction">Apresentação</a></li>
                            <li class="left"><a href="/index/architecture">Arquitetura</a></li>
                            <li class="left"><a href="/index/team">Equipe</a></li>
                            <li class="left"><a href="/index/publications">Publicações</a></li>
                            <li class="left"><a href="/index/contact">Contato</a></li>
                            <li class="left"><a href="/login">Acessar</a></li>
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
    <main>
    <div class="container remar-max-size center min-height-size margin-top">

        <ul id="slide-out" class="side-nav" style="text-align: left;">
            <li>
                <a href="/index" class="waves-effect">
                    <i class="material-icons">info</i>
                    GT-REMAR
                </a>
            </li>
            <li>
                <a href="/index/apresentacao" class="waves-effect">
                    <i class="material-icons">description</i>
                    Apresentação
                </a>
            </li>
            <li>
                <a href="/index/arquitetura" class="waves-effect">
                    <i class="material-icons">dashboard</i>
                    Arquitetura
                </a>
            </li>
            <li>
                <a href="/index/equipe" class="waves-effect">
                    <i class="fa fa-users"></i>
                    Equipe
                </a>
            </li>

            <li>
                <a href="/index/publicacoes" class="waves-effect">
                    <i class="material-icons">import_contacts</i>
                    Publicações
                </a>
            </li>

            <li>
                <a href="/index/contato" class="waves-effect">
                    <i class="material-icons">email</i>
                    Contato
                </a>
            </li>


            <li>
                <a href="/login" class="waves-effect">
                    <i class="fa fa-sign-in"></i>
                    Acessar
                </a>
            </li>
        </ul>
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
    </main>
    <g:applyLayout name="footer" />

</g:applyLayout>