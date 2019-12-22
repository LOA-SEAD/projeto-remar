/**
 * Created by leticia on 29/08/16.
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

    if($("#errorImportingQuestions").val() == "true") {
        $("#errorImportingQuestionsModal").openModal();
    }
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
    var url = location.origin + '/santograuinclusivo/faseBiblioteca/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var faseBibliotecaInstance = returndata.split("%@!");
                // faseBibliotecaInstance é um vetor com os atributos da classe Question na seguinte ordem:
                // faseBibliotecaInstance[] = [Tip, Tip, Tip, Answer, ID]

                $("#labelTip1").attr("class","active");
                $("#labelTip2").attr("class","active");
                $("#labelTip3").attr("class","active");
                $("#labelAnswer").attr("class","active");
                $("#editTip1").attr("value",faseBibliotecaInstance[0]);
                $("#editTip2").attr("value",faseBibliotecaInstance[1]);
                $("#editTip3").attr("value",faseBibliotecaInstance[2]);
                $("#editAnswer").attr("value",faseBibliotecaInstance[3]);
                $("#faseBibliotecaID").attr("value",faseBibliotecaInstance[4]);
                $("#editModal").openModal();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
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
        url = location.origin + '/santograuinclusivo/faseBiblioteca/delete/' + list_id_delete[0];
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
                        if(returndata.status == 401) {
                            var url = document.referrer;
                            //url = url.substr(0,url.indexOf('/',7))
                            window.top.location.href = url //+ "/login/auth"
                        } else {
                            alert("Error:\n" + returndata.responseText);
                        }
                    }
                }
            }
        );

    } else{
        for(var i=0;i<list_id_delete.length;i++){
            url = location.origin + '/santograuinclusivo/faseBiblioteca/delete/' + list_id_delete[i];
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
                            if(returndata.status == 401) {
                                var url = document.referrer;
                                //url = url.substr(0,url.indexOf('/',7))
                                window.top.location.href = url //+ "/login/auth"
                            } else {
                                alert("Error:\n" + returndata.responseText);
                            }
                        }
                    }
                }
            );
        }
        $(trID).remove();
    }
}

function exportQuestions(){
    var list_id = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        $("#errorDownloadModal").openModal();
    }
    else{
        $.ajax({
            type: "POST",
            traditional: true,
            url: "/santograuinclusivo/faseBiblioteca/exportCSV",
            data: { list_id: list_id },
            success: function(returndata) {
                console.log(returndata);
                window.open(location.origin + returndata, '_blank');
            },
            error: function(returndata) {
                if(returndata.status == 401) {
                    var url = document.referrer;
                    //url = url.substr(0,url.indexOf('/',7))
                    window.top.location.href = url //+ "/login/auth"
                } else {
                    if(returndata.status == 401) {
                        var url = document.referrer;
                        //url = url.substr(0,url.indexOf('/',7))
                        window.top.location.href = url //+ "/login/auth"
                    } else {
                        alert("Error:\n" + returndata.responseText);
                    }
                }


            }
        });

    }

}

function _submit() {
    var list_id = [];

    //checa se o usuario selecionou no mínimo 3 questoes
    if($("input[type=checkbox]:checked").size() < 3) {
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
            url: "/santograuinclusivo/faseBiblioteca/exportQuestions",
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
                    if(returndata.status == 401) {
                        var url = document.referrer;
                        //url = url.substr(0,url.indexOf('/',7))
                        window.top.location.href = url //+ "/login/auth"
                    } else {
                        alert("Error:\n" + returndata.responseText);
                    }
                }
            }
        });
    }
}
