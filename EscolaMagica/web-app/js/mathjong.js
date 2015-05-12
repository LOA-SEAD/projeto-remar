/**
 * Created by matheus on 4/16/15.
 */

window.addEventListener("load", function() {
    setMathFontSize(25);

    $("#plus").on("click", function() {
        setMathFontSize(getMathFontSize() + 5);
    });

    $("#minus").on("click", function() {
        setMathFontSize(getMathFontSize() - 5);
    });

    $(".latex").on("click", function() {
        $("#mquill").mathquill("write", $(this).attr("data-latex"));
    });

    $("#mquill").on('keyup', function() {
        var el = $('.selected')[0];
        $(el).attr("data-latex", $(this).mathquill("latex"));
        puthMath(el.id, $(this).mathquill("latex"));
    });

    $(".preview").on("click", function() {
       onClickPreview(this);
    });

    $(".new-td").on("click", function() {
        onClickNewTd(this);
    });

    $("#save-and-new").on("click", function() {
        save(false);
    });

    $("#save-and-finish").on("click", function() {
        save(true);

    });
});

function setMathFontSize(size) {
    if(size > 30) {
        return
    }
    $(".math").css("font-size",size + "px");
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
}

function onClickNewTd(_this) {
    var table = $("#preview-table");
    var newTd = $(_this).clone();
    $(newTd).on("click", function(){ onClickNewTd(this) });

    if($(_this).parent().hasClass("new-tr")) {
        var tr = $(_this).parent().clone();
        $(_this).parent().removeClass("new-tr");
        $(tr).children(":first").on("click", function() {onClickNewTd(this) });
        $(tr).appendTo($(_this).parent().parent());
    }

    for(var i = 0; i < 2; i ++) {
        var td = $("<td>$$\\sqrt{2}$$</td>");
        $(td).attr("id", "preview-" + $(table).attr("data-next-id"));
        $(table).attr("data-next-id", parseInt($(table).attr("data-next-id")) + 1);
        $(td).addClass("math preview selectable");
        $(td).attr("data-latex", "\\sqrt{2}");

        $(td).on("click", function() {onClickPreview(this)});

        $(td).appendTo($(_this).parent());
        $(newTd).appendTo($(_this).parent());

        console.log($(_this).parent());
    }
    $(_this).remove();
    setMathFontSize(getMathFontSize());
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
}

function save(finish) {
    var table = $("#preview-table");
    var nLines = $("tr").length - 1;
    var tds = $(".preview");
    var nCols = (tds.length) / nLines;

    var url = location.origin + '/mathjong/math/save';
    console.log(url);
    var data = { nLines: nLines,
        nCols: nCols };
    var latex = [];
    var i = 0;
    $(tds).each(function () {
        latex[i++] = $(this).attr("data-latex");
    });

    data["latex"] = latex;

    $.ajax({
        async: false,
        type:'GET',
        data: data,
        url: url,
        success:function(data){
            console.log(data);
            if(!finish) {
                window.location.href = location.origin + "/mathjong/math";
            } else {
                window.location.href = location.origin + '/mathjong/math/finish';
            }

        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}