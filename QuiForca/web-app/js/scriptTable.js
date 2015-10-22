/**
 * Created by loa on 19/03/15.
 */
$(document).ready(function () {
    $("#CheckAll").click(function () {
        var CheckAll = document.getElementById("CheckAll");
        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        $(".checkbox").prop('checked', $(this).prop('checked'));

        if(CheckAll.checked==true){
            for (var i = 0; i < trs.length; i++) {
                $(trs[i]).attr('data-checked', "true");
            }
        }
        else{
            for (var i = 0; i < trs.length; i++) {
                $(trs[i]).attr('data-checked', "false");
            }
        }


    });
});

window.onload = function(){
   // $('#table').editableTableWidget();

    addListeners();



    $('#create').click(function() {
        var tr = document.createElement('tr');
        tr.setAttribute('data-new', '1');
        tr.setAttribute('data-checked', 'false');
        tr.setAttribute('data-owner-id', getUserId());
        //tr.setAttribute('class', 'odd'); TODO

        var td1 = document.createElement('td');
        td1.setAttribute('class', '_not_editable');
        td1.setAttribute("align", "center");
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

        var td4 = document.createElement('td');
        td4.setAttribute('tabindex', '1');
        td4.setAttribute('class', '_error');
        td4.setAttribute('data-save', '1');

        var td5 = document.createElement('td');
        td5.setAttribute('tabindex', '1');
        td5.textContent = getUserName();

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);
        tr.appendChild(td4);
        tr.appendChild(td5);

        var table = document.getElementById('table');

        var tbody = table.getElementsByTagName('tbody')[0];

        tbody.appendChild(tr);

       // $('#table').editableTableWidget(); // new tr
        addListeners(); // new tr


    });

    $('#delete').click(function() {
        if (confirm("Você tem certeza?")) {

        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        console.log(trs.length);
        for (var i = 0; i < trs.length; i++) {
            if ($(trs[i]).attr('data-checked') == "true") {
                $(trs[i]).addClass('disabled');
                _delete(trs[i]);
            }
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
            window.top.location.href = "toJson/" + params;
        }
        else
            alert("Selecione ao menos uma palavra antes de enviar.");
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
    return $("meta[property='user-name']").attr('content');
}

function getUserId() {
    return $("meta[property='user-id']").attr('content');
}

function save(tr) {
    var tds = $(tr).find("td");

    var url = location.origin + '/forca/question/save/';
    var data = { statement: $(tds)[1].textContent,
                 answer: $(tds)[2].textContent,
                 category: $(tds)[3].textContent,
                 author: $(tds)[4].textContent,
                 ownerId: $(tr).attr('data-owner-id')};

    console.log(data);

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

    var url = location.origin + '/forca/question/update/' + $(tr).attr('data-id');
    var data = { statement: $(tds)[1].textContent,
                 answer: $(tds)[2].textContent,
                 category: $(tds)[3].textContent,
                 author: $(tds)[4].textContent,
                 ownerId: $(tr).attr('data-owner-id'),
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

    if(confirm("Você tem certeza que deseja excluir esta questão?")) {
        var tds = $(tr).find("td");
        if ($(tds)[4].textContent == getUserName()) {
            var url = location.origin + '/forca/question/delete/' + $(tr).attr('data-id');
            var data = {_method: 'DELETE'};

            $.ajax({
                    type: 'POST',
                    data: data,
                    url: url,
                    success: function (data) {
                        $(tr).remove();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                }
            );
        }
        else {
            alert("Você não pode excluir uma questão de outro usuário!");
        }
    }
}

$(function(){
    $("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody").find("tr"), function() {
            console.log($(this).text());
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });
});


var x = document.getElementsByName("question_label");
$(document).on("click", ".selectable_tr", function () {
    console.log("click event");
    var myNameId = $(this).data('id');
    var myCheck = $(this).data('checked');
    console.log(myNameId);
    console.log(myCheck);
    $("#questionInstance").val( myNameId );
    $('body').on('hidden.bs.modal', '#EditModal', function (e) {
        console.log("entrou aqui");
        $(e.target).removeData("bs.modal");
        $("#EditModal > div > div > div").empty();
    });


});


$( document ).ready(function() {
    var author = document.getElementById("author");
    author.value = getUserName();
});