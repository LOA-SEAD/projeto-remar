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
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../js/materialize.min.js"></script>
</head>
<body>
<div class="container">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            <i class="small material-icons left">grid_on</i>Minha Tabela
        </p>
    </div>
    <div class="row" id="ac">
        <div class="col s1">
            <span id="plus">A</span>
        </div>
        <div class="col s1">
            <span id="minus">a</span>
        </div>

    </div>
    <div class="main-content">
        <div class="widget">
            <table  id="preview-table" data-next-id="5">
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
                    <td id="preview-14" class="math preview selectable" data-latex="\frac{24}{4}">$$\frac{24}{4}$$</td>
                    <td id="preview-15" class="math preview selectable" data-latex="3^2 - 3">$$3^2 - 3$$</td>
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
            <br />
            <br />
            <fieldset class="buttons">
                <g:submitButton id="save-and-new" name="create" class="btn btn-success btn-large" value="Salvar e criar novo nível" />
                <g:submitButton id="save-and-finish" name="save" class="btn btn-info btn-large" value="Salvar e finalizar jogo"/>
                %{--<g:submitButton  name="delete" class="delete" value="Remover questões selecionadas"/>--}%
            </fieldset>
        </div>
    </div>
</div>

<!-- Modal Structure -->
<div id="editableModal" class="modal">
    <div class="modal-content">
        <div class="frame mjax" id="mathOperations">
            <span class="center math latex" data-latex="\sqrt{}">$$\sqrt{□}$$</span>
            <span class="center math latex" data-latex="\sqrt[]{}">$$\sqrt[□]{□}$$</span>
            <span class="center math latex" data-latex="\frac{}{}">$$\frac{□}{□}$$</span>
            <span class="center math latex" data-latex="{}^{}">$$□^□$$</span>
            <span class="center math latex" data-latex="\log_{}{}">$$\log_□□$$</span>
            <span class="center math latex" data-latex="\log{}">$$\log□$$</span>
        </div>

        <div class="frame" id="editableCell">
            <span id="mquill" class="center math mathquill-editable"></span> <br>
        </div>
    </div>
    <div class="modal-footer">
    </div>
</div>

<script>
    var $jq = jQuery.noConflict();

    $jq( document ).ready(function() {
        $jq('.modal-trigger').leanModal();

    });

    window.addEventListener("load", function () {
        setMathFontSize(25);

        $("#plus").on("click", function () {
            setMathFontSize(getMathFontSize() + 5);

        });

        $("#minus").on("click", function () {
            setMathFontSize(getMathFontSize() - 5);
        });

        $(".latex").on("click", function () {
            $("#mquill").mathquill("write", $(this).attr("data-latex"));
        });

        $("#mquill").on('keyup', function () {
            var el = $('.selected')[0];
            $(el).attr("data-latex", $(this).mathquill("latex"));
            puthMath(el.id, $(this).mathquill("latex"));
        });

        $(".preview").on("click", function () {
            onClickPreview(this);
        });

        $(".new-td").on("click", function () {
            onClickNewTd(this);
        });

        $("#save-and-new").on("click", function () {
            save(false);
        });

        $("#save-and-finish").on("click", function () {
            save(true);

        });
    });

    function setMathFontSize(size) {
        if (size > 30) {
            return
        }
        $(".math").css("font-size", size + "px");
    }

    function getMathFontSize(size) {
        return parseInt($(".math").css("font-size"));
    }

    function puthMath(idTarget, latex) {
        var math = MathJax.Hub.getAllJax(idTarget)[0];
        MathJax.Hub.Queue(["Text", math, latex]);

    }

    function onClickPreview(el) {
        $(".preview").each(function () {
            $(this).removeClass("selected");
        });
        $(el).addClass("selected");
        $("#mquill").mathquill("latex", $(el).attr("data-latex"));
        console.log($(el).attr("data-latex"));
        $jq("#editableModal").openModal();


    }

    function onClickNewTd(_this) {
        var table = $("#preview-table");
        var newTd = $(_this).clone();
        $(newTd).on("click", function () {
            onClickNewTd(this)
        });

        if ($(_this).parent().hasClass("new-tr")) {
            var tr = $(_this).parent().clone();
            $(_this).parent().removeClass("new-tr");
            $(tr).children(":first").on("click", function () {
                onClickNewTd(this)
            });
            $(tr).appendTo($(_this).parent().parent());
        }

        for (var i = 0; i < 2; i++) {
            var td = $("<td>$$\\sqrt{2}$$</td>");
            $(td).attr("id", "preview-" + $(table).attr("data-next-id"));
            $(table).attr("data-next-id", parseInt($(table).attr("data-next-id")) + 1);
            $(td).addClass("math preview selectable");
            $(td).attr("data-latex", "\\sqrt{2}");

            $(td).on("click", function () {
                onClickPreview(this)
            });

            $(td).appendTo($(_this).parent());
            $(newTd).appendTo($(_this).parent());

            console.log($(_this).parent());
        }
        $(_this).remove();
        setMathFontSize(getMathFontSize());
        MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
    }

    function save(finish) {
        var table = $("#preview-table");
        var nLines = $("tr").length - 1;
        var tds = $(".preview");
        var nCols = (tds.length) / nLines;

        var url = location.origin + '/mathjong/math/save';
        console.log(url);
        var data = {
            nLines: nLines,
            nCols: nCols
        };
        var latex = [];
        var i = 0;
        $(tds).each(function () {
            latex[i++] = $(this).attr("data-latex");
        });

        data["latex"] = latex;

        $.ajax({
            async: false,
            type: 'GET',
            data: data,
            url: url,
            success: function (data) {
                console.log(data);
                if (!finish) {
                    window.location.href = location.origin + "/mathjong/math";
                } else {
                    window.location.href = location.origin + '/mathjong/math/finish';
                }

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
</script>
</body>
</html>
