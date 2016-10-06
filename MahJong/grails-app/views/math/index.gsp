<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <script>
        window.MathJax = {
            menuSettings: {
                zoom: "None"
            }
        };
    </script>
    <script type="text/javascript"
            src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_SVG">
    </script>

    <g:javascript src="mathquill.min.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mathquill.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mahjong.css')}"/>
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/mahjong/js/materialize.min.js"></script>
    <g:javascript src="iframeResizer.contentWindow.min.js"/>
    <g:javascript src="mahjong.js"/>
</head>

<body>
<div class="container">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            <i class="small material-icons left">grid_on</i>Mahjong - Minha Tabela
        </p>
    </div>

    <div class="main-content">
        <div class="widget">
            <table id="preview-table">
                <tr>
                    <td id="preview-1" class="math preview selectable" data-latex="2^1">$$2^1$$</td>
                    <td id="preview-2" class="math preview selectable" data-latex="\frac{4}{2}">$$\frac{4}{2}$$</td>
                    <td id="preview-3" class="math preview selectable" data-latex="\sqrt{4}">$$\sqrt{4}$$</td>
                    <td id="preview-4" class="math preview selectable" data-latex="\frac{8}{4}">$$\frac{8}{4}$$</td>
                </tr>
                <tr>
                    <td id="preview-5" class="math preview selectable" data-latex="\sqrt{16}">$$\sqrt{16}$$</td>
                    <td id="preview-6" class="math preview selectable" data-latex="2^2">$$2^2$$</td>
                    <td id="preview-7" class="math preview selectable" data-latex="\frac{36}{9}">$$\frac{36}{9}$$</td>
                    <td id="preview-8" class="math preview selectable" data-latex="2^0 + 3^1">$$2^0 + 3^1$$</td>
                </tr>
                <tr>
                    <td id="preview-9" class="math preview selectable" data-latex="\sqrt{36}">$$\sqrt{36}$$</td>
                    <td id="preview-10" class="math preview selectable" data-latex="\frac{24}{4}">$$\frac{24}{4}$$</td>
                    <td id="preview-11" class="math preview selectable" data-latex="3^2 - 3">$$3^2 - 3$$</td>
                    <td id="preview-12" class="math preview selectable" data-latex="\frac{12}{2}">$$\frac{12}{2}$$</td>
                </tr>
                <tr>
                    <td id="preview-13" class="math preview selectable" data-latex="\sqrt{64}">$$\sqrt{64}$$</td>
                    <td id="preview-14" class="math preview selectable" data-latex="2^3">$$2^3$$</td>
                    <td id="preview-15" class="math preview selectable" data-latex="\frac{16}{2}">$$\frac{16}{2}$$</td>
                    <td id="preview-16" class="math preview selectable" data-latex="4+4">$$4+4$$</td>
                </tr>
            </table>
            <br/>
            <br/>
            <br/>

            <div class="row">
                <g:submitButton id="save-and-new" name="create" class="btn btn-success btn-large my-orange"
                                value="Salvar e criar novo nível"/>
                <g:submitButton id="save-and-finish" name="save" class="btn btn-info btn-large my-orange"
                                value="Salvar e finalizar jogo"/>
                <g:submitButton id="new-tr" name="save" class="btn btn-info btn-large my-orange"
                                value="Nova linha"/>
                <g:submitButton id="new-td" name="save" class="btn btn-info btn-large my-orange"
                                value="Nova coluna"/>
            </div>
        </div>
    </div>
</div>

<div id="editableModal" class="modal">
    <div class="modal-content">
        <div class="frame mjax" id="mathOperations">
            <span class="center math latex" data-latex="\sqrt{}">$$\sqrt{□}$$</span>
            <span class="center math latex" data-latex="\sqrt[]{}">$$\sqrt[□]{□}$$</span>
            <span class="center math latex" data-latex="{}^{}">$$□^□$$</span>
            <span class="center math latex" data-latex="\log_{}{}">$$\log_□□$$</span>
            <span class="center math latex" data-latex="\log{}">$$\log□$$</span>
        </div>

        <div class="frame" id="editableCell">
            <span id="mquill" class="center math mathquill-editable"></span> <br><br><br>
            Obs: Expressões muito grandes (mais que 8 caracteres) farão com que o jogo se comporte de maneira inesperada.
        </div>
    </div>
    <div class="modal-footer">
        <a class="btn btn-large modal-close">Salvar</a>
    </div>
</div>
</body>
</html>
