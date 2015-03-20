/**
 * Created by matheus on 3/18/15.
 */
window.onload = function() {
    $('#table').editableTableWidget();

    $('table tr').on('change', function (evt, newValue) {
        var url = '/msg/user/update/' + $(this).attr('id');
        var data = { name: evt.currentTarget.cells[0].innerText,
                     screenName:evt.currentTarget.cells[1].innerText,
                     email:evt.currentTarget.cells[2].innerText,
                     _method: 'PUT' };

        console.log(data);
        console.log(url);

        $.ajax({
            type:'POST',
            data: data,
            url: url,
            success:function(data,textStatus){console.log("ok put")},
            error:function(XMLHttpRequest,textStatus,errorThrown){}});
    });

    $('table td ').on('validate', function (evt, newValue) {
        var pattern = /[a-zA-Z0-9_]\w/;
        console.log(newValue);
        console.log(pattern.test(newValue));
    });
};