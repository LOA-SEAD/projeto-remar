/**
 * Created by Douglas on 05/09/17.
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
        $("#errorImportingInformations").openModal();
    }
};

function _modal_edit(tr){
    var url = location.origin + '/sanjarunner/pergaminhoBanhado/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};

    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var pergaminhoBanhadoInstance = returndata.split("%@!");
                //pergaminhoBanhadoInstance é um vetor com os atributos da classe Information na seguinte ordem:
                // Information[0] - Information[1] - Information[2] - Information[3] - ID

                $("#labelInformation1").attr("class","active");
                $("#labelInformation2").attr("class","active");
                $("#labelInformation3").attr("class","active");
                $("#labelInformation4").attr("class","active");
                $("#editInformation0").attr("value",faseCampoMinadoInstance[0]);
                $("#editInformation1").attr("value",faseCampoMinadoInstance[1]);
                $("#editInformation2").attr("value",faseCampoMinadoInstance[2]);
                $("#editInformation3").attr("value",faseCampoMinadoInstance[3]);
                $("#pergaminhoBanhadoID").attr("value",faseCampoMinadoInstance[4]);
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

//CONSERTAR
/*function exportInformations(){
    var list_id = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

        $.ajax({
            type: "POST",
            traditional: true,
            url: "/sanjarunner/pergaminhoBanhado/exportCSV",
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
}*/

//CONSERTAR
function _submit() {
    var list_id = [];

    //checa se o usuario selecionou exatamente 4 questoes
    /*if($("input[type=checkbox]:checked").size() < 4) {
        $("#errorSaveModal").openModal();
    } else {
        //cria uma lista com os ids de cada questao selecionada
        $.each($("input[type=checkbox]:checked"), function (ignored, el) {*/
            var tr = $(el).parents().eq(1);
            console.log(tr);
            list_id.push($(tr).attr('data-id'));
        //});

        //chama o controlador para criar o arquivo json com as informacoes inseridas
        $.ajax({
            type: "POST",
            traditional: true,
            url: "/sanjarunner/pergaminhoBanhado/exportLevel",
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
    //}
}