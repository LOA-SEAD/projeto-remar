/**
 * Created by matheus on 3/18/15.
 */
window.onload = function() {
    $('#table').editableTableWidget();

    $('table tr').on('change', function (evt, newValue) {
        var url = '/ProjetoREMAR/palavras/update/' + $(this).attr('id');
        var data = { dica: evt.currentTarget.cells[0].innerText,
                     resposta:evt.currentTarget.cells[1].innerText,
                     contribuicao:evt.currentTarget.cells[2].innerText,
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