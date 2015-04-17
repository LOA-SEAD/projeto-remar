/**
 * Created by matheus on 4/16/15.
 */

window.addEventListener("load", function() {
    setMathFontSize(30);

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
        console.log("press");
        console.log($(this).mathquill('latex'));
        var math = MathJax.Hub.getAllJax("preview")[0];
        MathJax.Hub.Queue(["Text", math, $(this).mathquill('latex')]);
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

function sizes() {
    console.log(
        $("#mquill").width() + "x" + $("#mquill").height() + "\n"
    );

    console.log(
        $(".hidden").width() + "x" + $(".hidden").height() + "\n"
    );
}
