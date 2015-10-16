<g:applyLayout name="base">
    <!DOCTYPE html>
    <html>
    <head>
        <title>REMAR<g:layoutTitle/></title>
        <g:javascript src="layout/dashboard.js"/>
    </head>
    <body>
    <header>
        <nav class="navbar-fixed teal darken-1">
            <div class="container menu">
                <div class="nav-wrapper">
                    <ul class="left  hide-on-med-and-down"">
                        <li class="logo">
                            <a href="/">
                                <img src="/images/logo/logo-remar-branco-transparente.png">
                                     %{--width=200" height="60">--}%
                            </a>
                        </li>
                    </ul>
                    <ul class="right hide-on-large-only">
                        <li class="logo-icon">
                            <a href="/">
                                <img src="/images/logo/favicon.png">
                                %{--width=200" height="60">--}%
                            </a>
                        </li>
                    </ul>
                    <ul id="top-nav-menu" class="right hide-on-med-and-down">
                        <li>
                            <a href="#" data-activates="dropdown-notifications" class=" dropdown-button waves-effect waves-block waves-light">
                                <i class="mdi-social-notifications"></i>
                            </a>

                            <!-- Dropdown Structure -->
                            <ul id="dropdown-notifications" class="dropdown-content collection-content collection">
                                    <li class="collection-item avatar">
                                        <img src="http://materializecss.com/images/yuna.jpg" alt="" class="circle">
                                        <span class="title">Title</span>
                                        <p>First Line
                                            <br> Second Line
                                        </p>
                                        <a href="#!" class="secondary-content"><i class="mdi-action-grade"></i></a>
                                    </li>
                                    <li class="collection-item avatar">
                                        <img src="http://materializecss.com/images/yuna.jpg" alt="" class="circle">
                                        <span class="title">Title</span>
                                        <p>First Line
                                            <br> Second Line
                                        </p>
                                        <a href="#!" class="secondary-content"><i class="mdi-action-grade"></i></a>
                                    </li>
                                    <li class="collection-item avatar">
                                        <img src="http://materializecss.com/images/yuna.jpg" alt="" class="circle">
                                        <span class="title">Title</span>
                                        <p>First Line
                                            <br> Second Line
                                        </p>
                                        <a href="#!" class="secondary-content"><i class="mdi-action-grade"></i></a>
                                    </li>
                            </ul>

                        </li>
                        <li>
                            <a href="#" data-activates="dropdown-settings" class="dropdown-button waves-effect waves-block waves-light">
                                 <i class="material-icons">settings</i>
                            </a>

                            <!-- Dropdown Structure -->
                            <ul id="dropdown-settings" class="collection-content collection">
                                 <li class="collection-item ">
                                     <div>
                                        <span class="setting-item"><i class="left material-icons">code</i>Tornar-se um desenvolvedor</span>
                                         <a href="/resource/index" class="secondary-content">
                                            <i class="material-icons">send</i>
                                         </a>
                                     </div>
                                 </li>
                                <li class="collection-item ">
                                    <div>
                                        <span class="setting-item"><i class="left fa fa-graduation-cap"></i>Vincular conta ao moodle</span>
                                        <a href="/moodle" class="secondary-content">
                                            <i class="material-icons">send</i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="user">
                            <!-- Dropdown user -->
                            <a class="dropdown-button" href='#' data-activates='dropdown-user'>
                                <img src="../data/users/${session.user.username}/profile-picture"
                                    alt="${session.user.firstName}" class="circle responsive-img z-depth-2"
                                     data-beloworigin="true">
                            </a>
                            <!-- Dropdown Structure -->
                            <ul id="dropdown-user" class="collection-content collection">
                                <li class="collection-item">
                                    <div class="user-info info center">
                                        <p class="title">${session.user.firstName} ${session.user.lastName}</p>
                                        <p class="email">${session.user.email} </p>
                                        <a class="btn waves-effect waves-light"><i class="material-icons left icon-button">perm_identity</i>Perfil</a>
                                    </div>
                                    <div class="user-info center">
                                        <img src="../data/users/${session.user.username}/profile-picture"
                                             alt="${session.user.firstName}" class="circle profile-image"
                                             data-beloworigin="true">
                                    </div>

                                </li>
                                <li class="collection-item footer">
                                     <a href="/logout/index" h class="btn btn-cancel waves-effect waves-light"><i class="material-icons left">power_settings_new</i>Sair</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div> <!-- container -->
        </nav>
    </header>

    <div id="main">
        <div class="wrapper">
            <aside id="left-sidebar-nav">
                <ul id="side-nav" class="side-nav fixed leftside-navigation ps-container ps-active-y">

                    <li class="user-details user teal darken-1">
                        <div class="row">
                            <div class="col col s4 m4 l4">
                                <img src="../data/users/${session.user.username}/profile-picture"
                                     alt="${session.user.firstName}" class="circle"
                                     data-beloworigin="true">
                            </div>
                            <div class="col col s8 m8 l8">
                                <a id="profile-btn" class="btn-flat dropdown-button waves-effect waves-light white-text"
                                   href="#" data-activates="profile-dropdown">
                                    ${session.user.firstName}
                                    <i class="right mdi-navigation-arrow-drop-down"></i>
                                </a>
                                <ul id="profile-dropdown" class="collection-content collection">
                                    <li><a href="#"><i class="mdi-action-face-unlock"></i> Profile</a>
                                    </li>
                                    <li><a href="#"><i class="mdi-action-settings"></i> Settings</a>
                                    </li>
                                    <li><a href="#"><i class="mdi-communication-live-help"></i> Help</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li><a href="#"><i class="mdi-hardware-keyboard-tab"></i> Logout</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </li>

                    <li class="logo"></li>

                    <li class="waves-effect waves-block waves-light">
                        %{--<a><i class="fa fa-flag fa-lg"></i> Foo</a>--}%
                        <a href="/" class=""><i class=" medium mdi-action-dashboard"></i>Home</a>
                    </li>
                    <li>
                        <a href="/process/user-processes"><i class="medium material-icons">web</i>Meus processos</a>
                    </li>
                    <li>
                        <a href="/process/pending-tasks"><i class="large material-icons">view_agenda</i>Tarefas pendentes</a>
                    </li>
                </ul> <!-- side-nav -->

                <div class="container">
                    <a id="button-collapse" href="#" data-activates="side-nav" class="button-collapse top-nav full hide-on-large-only">
                        <i class="material-icons small">menu</i>
                    </a>
                </div>
            </aside>

            <section>
                <div class="container">
                    <div id="chart-dashboard">
                        <div class="row">
                            <g:layoutBody/>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    </body>
</g:applyLayout>
