<g:applyLayout name="base">
    <!DOCTYPE html>
    <html>
    <head>
        <title>REMAR<g:layoutTitle/></title>
        <g:javascript src="layout/dashboard.js"/>
    </head>
    <body>
    <header>
        <div class="navbar-fixed">
            <nav class="my-dark-brown">
                <div class="container menu">
                    <div class="nav-wrapper">
                        <ul class="left  hide-on-med-and-down">
                            <li class="logo">
                                <a href="/">
                                    <img src="/images/logo/logo-remar-branco-transparente.png">
                                </a>
                            </li>
                        </ul>
                        <ul class="right hide-on-large-only">
                            <li class="logo-icon">
                                <a href="/">
                                    <img src="/images/logo/favicon.png">
                                </a>
                            </li>
                        </ul>
                        <ul id="top-nav-menu" class="right hide-on-med-and-down">
                            <li>


                                <!-- Dropdown Structure -->
                                <ul id="dropdown-notifications" class="collection-content collection">

                                    <li class="collection-item avatar">
                                        <img src="http://materializecss.com/images/yuna.jpg" alt="" class="circle">
                                        <div>
                                            <span class="setting-item">Nome da tarefa</span>
                                            <a href="/resource/index" class="secondary-content">
                                                <i class="material-icons">send</i>
                                            </a>
                                        </div>
                                    </li>

                                    <li class="collection-item avatar">
                                        <img src="http://materializecss.com/images/yuna.jpg" alt="" class="circle">
                                        <div>
                                            <span class="setting-item">Nome da tarefa</span>
                                            <a href="/moodle" class="secondary-content">
                                                <i class="material-icons left line-height-fixed">send</i>
                                            </a>
                                        </div>
                                    </li>
                                </ul>

                            </li>
                            <li>
                                <a href="#" data-activates="dropdown-settings" class="dropdown-button waves-effect waves-block waves-light">
                                    <i class="material-icons">settings</i>
                                </a>

                                <!-- Dropdown Structure -->
                                <ul id="dropdown-settings" class="settings-menu collection">
                                    <sec:ifNotGranted roles="ROLE_DEV">
                                        <li class="collection-item ">
                                            <a href="/resource/index" class="setting-item my-black-text">
                                                <i class="left material-icons">code</i>
                                                Tornar-se um desenvolvedor
                                            </a>
                                        </li>
                                    </sec:ifNotGranted>
                                    <g:if test="${session.user.moodleUsername == null}">
                                        <li class="collection-item ">
                                            <a href="/resource/index" class="setting-item my-black-text">
                                                <i class="left material-icons">code</i>
                                                Vincular conta ao Moodle
                                            </a>
                                        </li>
                                    </g:if>
                                </ul>
                            </li>
                            <li class="user">
                                <!-- Dropdown user -->
                                <a class="dropdown-button fixed-height" href='#' data-activates='dropdown-user'>
                                    <img src="../data/users/${session.user.username}/profile-picture"
                                         alt="${session.user.firstName}" class="circle responsive-img z-depth-2"
                                         data-beloworigin="true">
                                </a>
                                <!-- Dropdown Structure -->
                                <ul id="dropdown-user" class="user-menu collection">
                                    <li class="collection-item">
                                        <div class="row valign-wrapper no-margin-bottom">
                                            <div class="col s8 center">
                                                <p class="title">${session.user.firstName} ${session.user.lastName}</p>
                                                <p class="my-secondary-color">${session.user.email}</p>
                                            </div>
                                            <div class="col s4">
                                                <img src="../data/users/${session.user.username}/profile-picture"
                                                     alt="${session.user.firstName}" class="circle responsive-img"
                                                     data-beloworigin="true">
                                            </div>
                                        </div>
                                    </li>
                                    <li class="collection-item footer right">
                                        <a href="/logout/index" class="btn-flat waves-effect my-orange white-text">
                                            <i class="material-icons left line-height-fixed">power_settings_new</i>
                                            Sair
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div> <!-- div wrapper end -->
                </div> <!-- container -->
            </nav>
        </div> <!-- div navbar fixed end -->
    </header>

    <div id="main">
        <div class="wrapper">
            <!-- side-nav -->
            <aside id="left-sidebar-nav">
                <ul id="side-nav" class="side-nav fixed leftside-navigation " >

                    <li class="user-details user hide-on-large-only no-hover">
                        <div class="row li-margin valign-wrapper">
                            <div class="col col s4 m4 l4 no-padding-left">
                                <img src="../data/users/${session.user.username}/profile-picture"
                                     alt="${session.user.firstName}" class="circle"
                                     data-beloworigin="true">
                            </div>
                            <div class="col col s8 m8 l8">
                                ${session.user.firstName} ${session.user.lastName}
                            </div>
                        </div>
                    </li>

                    <li class="waves-effect waves-block waves-light hide-on-large-only">
                        <a href="/logout">
                            <i class="fa fa-sign-out"></i>
                            Sair
                        </a>
                    </li>

                    <li class="divider hide-on-large-only"></li>

                    <li class="waves-effect waves-block waves-light">
                        <a href="/" class=""><i class=" medium mdi-action-dashboard"></i>Home</a>
                    </li>
                    <li class="waves-effect waves-block waves-light">
                        <a href="#"><i class="left small material-icons">supervisor_account</i>R.E.A. públicos </a>
                    </li>
                    <li class="waves-effect waves-block waves-light">
                        <a href="#"><i class="left small material-icons">open_in_new</i>R.E.A. personalizáveis </a>
                    </li>
                    <li class="waves-effect waves-block waves-light">
                        <a href="#"><i class="left small material-icons">https</i>Meus R.E.A.</a>
                    </li>
                    <li class="waves-effect waves-block waves-light">
                        <a href="/process/user-processes"><i class="medium material-icons">web</i>Meus processos</a>
                    </li>
                    <li class="waves-effect waves-block waves-light">
                        <a href="/process/pending-tasks"><i class="large material-icons">view_agenda</i>Tarefas pendentes</a>
                    </li>
                </ul>

                <div class="container">
                    <a id="button-collapse" href="#" data-activates="side-nav" class="button-collapse top-nav full hide-on-large-only">
                        <i class="material-icons small">menu</i>
                    </a>
                </div>
            </aside>
            <!-- sidenav end -->

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
