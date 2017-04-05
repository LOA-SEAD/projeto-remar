<g:applyLayout name="base">
      <header>
        <div class="navbar-fixed">
            <nav class="valign-wrapper">
                <div class="hide-on-med-and-down remar-max-size center">
                    <!-- Menu for large displays -->
                    <!-- vrau-->

                    <ul class="left">
                        <li>
                            <a href="/index/project" class="valign-wrapper">
                                <img src="/images/logo/logo-remar-branco-transparente.png" class="logo" />
                            </a>
                        </li>
                    </ul>

                    <ul class="right">
                        <li>
                            <a href="#" data-activates="dropdown-user" class="dropdown-button">
                                <img src="/data/users/${session.user.username}/profile-picture?${new Date()}"
                                     alt="${session.user.firstName}" class="circle profile-pic"
                                     data-beloworigin="true">
                            </a>
                        </li>
                        <ul id="dropdown-user" class="my-dropdown-menu collection">
                            <li class="collection-item left">
                                <div class="row no-margin-bottom">
                                    <div class="col s8 center">
                                        <p class="title truncate">${session.user.firstName} ${session.user.lastName}</p>
                                        <p class="secondary-color truncate" title="${session.user.email}">${session.user.email}</p>
                                    </div>
                                    <div class="col s4">
                                        <img src="/data/users/${session.user.username}/profile-picture?${new Date()}"
                                             alt="${session.user.firstName}" class="circle responsive-img" data-beloworigin="true">
                                    </div>
                                </div>
                            </li>
                            <div class="row collection-item footer" style="margin-top: 115px;">
                                <div class="col s6">
                                    <a href="/my-profile" class="waves-effect btn-flat left">
                                        Meu perfil
                                    </a>
                                </div>
                                <div class="col s6">
                                    <a href="/logout/index" class="waves-effect btn-flat right">
                                        Sair
                                    </a>
                                </div>
                            </div>
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
                            <a href="/index/project">
                                <img src="/images/logo/logo-remar-branco-transparente.png" alt="Logo" class="small-logo" />
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </header>

    <div id="slide-out" class="hide-on-large-only side-nav" style="text-align: left;">
        <g:applyLayout name="menu" />
    </div>

    <div class="remar-max-size center min-height-size margin-top main" style="flex: 1 0 auto;">
        <div class="left-sidebar-nav left hide-on-med-and-down">
            <g:applyLayout name="menu" />
        </div>

        <div class="content min-height-size right">
            <g:layoutBody />
        </div>

    </div>
    <div class="clear"></div>
    <g:applyLayout name="footer" />

</g:applyLayout>
