<g:applyLayout name="base">
    
    <header id="header" class="page-topbar">
        <div class="navbar-fixed">
            <nav class="cyan darken-2">
                <div class="nav-wrapper">
                    <ul class="left">
                        <li>
                            <h1 class="logo-wrapper">
                                <a href="/dashboard" class="brand-logo darken-1">
                                    <img src="/assets/img/logo/logo-remar-branco-transparente.png" alt="Logo do Remar" width="200" height="60" />
                                </a>
                            </h1>
                        </li>
                    </ul>

                    <div class="header-search-wrapper hide-on-med-and-down">
                        <i class="mdi-action-search active"></i>
                        <input type="text" name="search" class="header-search-input z-depth-2" placeholder="Pesquise no REMAR">
                    </div>

                    <ul class="right hide-on-med-and-down">
                        <li><a href="javascript:void(0);" class="waves-effect waves-block waves-light"><i class="mdi-social-notifications"></i></a>
                        </li>
                        <li><a href="#" data-activates="chat-out" class="waves-effect waves-block waves-light chat-collapse"><i class="mdi-communication-chat"></i></a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </header>

    <div id="main">
        <div class="wrapper">
            <aside id="left-sidebar-nav">
                <ul id="slide-out" class="side-nav fixed leftside-navigation ps-container ps-active-y" style="width: 240px;">
                    <li class="user-details cyan darken-2">
                        <div class="row">
                            <div class="col col s4 m4 l4">
                                <img src="/assets/img/inside/avatar.png" alt="Imagem do usuário" class="circle responsive-img valign profile-image" />
                            </div>
                            <div class="col col s8 m8 l8">
                                <a class="btn-flat dropdown-button waves-effect waves-light white-text profile-btn" href="#" data-activates="profile-dropdown">
                                    ${session.user.firstName}
                                    <i class="mdi-navigation-arrow-drop-down right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="bold active">
                        <a href="/dashboard" class="waves-effect waves-cyan">
                            <i class="mdi-action-dashboard"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="bold">
                        <a href="" class="waves-effect waves-cyan">
                            <i class="mdi-action-swap-vert-circle"></i>
                            Meus Processos
                        </a>
                    </li>
                    <li class="bold">
                        <a href="" class="waves-effect waves-cyan">
                            <i class="mdi-editor-insert-comment"></i>
                            Tarefas pendentes
                        </a>
                    </li>
                </ul>
            </aside>

            <section id="content">
                <div class="container">
                    <g:layoutBody/>
                </div>
            </section>
        </div>
    </div>

</g:applyLayout>
