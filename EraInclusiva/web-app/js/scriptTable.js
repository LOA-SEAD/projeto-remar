/**
 * Created by loa on 19/03/15.
 */
$(document).ready(function () {


});

window.onload = function(){
   // $('#table').editableTableWidget();

   // addListeners();

    $('#table tr td:not(:last-child)').click(function (event) {
        var tr = this.closest('tr');
        if($(tr).attr('data-checked') == "true") {
            $(tr).attr('data-checked', "false");
            $(':checkbox', this.closest('tr')).prop('checked', false);
        }
        else {
            $(tr).attr('data-checked', "true");
            $(':checkbox', this.closest('tr')).prop('checked', 'checked');
        }

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
            window.top.location.href = "/erainclusiva/resource/toJson/" + params;
        }
        else{
            $('#totalResource').empty();
            $("#totalResource").append("<div> <p> Selecione ao menos uma palavra antes de enviar. </p> </div>");
            $('#infoModal').openModal();
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

}

function getUserName() {
    return $("meta[property='user-name']").attr('content');
}

function getUserId() {
    return $("meta[property='user-id']").attr('content');
}

function save(tr) {
    var tds = $(tr).find("td");

    var url = location.origin + '/erainclusiva/resource/save/';
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

    var url = location.origin + '/erainclusiva/resource/update/' + $(tr).attr('data-id');
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


function _edit(tr){
    var url = location.origin + '/erainclusiva/resource/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var resourceInstance = returndata.split("%@!");
                //resourceInstance é um vetor com os atributos da classe Resource na seguinte ordem:
                // Statement - Answer - author - Category - Version - ownerId - taskId - ID
                $("#editStatement").attr("value",resourceInstance[0]);
                $("#statementLabel").attr("class","active");
                $("#answerLabel").attr("class","active");
                $("#authorLabel").attr("class","active");
                $("#categoryLabel").attr("class","active");

                $("#editAnswer").attr("value",resourceInstance[1]);
                $("#editAuthor").attr("value",resourceInstance[2]);
                $("#editCategory").attr("value",resourceInstance[3]);
                $("#editVersion").attr("value",resourceInstance[4]);
                $("#resourceID").attr("value",resourceInstance[7]);


                $("#editModal").openModal(

                );



            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
            }
        }
    );
}

function _delete() {

    var list_id = [];
    var url;
    var data;
    var trID;

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        alert("Você deve selecionar ao menos uma questão para excluir");
    }
    else{
        if(list_id.length==1){
            if(confirm("Você tem certeza que deseja deletar essa questão?")){
                url = location.origin + '/erainclusiva/resource/delete/' + list_id[0];
                data = {_method: 'DELETE'};
                trID = "#tr"+list_id[0];
                $.ajax({
                        type: 'DELETE',
                        data: data,
                        url: url,
                        success: function (data) {
                            $(trID).remove();
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                        }
                    }
                );
            }
        }
        else{
            if(confirm("Você tem certeza que deseja deletar essas questões?")){
                for(var i=0;i<list_id.length;i++){
                    url = location.origin + '/erainclusiva/resource/delete/' + list_id[i];
                    data = {_method: 'DELETE'};
                    trID = "#tr"+list_id[i];
                    $(trID).remove();
                    $.ajax({
                            type: 'DELETE',
                            data: data,
                            url: url,
                            success: function (data) {
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                            }
                        }
                    );
                }
                $(trID).remove();

            }
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


var x = document.getElementsByName("resource_label");
$(document).on("click", ".selectable_tr", function () {
    //console.log("click event");
    var myNameId = $(this).data('id');
    //var myCheck = $(this).data('checked');
    console.log(myNameId);
    //console.log(myCheck);
    $("#resourceInstance").val( myNameId );
    $('body').on('hidden.bs.modal', '#EditModal', function (e) {
        console.log("entrou aqui");
        $(e.target).removeData("bs.modal");
        $("#EditModal > div > div > div").empty();
    });


});


$( document ).ready(function() {
    $('#BtnUnCheckAll').hide();
    var author = document.getElementById("author");
    author.value = getUserName();
    $('.modal-trigger').leanModal();
});

function check_all(){
    console.log("selecionar todas");
    var CheckAll = document.getElementById("BtnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', 'checked');


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "true");
        }
    }

    $('#BtnCheckAll').hide();
    $('#BtnUnCheckAll').show();




}

function uncheck_all(){
    console.log("selecionar todas");
    var UnCheckAll = document.getElementById("BtnUnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', false);


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "false");
        }
    }

    $('#BtnUnCheckAll').hide();
    $('#BtnCheckAll').show();

}

function exportResources(){
    var list_id = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        alert("Você deve selecionar ao menos uma questão antes de exportar seu banco de questões");
    }
    else{
        $.ajax({
            type: "POST",
            traditional: true,
            url: "/erainclusiva/resource/exportCSV",
            data: { list_id: list_id },
            success: function(returndata) {
                console.log(returndata);
                window.open(location.origin+returndata, '_blank');
            },
            error: function(returndata) {
                alert("Error:\n" + returndata.responseText);


            }
        });
    }

}