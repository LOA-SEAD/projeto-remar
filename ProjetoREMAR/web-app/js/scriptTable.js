/**
 * Created by loa on 19/03/15.
 */

window.onload = function(){
    $('#table').editableTableWidget();

    addListeners();



    $('#create').click(function() {
        var tr = document.createElement('tr');
        tr.setAttribute('data-new', '1');
        tr.setAttribute('data-checked', 'false');
        //tr.setAttribute('class', 'odd'); TODO

        var td1 = document.createElement('td');
        td1.setAttribute('class', '_not_editable');
        var cb = document.createElement('input');
        cb.setAttribute("type", "checkbox");
        cb.setAttribute("class", "checkbox");
        td1.appendChild(cb);


        var td2 = document.createElement('td');
        td2.setAttribute('tabindex', '1');
        td2.setAttribute('class', '_error');

        var td3 = document.createElement('td');
        td3.setAttribute('tabindex', '1');
        td3.setAttribute('class', '_error');
        td3.setAttribute('data-save', '1');

        var td4 = document.createElement('td');
        td4.setAttribute('tabindex', '1');
        td4.textContent = getUserName();

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);
        tr.appendChild(td4);

        var table = document.getElementById('table');

        var tbody = table.getElementsByTagName('tbody')[0];

        tbody.appendChild(tr);

        $('#table').editableTableWidget(); // new tr
        addListeners(); // new tr


    });

    $('#delete').click(function() {
        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        for(var i = 0; i < trs.length; i++) {
            if($(trs[i]).attr('data-checked') == "true") {
                $(trs[i]).addClass('disabled');
                _delete(trs[i]);
            }
        }
    });

    $('#save').click(function () {
        var params = "";
        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        for (var i = 0; i < trs.length; i++) {
            if ($(trs[i]).attr('data-checked') == "true") {
                params += $(trs[i]).attr('data-id') + ',';
            }
        }
        if(params.length) {
            params = params.substr(0, params.length -1);
            window.location.href = "toJson/" + params;
        }
    });

};

function addListeners() {
    var tds = $('td');
    var input = $('input');

    $(tds).on('click', function() {
        if ($(this).hasClass('_not_editable')) {
            return;
        }

        $(this).addClass('_selected');
        if($(this).hasClass('_error')) { // cell is empty
            $(this).removeClass('_error').addClass('_had-error'); // remove error class to prevent shadow overlap
        }
    });

    $(input).on('input', function() {
        if($(this)[0].value == "") { // input is empty
            $(this).addClass('_error'); // red shadow
        } else {
            $(this).removeClass('_error'); // blue shadow (default)
        }
    });

    $(input).on('focusout', function() {
        if($(this).hasClass('_not_editable')) {
            return;
        }
        var el = document.getElementsByClassName('_selected')[0];
        $(el).removeClass('_selected');
        $(el).removeClass('_had-error');
        $(this).removeClass('_error'); // remove error from input (same input will be reused)

        if($(this)[0].value == "") {
            $(el).addClass('_error');
        } else {
            if($(el).parent().attr('data-new')) {
                if($(el).attr('data-save')) {
                    $(el).parent().removeAttr('data-new');
                    $(el).removeAttr('data-save');
                    $(el).textContent = 'test';
                    setTimeout(function() {
                        save($(el).parent());
                    }, 500);
                }
            } else {
                setTimeout(function() {
                    update($(el).parent());
                }, 500);
            }
        }
    });

    $('.checkbox').on('change', function() {
        $(this).parent().parent().attr('data-checked', $(this).prop('checked'));
    });
}

function getUserName() {
    return $("meta[property='user_name']").attr('content');
}

function save(tr) {
    var tds = $(tr).find("td");

    var url = '/ProjetoREMAR/palavras/save/';
    var data = { dica: $(tds)[1].textContent,
                 resposta: $(tds)[2].textContent,
                 contribuicao: $(tds)[3].textContent};

    $.ajax({
        type:'POST',
        data: data,
        url: url,
        success:function(data){
            $(tr).attr('data-id', data.id);
            console.log(data);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}

function update(tr) {
    var tds = $(tr).find("td");

    var url = '/ProjetoREMAR/palavras/update/' + $(tr).attr('data-id');
    var data = { dica: $(tds)[1].textContent,
                 resposta: $(tds)[2].textContent,
                 contribuicao: $(tds)[3].textContent,
                 _method: 'PUT' };

    $.ajax({
        type:'POST',
        data: data,
        url: url,
        success:function(data){
            console.log(data);

        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}

function _delete(tr) {
    var url = '/ProjetoREMAR/palavras/delete/' + $(tr).attr('data-id');
    var data = { _method: 'DELETE' };

    $.ajax({
        type:'POST',
        data: data,
        url: url,
        success:function(data){
            console.log(data);
            $(tr).remove();
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}