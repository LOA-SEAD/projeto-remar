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
        <script type="text/javascript"
                src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
        </script>
        <g:javascript src="mathjong.js"/>
        <g:javascript src="mathquill.min.js"/>

        <link rel="stylesheet" href="${resource(dir: 'css', file: 'mathquill.css')}" />
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'mathjong.css')}" />
	</head>
	<body>
        <div id="ac">
            <span id="plus">A</span>
            <span id="minus">a</span>
        </div>
        <div class="frame mjax">
            <span class="center math latex" data-latex="\sqrt{}">$$\sqrt{□}$$</span>
            <span class="center math latex" data-latex="\sqrt[]{}">$$\sqrt[□]{□}$$</span>
            <span class="center math latex" data-latex="\frac{}{}">$$\frac{□}{□}$$</span>
            <span class="center math latex" data-latex="x^{}">$$x^□$$</span>
            <span class="center math latex" data-latex="{}^{}">$$□^□$$</span>

        </div>
        <div class="frame">
            <span id="mquill" class="center math mathquill-editable">\frac{\sqrt{2}}{\cos x}\cdot sen\alpha</span> <br>

        </div>
        <div class="preview-frame">
            <span id="preview" class="math" data-latex="{}^{}">$$\frac{\sqrt{2}}{\cos x}\cdot sen\alpha$$</span>
        </div>
	</body>
</html>
