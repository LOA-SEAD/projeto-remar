<g:applyLayout name="base">

    <header>
        <g:applyLayout name="navbar" />
    </header>

    <ul id="slide-out" class="hide-on-large-only side-nav" data-html2canvas-ignore="true">
        <g:applyLayout name="menu" />
    </ul>

    <main class="row no-margin">
        <div class="col l2 no-padding hide-on-med-and-down">
            <ul id="side-nav" class="sidenav">
                <g:applyLayout name="menu" />
            </ul>
        </div>

        <div class="col s12 m12 l10 content">
            <g:layoutBody />
        </div>

    </main>

    <div class="clear"></div>

    <g:applyLayout name="footer" />

</g:applyLayout>
