/**
 * Created by gustavobraghim on 24/02/17.
 */

var list_id_delete = [];


window.onload = function(){
    $("#title").characterCounter();
    $('#BtnUnCheckAll').hide();
    $('.modal-trigger').leanModal();
    $("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody ").find("tr"), function() {
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });

};


function check_all(){
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

function _modal_edit(tr){
    var url = location.origin + '/labteca/anotacao/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var anotacaoInstance = returndata.split("%@!");

                $("#editTitle").attr("value",anotacaoInstance[0]);
                $("#labelTitle").attr("class","active");


                $("#labelAnotacao").attr("class","active");
                $("#editAnotacao0").attr("value",anotacaoInstance[1]);


                $("#labelInformacao").attr("class","active");
                $("#informacao").attr("value",anotacaoInstance[2]);

                $("#AnotacaoID").attr("value",anotacaoInstance[3]);
                $("#editModal").openModal();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
            }
        }
    );
}

function _open_modal_delete() {
    var data;
    list_id_delete = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id_delete.push($(tr).attr('data-id'));
    });

    if(list_id_delete.length<=0){
        $("#erroDeleteModal").openModal();
    }
    else{
        if(list_id_delete.length==1){
            $("#delete-one-question").css("visibility","");
            $("#delete-several-questions").css("visibility","hidden");
        }
        else{
            $("#delete-one-question").css("visibility","hidden");
            $("#delete-several-questions").css("visibility","");
        }
        $('#deleteModal').openModal();
    }
}

function _delete() {
    var url;
    var data;
    var trID;

    if(list_id_delete.length==1){
        url = location.origin + '/LabTecA/anotacao/delete/' + list_id_delete[0];
        data = {_method: 'DELETE'};
        trID = "#tr"+list_id_delete[0];
        $.ajax({
                type: 'DELETE',
                data: data,
                url: url,
                success: function (data) {
                    $(trID).remove();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if(returndata.status == 401) {
                        var url = document.referrer;
                        //url = url.substr(0,url.indexOf('/',7))
                        window.top.location.href = url //+ "/login/auth"
                    } else {
                        alert("Error:\n" + returndata.responseText);
                    }
                }
            }
        );

    } else{
        for(var i=0;i<list_id_delete.length;i++){
            url = location.origin + '/LabTecA/anotacao/delete/' + list_id_delete[i];
            data = {_method: 'DELETE'};
            trID = "#tr"+list_id_delete[i];
            $(trID).remove();
            $.ajax({
                    type: 'DELETE',
                    data: data,
                    url: url,
                    success: function (data) {
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        if(returndata.status == 401) {
                            var url = document.referrer;
                            //url = url.substr(0,url.indexOf('/',7))
                            window.top.location.href = url //+ "/login/auth"
                        } else {
                            alert("Error:\n" + returndata.responseText);
                        }
                    }
                }
            );
        }
        $(trID).remove();
    }
}

function _submit() {
    var list_id = [];

    //checa se o usuario selecionou pelo menos 5 questoes
    if($("input[type=checkbox]:checked").size() < 1) {
        $("#errorSaveModal").openModal();
    } else {
        //cria uma lista com os ids de cada questao selecionada
        $.each($("input[type=checkbox]:checked"), function (ignored, el) {
            var tr = $(el).parents().eq(1);
            list_id.push($(tr).attr('data-id'));
        });

        //chama o controlador para criar o arquivo json com as informacoes inseridas
        $.ajax({
            type: "POST",
            traditional: true,
            url: "/santograu/anotacao/exportAnotacoes",
            data: { list_id: list_id},
            success: function(returndata) {
                window.top.location.href = returndata;
            },
            error: function(returndata) {
                if(returndata.status == 401) {
                    var url = document.referrer;
                    //url = url.substr(0,url.indexOf('/',7))
                    window.top.location.href = url //+ "/login/auth"
                } else {
                    alert("Error:\n" + returndata.responseText);
                }
            }
        });
    }
}
