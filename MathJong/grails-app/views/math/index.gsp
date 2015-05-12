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
    <g:javascript src="mathjong.js"/>
    <g:javascript src="mathquill.min.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mathquill.css')}" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mathjong.css')}" />
</head>
<body>
    <div class="page-header">
        <h1> Minha Tabela</h1>
    </div>
    <div class="main-content">
        <div class="widget">
            <div id="ac">
                <span id="plus">A</span>
                <span id="minus">a</span>
            </div>
            <div class="frame mjax">
                <span class="center math latex" data-latex="\sqrt{}">$$\sqrt{□}$$</span>
                <span class="center math latex" data-latex="\sqrt[]{}">$$\sqrt[□]{□}$$</span>
                <span class="center math latex" data-latex="\frac{}{}">$$\frac{□}{□}$$</span>
                <span class="center math latex" data-latex="{}^{}">$$□^□$$</span>
                <span class="center math latex" data-latex="\log_{}{}">$$\log_□□$$</span>
                <span class="center math latex" data-latex="\log{}">$$\log□$$</span>
            </div>
            <div class="frame">
                <span id="mquill" class="center math mathquill-editable">\sqrt{}</span> <br>
            </div>
            <table id="preview-table" data-next-id="5">
                <tr>
                    <td id="preview-1" class="math preview selectable" data-latex="2^1">$$2^1$$</td>
                    <td id="preview-2" class="math preview selectable" data-latex="\frac{4}{2}">$$\frac{4}{2}$$</td>
                    <td id="preview-3" class="math preview selectable" data-latex="\sqrt{4}">$$\sqrt{4}$$</td>
                    <td id="preview-4" class="math preview selectable" data-latex="\frac{8}{4}">$$\frac{8}{4}$$</td>
                    <td class="new-td">Novo par</td>
                </tr>
                <tr>
                    <td id="preview-5" class="math preview selectable" data-latex="\sqrt{16}">$$\sqrt{16}$$</td>
                    <td id="preview-6" class="math preview selectable" data-latex="2^2">$$2^2$$</td>
                    <td id="preview-7" class="math preview selectable" data-latex="\frac{36}{9}">$$\frac{36}{9}$$</td>
                    <td id="preview-8" class="math preview selectable" data-latex="2^0 + 3^1">$$2^0 + 3^1$$</td>
                    <td class="new-td">Novo par</td>
                </tr>
                <tr>
                    <td id="preview-13" class="math preview selectable" data-latex="\sqrt{36}">$$\sqrt{36}$$</td>
                    <td id="preview-14" class="math preview selectable" data-latex="
                    \frac{24}{4}">$$\frac{24}{4}$$</td>
                    <td id="preview-15" class="math preview selectable" data-latex="2^2 + 2">$$2^2 - 3$$</td>
                    <td id="preview-16" class="math preview selectable" data-latex="\frac{12}{2}">$$\frac{12}{2}$$</td>
                    <td class="new-td">Novo par</td>
                </tr>
                <tr>
                    <td id="preview-9" class="math preview selectable" data-latex="\sqrt{64}">$$\sqrt{64}$$</td>
                    <td id="preview-10" class="math preview selectable" data-latex="2^3">$$2^3$$</td>
                    <td id="preview-11" class="math preview selectable" data-latex="\frac{16}{2}">$$\frac{16}{2}$$</td>
                    <td id="preview-12" class="math preview selectable" data-latex="4+4">$$4+4$$</td>
                    <td class="new-td">Novo par</td>
                </tr>
                <tr class="new-tr">
                    <td class="new-td">Novo par</td>
                </tr>
            </table>
            <br />
            <fieldset class="buttons">
                <g:submitButton id="save-and-new" name="create" class="btn btn-success btn-large" value="Salvar e criar novo nível" />
                <g:submitButton id="save-and-finish" name="save" class="btn btn-info btn-large" value="Salvar e finalizar jogo"/>
                %{--<g:submitButton  name="delete" class="delete" value="Remover questões selecionadas"/>--}%
            </fieldset>
        </div>
    </div>
</body>
</html>
