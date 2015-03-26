/**
 * Created by loa on 19/03/15.
 */

window.onload = function(){
    $('#table').editableTableWidget();
/*
    $('table tr').on('change', function (evt, newValue) {
        var url = '/ProjetoREMAR/palavras/update/' + $(this).attr('id');
        var data = { dica: evt.currentTarget.cells[0].innerText,
            resposta: evt.currentTarget.cells[1].innerText,
            contribuicao: evt.currentTarget.cells[2].innerText,
            _method: 'PUT' };

        console.log(evt.currentTarget.cells[1].innerText);

        console.log(data);
        console.log(url);

        $.ajax({
            type:'POST',
            data: data,
            url: url,
            success:function(data,textStatus){console.log("ok put")},
            error:function(XMLHttpRequest,textStatus,errorThrown){}});

    });
*/

    addListeners();



    $('.save').click(function(){
       console.log("no click");

        var tr = document.createElement('tr');
        tr.setAttribute('data-version', '0');
        //tr.setAttribute('class', 'odd');

        var td1 = document.createElement('td');
        td1.setAttribute('tabindex', '1');
        td1.setAttribute('class', '_error');
        td1.innerHTML = "&nbsp;";

        var td2 = document.createElement('td');
        td2.setAttribute('tabindex', '1');
        td2.setAttribute('class', '_error');
        td2.innerHTML = "&nbsp;";

        var td3 = document.createElement('td');
        td3.setAttribute('tabindex', '1');
        td3.setAttribute('class', '_error');
        td3.innerHTML = "&nbsp;";

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);

        var table = document.getElementById('table');

        var tbody = table.getElementsByTagName('tbody')[0];

        tbody.appendChild(tr);

        $('#table').editableTableWidget(); // new tr
        addListeners(); // new tr


    });
};

function addListeners() {
    var tds = $('td');
    var input = $('input');

    $(tds).on('click', function(e) {
        $(this).addClass('_selected');
        if($(this).hasClass('_error')) { // cell is empty
            $(this).removeClass('_error').addClass('_had-error'); // remove error class to prevent shadow overlap
        }
    });

    $(input).on('input', function(e) {
        if($(this)[0].value == "") { // input is empty
            $(this).addClass('_error'); // red shadow
        } else {
            $(this).removeClass('_error'); // blue shadow (default)
        }
    });

    $(input).on('focusout', function(e) {

        var el = document.getElementsByClassName('_selected')[0];
        $(el).removeClass('_selected');
        $(el).removeClass('_had-error');
        $(this).removeClass('_error'); // remove error from input (same input will be reused)

        if($(this)[0].value == "") {
            $(el).addClass('_error');
        }
    });


}