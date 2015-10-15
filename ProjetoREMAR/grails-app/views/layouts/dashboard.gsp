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
                    <ul class="left">
                        <li class="logo">
                            <a href="/">
                                <img src="/assets/img/logo/logo-remar-branco-transparente.png">
                                     %{--width=200" height="60">--}%
                            </a>
                        </li>
                    </ul>
                    <ul id="top-nav-menu" class="right hide-on-med-and-down">
                        <li>
                            <a href="javascript:void(0);" class="waves-effect waves-block waves-light">
                                <i class="mdi-social-notifications"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#" data-activates="chat-out" class="waves-effect waves-block waves-light">
                                 <i class="material-icons">settings</i>
                            </a>
                        </li>
                        <li class="user">
                            <!-- Dropdown user -->
                            <a class="dropdown-button" href='#' data-activates='dropdown-user'>
                                <img src="../data/users/${session.user.username}/profile-picture"
                                    alt="${session.user.firstName}" class="circle responsive-img profile-image z-depth-2"
                                     data-beloworigin="true">
                            </a>
                            <!-- Dropdown Structure -->
                            <ul id="dropdown-user" class="collection-content collection">
                                <li class="collection-item">
                                    <img src="http://materializecss.com/images/yuna.jpg" alt="" class="circle">
                                    <span class="title">Title</span>
                                    <p>First Line
                                        <br> Second Line
                                    </p>
                                    <a class="waves-effect waves-light btn"><i class="material-icons left">cloud</i>button</a>
                                    %{--<a href="#!" class="secondary-content"><i class="mdi-action-grade"></i></a>--}%
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
                <ul id="side-nav" class="side-nav fixed leftside-navigation ps-container ps-active-y"
                    style="width: 240px;">
                    <li>
                        <a><i class="fa fa-flag fa-lg"></i> Foo</a>
                    </li>
                    <li>
                        <a><i class="fa fa-flag fa-lg"></i> Bar</a>
                    </li>
                    <li>
                        <a><i class="fa fa-flag fa-lg"></i> Qux</a>
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
    </body>
</g:applyLayout>
