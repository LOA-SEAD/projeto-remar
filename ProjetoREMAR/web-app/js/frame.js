/**
 * Created by matheus on 9/13/15.
 */

window.addEventListener("load", function() {
    var frame = $("#frame");

    if(!window.development) {
        $(frame).load(function() {
            $(this).height($(this).contents().find('html').height());
        });
    }
});

$(document).ready(function() {
    var frame = $("#frame");
    $(frame).height($(document).height() * 2);
});
