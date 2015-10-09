<g:applyLayout name="base">
    <!DOCTYPE html>
    <html>
    <head>
        <title>REMAR – <g:layoutTitle/></title>
    <g:javascript src="layout/dashboard.js"/>
    </head>
    <body>
    <header>
        <nav class="top-nav fixed">
            <div class="container">
                <div class="nav-wrapper">
                    <a class="page-title"><g:layoutTitle/></a>
                </div>
            </div>
        </nav>
        <div class="container">
            <a href="#" data-activates="side-nav" id="button-collapse" class="button-collapse top-nav full hide-on-large-only">
                <i class="material-icons small">menu</i>
            </a>
        </div> <!-- container -->
        <ul id="side-nav" class="side-nav fixed">
            <li class="logo">
                <a href="/">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </a>
            </li>
            <li>
                <a><i class="material-icons">book</i><span class="align-with-icon-small">Dashboard</span></a>
            </li>
            <li>
                <a><i class="material-icons">book</i><span class="align-with-icon-small">Foo</span></a>
            </li>
            <li>
                <a><i class="material-icons">book</i><span class="align-with-icon-small">Bar</span></a>
            </li>
            <li>
                <a><i class="material-icons">book</i><span class="align-with-icon-small">Qux</span></a>
            </li>
        </ul>
    </header>
    <main>
        <g:layoutBody/>
    </main>
    </body>


</g:applyLayout>
