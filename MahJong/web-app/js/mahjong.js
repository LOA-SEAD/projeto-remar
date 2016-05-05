/**
 * Created by matheus on 4/16/15.
 */

var $jq = jQuery.noConflict();
var MQ = MathQuill.getInterface(2);

$jq(document).ready(function () {
    $jq('.modal-trigger').leanModal();
});

window.addEventListener("load", function () {
    $(".latex").on("click", function () {
        var mathField = MQ($("#mquill")[0]);
        mathField.write($(this).attr("data-latex"));
        mathField.focus();

    });

    $(".preview").on("click", function () {
        onClickPreview(this);
    });

    $("#new-td").on("click", function () {
        onClickNewTd(this);
    });

    $('#new-tr').on('click', function () {
        onClickNewTr(this);
    });

    $("#save-and-new").on("click", function () {
        save(false);
    });

    $("#save-and-finish").on("click", function () {
        save(true);

    });
});

function putMath(idTarget, latex) {
    var math = MathJax.Hub.getAllJax(idTarget)[0];
    $('#' + idTarget).attr('data-latex', latex);
    MathJax.Hub.Queue(["Text", math, latex]);
}

function onClickPreview(el) {
    $(".preview").each(function () {
        $(this).removeClass("selected");
    });
    $(el).addClass("selected");
    $jq("#editableModal").openModal();

    var mquill = $('#mquill');
    $(mquill).text($(el).attr('data-latex'));
    MQ.MathField($(mquill)[0], {
        handlers: {
            edit: function (mathField) {
                putMath($('.selected').attr('id'), mathField.latex());
            }
        }
    });
}

function onClickNewTd(btn) {
    var count = 2;
    var trs = $('tr');
    var id = $('td').length + 1;
    var length = $(trs).first().children().length;

    if (length == 5) {
        $(btn).addClass('tooltipped');
        $(btn).mouseleave(function () { $(btn).addClass('red'); });
        $(btn).attr('data-position', 'top');
        $(btn).attr('data-delay', '50');
        $(btn).attr('data-tooltip', 'A tabela não pode ter mais de 6 colunas');
        $('.tooltipped').tooltip();
    } else if (length == 6) {
        return
    }

    $(trs).each(function () {
        var td = $("<td></td>");
        $(td).attr('id', 'preview-' + id);
        $(td).addClass('math preview selectable');
        $(td).attr('data-latex', count);
        $(td).text('$$' + count + '$$');
        $(td).on("click", function () {
            onClickPreview(this);
        });
        $(this).append(td);

        count += 2;
        id++;
    });

    MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
}

function onClickNewTr(btn) {
    var trs = $('tr');
    var value = $(trs).length * 2 + 2;
    var tr = $(trs).last().clone();
    var id = $(tr).children().last().attr('id');
    id = parseInt(id.substring(id.indexOf('-') + 1)) + 1;

    if ($(trs).length == 5) {
        $(btn).addClass('tooltipped');
        $(btn).mouseleave(function () { $(btn).addClass('red'); });
        $(btn).attr('data-position', 'top');
        $(btn).attr('data-delay', '50');
        $(btn).attr('data-tooltip', 'A tabela não pode ter mais de 6 linhas');
        $('.tooltipped').tooltip();
    } else if ($(trs).length == 6) {
        return
    }

    $(tr).children().each(function () {
        $(this).attr('id', 'preview-' + id);
        $(this).attr('data-latex', value);
        $(this).text('$$' + value + '$$');
        $(this).on("click", function () {
            onClickPreview(this);
        });

        id++;
    });

    $('table').append(tr);

    MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
}

function save(finish) {
    var table = $("#preview-table");
    var nLines = $("tr").length;
    var tds = $(".preview");
    var nCols = (tds.length) / nLines;

    var url = location.origin + '/mahjong/math/save';
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
                window.location.href = location.origin + "/mahjong/math";
            } else {
                window.top.location.href = location.origin + '/mahjong/math/finish';
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        }
    });
}