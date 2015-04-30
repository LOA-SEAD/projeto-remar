/**
 * Created by matheus on 4/29/15.
 */

window.onload = function(){
    console.log("ok");

    $('#save').click(function () {
        var params = "";
        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        for (var i = 0; i < trs.length; i++) {
            console
            if ($(trs[i]).attr('data-checked') == "true") {
                params = $(trs[i]).attr('data-id');
            }
        }
        if(params.length) {
            window.location.href = "choose/" + params;
        }
    });

    $('.checkbox').on('change', function() {
        $(this).parent().parent().attr('data-checked', $(this).prop('checked'));
    });

};