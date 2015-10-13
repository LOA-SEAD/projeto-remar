<%--
  Created by IntelliJ IDEA.
  User: Lucas Bocanegra
  Date: 09/10/15
  Time: 16:12
--%>
<g:applyLayout name="base"> <body>

    <header class="page-topbar">
        <div class="navbar-fixed">
            <nav class="cyan">
                <div class="nav-wrapper">
                    <a href="" class="brand-logo">Logo</a>
                    <ul id="nav-mobile" class="right hide-on-med-and-down">
                        <li><a href="">sass</a></li>
                        <li><a href="">sass <span class="new badge">4</span></a></li>
                        <li><a href="">sass</a></li>
                    </ul>
                </div>
            </nav>
        </div>
    </header>

    <div class="wrapper">
        <aside id="left-slide-out">
            <ul id="slide-out" class="side-nav fixed leftside-navigation ps-container ps-active-y">
                <li><a href="#!">First Sidebar Link</a></li>
                <li><a href="#!">Second Sidebar Link</a></li>
                <li class="no-padding">
                    <ul class="collapsible collapsible-accordion">
                        <li>
                            <a class="collapsible-header">Dropdown<i class="mdi-navigation-arrow-drop-down"></i></a>
                            <div class="collapsible-body">
                                <ul>
                                    <li><a href="#!">First</a></li>
                                    <li><a href="#!">Second</a></li>
                                    <li><a href="#!">Third</a></li>
                                    <li><a href="#!">Fourth</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
            <a href="#" data-activates="slide-out" class="sidebar-collapse btn-floating btn-medium waves-effect waves-light hide-on-large-only cyan"><i class="mdi-navigation-menu"></i></a>
        </aside>

        <section id="content">
            <main>
                <div class="container">
                    <div class="row">
                        <div class="col s12 m8 l8">
                            <p>sadsadsa</p>
                        </div>
                    </div>
                </div>
            </main>
        </section>
    </div>


</g:applyLayout>