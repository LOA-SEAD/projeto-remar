<g:applyLayout name="base">
    <!DOCTYPE html>
    <html>
    <head>
        <title>REMAR – <g:layoutTitle/></title>
    <g:javascript src="layout/dashboard.js"/>
    </head>
    <body>
    <header>
        <nav class="top-nav fixed orange">
            <div class="container-dashboard">
                <div class="nav-wrapper">
                    <a class="page-title"><g:layoutTitle/></a>
                </div>
            </div> <!-- container-dashboard -->
        </nav>
        <div class="container-dashboard">
            <a href="#" data-activates="side-nav" id="button-collapse" class="button-collapse top-nav full hide-on-large-only">
                <i class="material-icons small">menu</i>
            </a>
        </div> <!-- container-dashboard -->
        <ul id="side-nav" class="side-nav fixed">
            <li class="logo">
                <a href="/">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </a>
            </li>
            <li>
                <div class="divider"></div>
            </li>
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
    </header>
    <main>
        <g:layoutBody/>
    </main>
    </body>
</g:applyLayout>
