/**
 * Created by Douglas on 22/09/17.
 * Based on Santo Grau models (faseCampoMinado and faseTCC)
 */

var list_id_delete = [];

window.onload = function(){
    //$("#title").characterCounter();
    $('.modal-trigger').leanModal();
    /*$("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody ").find("tr"), function() {
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });*/

    if($("#errorImportingInformations").val() == "true") {
        $("#errorImportingInformationsModal").openModal();
    }
};

function _modal_edit(tr){
    var url = location.origin + '/sanjarunner/pergaminhoMatriz/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var pergaminhoMatrizInstance = returndata.split("%@!");
                //pergaminhoMatrizInstance é um vetor com os atributos da classe Information na seguinte ordem:
                // Information[0] - Information[1] - Information[2] - Information[3] - ID

                $("#labelInformation1").attr("class","active");
                $("#labelInformation2").attr("class","active");
                $("#labelInformation3").attr("class","active");
                $("#labelInformation4").attr("class","active");
                $("#editInformation0").attr("value",pergaminhoMatrizInstance[0]);
                $("#editInformation1").attr("value",pergaminhoMatrizInstance[1]);
                $("#editInformation2").attr("value",pergaminhoMatrizInstance[2]);
                $("#editInformation3").attr("value",pergaminhoMatrizInstance[3]);
                $("#pergaminhoMatrizID").attr("value",pergaminhoMatrizInstance[4]);
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

function exportInformations(){
    var list_id = [];

    //cria uma lista com os ids dos textos
    $.each($("[class=selectable_tr]"), function (ignored, el) {
        var tr = $(el);
        console.log(tr);
        list_id.push($(tr).attr('data-id'));
    });

    $.ajax({
        type: "POST",
        traditional: true,
        url: "/sanjarunner/pergaminhoMatriz/exportCSV",
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
                alert("Error:\n" + returndata.responseText);
            }
        }
    });
}

function _submit() {
    var list_id = [];

    //cria uma lista com os ids dos textos
    $.each($("[class=selectable_tr]"), function (ignored, el) {
        var tr = $(el);
        console.log(tr);
        list_id.push($(tr).attr('data-id'));
    });

    //chama o controlador para criar o arquivo txt com as informacoes inseridas
    $.ajax({
        type: "POST",
        traditional: true,
        url: "/sanjarunner/pergaminhoMatriz/exportInformations",
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