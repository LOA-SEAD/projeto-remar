<g:applyLayout name="base">
    <head>
        <g:layoutHead/>
    </head>
    <body>
        <script>
            $(document).ready(function() {
                $(".button-collapse").sideNav();

                $('.dropdown-button').dropdown({
                    alignment: 'left'
                });

                $('.slider').slider();
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
                                <a href="#" data-activates="dropdown-user" class="dropdown-button">
                                    <img src="/data/users/${session.user.username}/profile-picture"
                                         alt="${session.user.firstName}" class="circle profile-pic"
                                         data-beloworigin="true">
                                </a>
                            </li>
                            <ul id="dropdown-user" class="my-dropdown-menu collection">
                                <li class="collection-item left">
                                    <div class="row valign-wrapper no-margin-bottom">
                                        <div class="col s8 center">
                                            <p class="title truncate">${session.user.firstName} ${session.user.lastName}</p>
                                            <p class="secondary-color truncate" title="${session.user.email}">${session.user.email}</p>
                                        </div>
                                        <div class="col s4">
                                            <img src="/data/users/${session.user.username}/profile-picture"
                                                 alt="${session.user.firstName}" class="circle responsive-img" data-beloworigin="true">
                                        </div>
                                    </div>
                                </li>
                                <div class="row collection-item footer" style="margin-top: 115px;">
                                    <div class="col s6">
                                        <a href="/my-profile" class="waves-effect btn-flat left">
                                            <i class="material-icons">account_circle</i>
                                        </a>
                                    </div>
                                    <div class="col s6">
                                        <a href="/logout/index" class="waves-effect btn-flat right">
                                            <i class="material-icons">power_settings_new</i>
                                            %{--Sair--}%
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
                                <a href="/">
                                    <img src="/images/logo/logo-remar-branco-transparente.png" alt="Logo" class="small-logo" />
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </header>

        <div class="remar-max-size center min-height-size margin-top main">
            <g:layoutBody />
        </div>
        <div class="clear"></div>
        <g:applyLayout name="footer" />
    </body>
</g:applyLayout>
