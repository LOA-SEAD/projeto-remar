<g:applyLayout name="base">

    <header>
        <g:applyLayout name="navbar" />
    </header>

    <div id="slide-out" class="hide-on-large-only side-nav" data-html2canvas-ignore="true">
        <g:applyLayout name="menu" />
    </div>

    <main class="row no-margin">
        <div class="col l2 left-sidebar-nav hide-on-med-and-down">
            <g:applyLayout name="menu" />
        </div>

        <div class="col s12 m12 l10 content">
            <g:layoutBody />
        </div>

    </main>

    <div class="clear"></div>

    <g:applyLayout name="footer" />

</g:applyLayout>
