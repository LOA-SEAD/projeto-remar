<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper row no-margin">

            <!-- Large Displays Navbar -->
            <div class="hide-on-med-and-down">
                <div class="col s6 no-padding valign-wrapper">
                    <ul>
                        <li>
                            <a href="/" class="valign-wrapper">
                                <img src="/images/logo/logo-remar-branco-transparente.png" class="logo" alt="REMAR Logo">
                            </a>
                        </li>
                    </ul>
                </div>

            <sec:ifLoggedIn>

                <div class="col s6 no-padding">
                    <ul class="user-thumbnail">
                        <li>
                            <a href="#!" data-activates="dropdown-user" class="dropdown-button">
                                <p class="no-margin" style="float: left;">
                                    ${session.user.firstName} ${session.user.lastName}
                                </p>
                                <img src="/data/users/${session.user.username}/profile-picture?${new Date()}"
                                     alt="${session.user.firstName}" class="circle profile-pic"
                                     data-beloworigin="true" style="float: left;">
                            </a>

                            <ul id="dropdown-user" class="my-dropdown-menu collection">
                                <li class="collection-item">
                                    <div class="row no-margin-bottom">
                                        <div class="col s8">
                                            <p class="title truncate">${session.user.firstName} ${session.user.lastName}</p>

                                            <p class="secondary-color truncate"
                                               title="${session.user.email}">${session.user.email}</p>
                                        </div>

                                        <div class="col s4">
                                            <img src="/data/users/${session.user.username}/profile-picture?${new Date()}"
                                                 alt="${session.user.firstName}" class="circle responsive-img"
                                                 data-beloworigin="true">
                                        </div>
                                    </div>
                                </li>

                                <li class="collection-item">
                                    <div class="row no-margin">
                                        <div class="col s7">
                                            <a href="/my-profile" class="waves-effect btn-flat remar-orange-text">
                                                ${message (code: 'menu.button.profile.label')}
                                            </a>
                                        </div>

                                        <div class="col s5">
                                            <a href="/logout/index" class="waves-effect btn-flat remar-orange-text">
                                                ${message (code: 'menu.button.logout.label')}
                                            </a>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </sec:ifLoggedIn>
            </div>

            <!-- Small and Medium Displays Navbar -->
            <div class="col s12 no-padding hide-on-large-only">
                <div class="row no-margin">
                    <div class="col s6">
                        <ul>
                            <a id="button-collapse" href="#" data-activates="slide-out"
                               class="button-collapse top-nav full hide-on-large-only">
                                <i class="material-icons small">menu</i>
                            </a>
                        </ul>
                    </div>

                    <div id="small-and-medium-logo" class="col s6 valign-wrapper right-align">
                        <a href="/">
                            <img src="/images/logo/logo-remar-branco-transparente.png" class="small-logo" alt="REMAR Logo">
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </nav>
</div>