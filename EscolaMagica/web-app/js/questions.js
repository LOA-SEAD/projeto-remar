$(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal-trigger').leanModal();
    //$('select').material_select();
});


window.onload = function() {
    $('#BtnUnCheckAll').hide();


    $('#table tr td:not(:last-child)').click(function (event) {
        var tr = this.closest('tr');
        if ($(tr).attr('data-checked') == "true") {
            $(tr).attr('data-checked', "false");
            $(':checkbox', this.closest('tr')).prop('checked', false);
        }
        else {
            $(tr).attr('data-checked', "true");
            $(':checkbox', this.closest('tr')).prop('checked', 'checked');
        }


    });


    var x = document.getElementsByName("question_label");
    $(document).on("click", ".selectable_tr", function () {
        var myNameId = $(this).data('id')

        $("#questionInstance").val( myNameId );

        $('body').on('hidden.bs.modal', '#EditModal', function (e) {
            $(e.target).removeData("bs.modal");
            $("#EditModal > div > div > div").empty();
        });

    });



    $(function(){
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
    });

    $('#submitButton').click(function () {
        var list_id = [];
        var questions_level1 = 0;
        var questions_level2 = 0;
        var questions_level3 = 0;
        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        for (var i = 0; i < trs.length; i++) {
            if ($(trs[i]).attr('data-checked') == "true") {

                switch ($(trs[i]).attr('data-level')){
                    case "1":
                        questions_level1 += 1;
                        break;
                    case "2":
                        questions_level2 += 1;
                        break;
                    default :
                        questions_level3 += 1;
                }

                list_id.push(  $(trs[i]).attr('data-id') );
            }
        }


        if(questions_level1 >= 5 && questions_level2 >= 5 && questions_level3 >= 5){
            $.ajax({
                type: "POST",
                traditional: true,
                url: "createXML",
                data: { list_id: list_id },
                success: function(returndata) {
                    window.top.location.href = returndata;
                },
                error: function(returndata) {
                    alert("Error:\n" + returndata.responseText);


                }
            });
        }
        else
        {


            $('#totalQuestion').empty();
            $("#totalQuestion").append("<div> <p> Você deve selecionar no mínimo 5 (cinco) questões de cada nível. </p> </div>");
            $("#totalQuestion").append("<div> <p> Questões nível 1: " + questions_level1 +" . </p> </div>");
            $("#totalQuestion").append("<div> <p> Questões nível 2: " + questions_level2 +" . </p> </div>");
            $("#totalQuestion").append("<div> <p> Questões nível 3: " + questions_level3 +" . </p> </div>");
            $('#infoModal').openModal();


        }

    });

    $('#noSubmitButton').click(function () {
        alert("Você deve criar no mínimo 5 (cinco) questões de cada nível.");
    })



};