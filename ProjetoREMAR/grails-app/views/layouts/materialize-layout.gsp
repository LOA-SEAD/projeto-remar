<g:applyLayout name="base">
    <script>
        $(document).ready(function() {
            $(".button-collapse").sideNav();

            $('.dropdown-button').dropdown({
                alignment: 'left'
            });
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
                        <li>
                            <a href="#" data-activates="dropdown-settings" class="dropdown-button waves-effect">
                                <i class="material-icons">settings</i>
                            </a>
                        </li>
                        <!-- dropdown-settings -->
                        <ul id="dropdown-settings" class="my-dropdown-menu collection">
                            <li class="collection-item">
                                <a href="/resource/index">
                                    <i class="left material-icons">code</i>
                                    Tornar-se um desenvolvedor
                                </a>
                            </li>
                            <li class="collection-item">
                                <div class="valign-wrapper">
                                    <a href="/resource/index">
                                        <i class="left material-icons">school</i>
                                        Vincular conta ao Moodle
                                    </a>
                                </div>
                            </li>
                        </ul>
                        <li>
                            <a href="#" data-activates="dropdown-user" class="dropdown-button">
                                <img src="../data/users/${session.user.username}/profile-picture"
                                     alt="${session.user.firstName}" class="circle profile-pic"
                                     data-beloworigin="true">
                            </a>
                        </li>
                        <ul id="dropdown-user" class="my-dropdown-menu collection">
                            <li class="collection-item">
                                <div class="row valign-wrapper no-margin-bottom">
                                    <div class="col s8 center">
                                        <p class="title">${session.user.firstName} ${session.user.lastName}</p>
                                        <p class="secondary-color">${session.user.email}</p>
                                    </div>
                                    <div class="col s4">
                                        <img src="../data/users/${session.user.username}/profile-picture"
                                             alt="${session.user.firstName}" class="circle responsive-img" data-beloworigin="true">
                                    </div>
                                </div>
                            </li>
                            <li class="collection-item footer right">
                                <a href="/logout/index" class="btn-flat waves-effect my-orange white-text">
                                    <i class="material-icons left">power_settings_new</i>
                                    Sair
                                </a>
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

    <div id="slide-out" class="hide-on-large-only side-nav" style="text-align: left;">
        <g:applyLayout name="menu" />
    </div>

    <div class="remar-max-size center min-height-size margin-top">
        <div class="left-sidebar-nav left hide-on-med-and-down">
            <g:applyLayout name="menu" />
        </div>

        <div class="content min-height-size right">
            <g:layoutBody />
        </div>
    </div>

</g:applyLayout>
