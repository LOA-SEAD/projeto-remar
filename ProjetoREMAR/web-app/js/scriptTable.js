/**
 * Created by loa on 19/03/15.
 */

window.onload = function(){
    $('#table').editableTableWidget();
    console.log("aha");
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
    $('td').on('click', function(evt, newValue) {


        $('input').on('keyup', function (evt, newValue) {

            console.log(this.innerHTML);
            if ($(this).innerHTML == undefined) {
                $(this).removeClass();
                $(this).addClass('error');

            }
            else {
                $(this).removeClass();
                $(this).addClass('fill');
                return true;
            }


        });
    });



    $('.save').click(function(){
       console.log("no click");

        var tr = document.createElement('tr');
        tr.setAttribute('data-version', '0');
        tr.setAttribute('class', 'odd');

        var td1 = document.createElement('td');
        td1.setAttribute('tabindex', '1');
        td1.setAttribute('class','fill')
        td1.setAttribute('placeholder','Resposta da pergunta..')
        td1.innerHTML = '';

        var td2 = document.createElement('td');
        td2.setAttribute('tabindex', '1');
        td2.setAttribute('class','fill')
        td2.setAttribute('placeholder','Resposta da pergunta..')
        td2.innerHTML = '';

        var td3 = document.createElement('td');
        td3.setAttribute('tabindex', '1');
        td3.setAttribute('class','fill')
        td3.setAttribute('placeholder','Resposta da pergunta..')
        td3.innerHTML = '';

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);

        var table = document.getElementById('table');

        var tbody = table.getElementsByTagName('tbody')[0];

        tbody.appendChild(tr);

        $('#table').editableTableWidget();



    });



}