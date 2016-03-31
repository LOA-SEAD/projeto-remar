/**
 * Created by marcus on 30/03/16.
 */

window.onload = function(){
    $('#BtnUnCheckAll').hide();
    $('.modal-trigger').leanModal();
    $("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody ").find("tr"), function() {
            //console.log($(this).text());
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });

};

function _delete(tr) {
    if(confirm("Você tem certeza que deseja excluir esta questão?")) {
        var tds = $(tr).find("td");
        var url = location.origin + '/RespondaSePuder/question/delete/' + $(tr).attr('data-id');
        var data = {_method: 'DELETE'};
        console.log(tds[1].textContent);
        console.log(url);

        $.ajax({
                type: 'DELETE',
                data: data,
                url: url,
                success: function (data) {
                    $(tr).remove();
                    //uncheck_all();
                    //window.location.reload();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            }
        );


    }
}

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
    console.log("remover todas");
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