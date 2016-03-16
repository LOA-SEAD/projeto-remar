/**
 * Created by matheus on 9/13/15.
 */

window.addEventListener("load", function() {
    var frame = $("#frame");

    $(frame).load(function() {
        $(this).height($(this).contents().find('html').height());
    });
});